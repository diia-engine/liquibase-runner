--
-- Name: FUNCTION gettransactionid(); Type: FUNCTION; Schema: public; Owner: postgres

CREATE OR REPLACE FUNCTION public.gettransactionid(
	)
    RETURNS xid
    LANGUAGE 'c'
    COST 1
    VOLATILE PARALLEL UNSAFE
AS '$libdir/postgis-3', 'getTransactionID'
;

--
-- Name: FUNCTION addauth(text); Type: FUNCTION; Schema: public; Owner: postgres

CREATE OR REPLACE FUNCTION public.addauth(
	text)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE SECURITY DEFINER PARALLEL UNSAFE
AS $BODY$
DECLARE
	lockid alias for $1;
	okay boolean;
	myrec record;
BEGIN
	-- check to see if table exists
	--  if not, CREATE TEMP TABLE mylock (transid xid, lockcode text)
	okay := 'f';
	FOR myrec IN SELECT * FROM pg_class WHERE relname = 'temp_lock_have_table' LOOP
		okay := 't';
	END LOOP;
	IF (okay <> 't') THEN
		CREATE TEMP TABLE temp_lock_have_table (transid xid, lockcode text);
			-- this will only work from pgsql7.4 up
			-- ON COMMIT DELETE ROWS;
	END IF;

	--  INSERT INTO mylock VALUES ( $1)
--	EXECUTE 'INSERT INTO temp_lock_have_table VALUES ( '||
--		quote_literal(getTransactionID()) || ',' ||
--		quote_literal(lockid) ||')';

	INSERT INTO temp_lock_have_table VALUES (getTransactionID(), lockid);

	RETURN true::boolean;
END;
$BODY$;

--
-- Name: FUNCTION longtransactionsenabled(); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.longtransactionsenabled(
	)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec RECORD;
BEGIN
	FOR rec IN SELECT oid FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		return 't';
	END LOOP;
	return 'f';
END;
$BODY$;

--
-- Name: FUNCTION checkauth(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.checkauth(
	text,
	text,
	text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	schema text;
BEGIN
	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	if ( $1 != '' ) THEN
		schema = $1;
	ELSE
		SELECT current_schema() into schema;
	END IF;

	-- TODO: check for an already existing trigger ?

	EXECUTE 'CREATE TRIGGER check_auth BEFORE UPDATE OR DELETE ON '
		|| quote_ident(schema) || '.' || quote_ident($2)
		||' FOR EACH ROW EXECUTE PROCEDURE CheckAuthTrigger('
		|| quote_literal($3) || ')';

	RETURN 0;
END;
$BODY$;

COMMENT ON FUNCTION public.checkauth(text, text, text)
    IS 'args: a_schema_name, a_table_name, a_key_column_name - Creates a trigger on a table to prevent/allow updates and deletes of rows based on authorization token.';

--
-- Name: FUNCTION checkauth(text, text); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.checkauth(
	text,
	text)
    RETURNS integer
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
 SELECT CheckAuth('', $1, $2)
$BODY$;

COMMENT ON FUNCTION public.checkauth(text, text)
    IS 'args: a_table_name, a_key_column_name - Creates a trigger on a table to prevent/allow updates and deletes of rows based on authorization token.';

--
-- Name: FUNCTION disablelongtransactions(); Type: FUNCTION; Schema: public; Owner: postgres

CREATE OR REPLACE FUNCTION public.disablelongtransactions(
	)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec RECORD;

BEGIN

	--
	-- Drop all triggers applied by CheckAuth()
	--
	FOR rec IN
		SELECT c.relname, t.tgname, t.tgargs FROM pg_trigger t, pg_class c, pg_proc p
		WHERE p.proname = 'checkauthtrigger' and t.tgfoid = p.oid and t.tgrelid = c.oid
	LOOP
		EXECUTE 'DROP TRIGGER ' || quote_ident(rec.tgname) ||
			' ON ' || quote_ident(rec.relname);
	END LOOP;

	--
	-- Drop the authorization_table table
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table' LOOP
		DROP TABLE authorization_table;
	END LOOP;

	--
	-- Drop the authorized_tables view
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables' LOOP
		DROP VIEW authorized_tables;
	END LOOP;

	RETURN 'Long transactions support disabled';
END;
$BODY$;

--
-- Name: FUNCTION enablelongtransactions(); Type: FUNCTION; Schema: public; Owner: postgres

CREATE OR REPLACE FUNCTION public.enablelongtransactions(
	)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	"query" text;
	exists bool;
	rec RECORD;

BEGIN

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists
	THEN
		"query" = 'CREATE TABLE authorization_table (
			toid oid, -- table oid
			rid text, -- row id
			expires timestamp,
			authid text
		)';
		EXECUTE "query";
	END IF;

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists THEN
		"query" = 'CREATE VIEW authorized_tables AS ' ||
			'SELECT ' ||
			'n.nspname as schema, ' ||
			'c.relname as table, trim(' ||
			quote_literal(chr(92) || '000') ||
			' from t.tgargs) as id_column ' ||
			'FROM pg_trigger t, pg_class c, pg_proc p ' ||
			', pg_namespace n ' ||
			'WHERE p.proname = ' || quote_literal('checkauthtrigger') ||
			' AND c.relnamespace = n.oid' ||
			' AND t.tgfoid = p.oid and t.tgrelid = c.oid';
		EXECUTE "query";
	END IF;

	RETURN 'Long transactions support enabled';
END;
$BODY$;

--
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.lockrow(
	text,
	text,
	text,
	text,
	timestamp without time zone)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE
	myschema alias for $1;
	mytable alias for $2;
	myrid   alias for $3;
	authid alias for $4;
	expires alias for $5;
	ret int;
	mytoid oid;
	myrec RECORD;

BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table WHERE expires < now()';

	SELECT c.oid INTO mytoid FROM pg_class c, pg_namespace n
		WHERE c.relname = mytable
		AND c.relnamespace = n.oid
		AND n.nspname = myschema;

	-- RAISE NOTICE 'toid: %', mytoid;

	FOR myrec IN SELECT * FROM authorization_table WHERE
		toid = mytoid AND rid = myrid
	LOOP
		IF myrec.authid != authid THEN
			RETURN 0;
		ELSE
			RETURN 1;
		END IF;
	END LOOP;

	EXECUTE 'INSERT INTO authorization_table VALUES ('||
		quote_literal(mytoid::text)||','||quote_literal(myrid)||
		','||quote_literal(expires::text)||
		','||quote_literal(authid) ||')';

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$BODY$;

--
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.lockrow(
	text,
	text,
	text,
	timestamp without time zone)
    RETURNS integer
    LANGUAGE 'sql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
 SELECT LockRow(current_schema(), $1, $2, $3, $4);
$BODY$;

--
-- Name: FUNCTION lockrow(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
CREATE OR REPLACE FUNCTION public.lockrow(
	text,
	text,
	text,
	text)
    RETURNS integer
    LANGUAGE 'sql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
 SELECT LockRow($1, $2, $3, $4, now()::timestamp+'1:00');
$BODY$;

--
-- Name: FUNCTION lockrow(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres

CREATE OR REPLACE FUNCTION public.lockrow(
	text,
	text,
	text)
    RETURNS integer
    LANGUAGE 'sql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
 SELECT LockRow(current_schema(), $1, $2, $3, now()::timestamp+'1:00');
$BODY$;

--
-- This function is for backward compatibility

CREATE OR REPLACE FUNCTION public.checkauthtrigger()
    RETURNS trigger
    LANGUAGE 'c'
    COST 1
    VOLATILE NOT LEAKPROOF
AS '$libdir/postgis-3', 'check_authorization'
;

--
--

CREATE OR REPLACE FUNCTION public.pgis_geometry_union_finalfn(
	internal)
    RETURNS geometry
    LANGUAGE 'c'
    COST 10000
    VOLATILE PARALLEL SAFE
AS '$libdir/postgis-3', 'pgis_geometry_union_finalfn'
;

--
--

CREATE OR REPLACE FUNCTION public.postgis_extensions_upgrade(
	)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rec record;
	sql text;
	var_schema text;
BEGIN

	FOR rec IN
		SELECT name, default_version, installed_version
		FROM pg_catalog.pg_available_extensions
		WHERE name IN (
			'postgis',
			'postgis_raster',
			'postgis_sfcgal',
			'postgis_topology',
			'postgis_tiger_geocoder'
		)
		ORDER BY length(name) -- this is to make sure 'postgis' is first !
	LOOP --{
		IF rec.installed_version IS NULL THEN
			-- If the support installed by available extension
			-- is found unpackaged, we package it
			IF
				 -- PostGIS is always available (this function is part of it)
				 rec.name = 'postgis'

				 -- PostGIS raster is available if type 'raster' exists
				 OR ( rec.name = 'postgis_raster' AND EXISTS (
							SELECT 1 FROM pg_catalog.pg_type
							WHERE typname = 'raster' ) )

				 -- PostGIS SFCGAL is availble if
				 -- 'postgis_sfcgal_version' function exists
				 OR ( rec.name = 'postgis_sfcgal' AND EXISTS (
							SELECT 1 FROM pg_catalog.pg_proc
							WHERE proname = 'postgis_sfcgal_version' ) )

				 -- PostGIS Topology is available if
				 -- 'topology.topology' table exists
				 -- NOTE: watch out for https://trac.osgeo.org/postgis/ticket/2503
				 OR ( rec.name = 'postgis_topology' AND EXISTS (
							SELECT 1 FROM pg_catalog.pg_class c
							JOIN pg_catalog.pg_namespace n ON (c.relnamespace = n.oid )
							WHERE n.nspname = 'topology' AND c.relname = 'topology') )

				 OR ( rec.name = 'postgis_tiger_geocoder' AND EXISTS (
							SELECT 1 FROM pg_catalog.pg_class c
							JOIN pg_catalog.pg_namespace n ON (c.relnamespace = n.oid )
							WHERE n.nspname = 'tiger' AND c.relname = 'geocode_settings') )
			THEN
				-- Force install in same schema as postgis
				SELECT INTO var_schema n.nspname
				  FROM pg_namespace n, pg_proc p
				  WHERE p.proname = 'postgis_full_version'
					AND n.oid = p.pronamespace
				  LIMIT 1;
				IF rec.name NOT IN('postgis_topology', 'postgis_tiger_geocoder')
				THEN
					sql := pg_catalog.format(
							  'CREATE EXTENSION %1$I SCHEMA %2$I VERSION unpackaged;'
							  'ALTER EXTENSION %1$I UPDATE TO %3$I',
							  rec.name, var_schema, rec.default_version);
				ELSE
					sql := pg_catalog.format(
							 'CREATE EXTENSION %1$I VERSION unpackaged;'
							 'ALTER EXTENSION %1$I UPDATE TO %2$I',
							 rec.name, rec.default_version);
				END IF;
				RAISE NOTICE 'Packaging extension %', rec.name;
				RAISE DEBUG '%', sql;
				EXECUTE sql;
			ELSE
				RAISE NOTICE 'Extension % is not available or not packagable for some reason', rec.name;
			END IF;
		ELSIF rec.default_version != rec.installed_version
		THEN
			sql = 'ALTER EXTENSION ' || rec.name || ' UPDATE TO ' ||
						pg_catalog.quote_ident(rec.default_version)   || ';';
			RAISE NOTICE 'Updating extension % from % to %',
				rec.name, rec.installed_version, rec.default_version;
			RAISE DEBUG '%', sql;
			EXECUTE sql;
		ELSIF (rec.default_version = rec.installed_version AND rec.installed_version ILIKE '%dev') OR
			(public._postgis_pgsql_version() != public._postgis_scripts_pgsql_version())
		THEN
			-- we need to upgrade to next and back
			RAISE NOTICE 'Updating extension % %',
				rec.name, rec.installed_version;
			sql = 'ALTER EXTENSION ' || rec.name || ' UPDATE TO ' ||
						pg_catalog.quote_ident(rec.default_version || 'next')   || ';';
			RAISE DEBUG '%', sql;
			EXECUTE sql;
			sql = 'ALTER EXTENSION ' || rec.name || ' UPDATE TO ' ||
						pg_catalog.quote_ident(rec.default_version)   || ';';
			RAISE DEBUG '%', sql;
			EXECUTE sql;
		END IF;

	END LOOP; --}

	RETURN 'Upgrade completed, run SELECT postgis_full_version(); for details';

END
$BODY$;

--
--

CREATE OR REPLACE FUNCTION public.st_asgeojson(
	r record,
	geom_column text DEFAULT ''::text,
	maxdecimaldigits integer DEFAULT 9,
	pretty_bool boolean DEFAULT false)
    RETURNS text
    LANGUAGE 'c'
    COST 500
    STABLE STRICT PARALLEL SAFE
AS '$libdir/postgis-3', 'ST_AsGeoJsonRow'
;

--
--

CREATE OR REPLACE FUNCTION public.unlockrows(
	text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE
	ret int;
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table where authid = ' ||
		quote_literal($1);

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$BODY$;