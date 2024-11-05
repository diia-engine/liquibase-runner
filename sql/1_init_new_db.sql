CREATE SCHEMA IF NOT EXISTS registry;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA registry;
CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA registry;


-- Type: type_file

-- DROP TYPE IF EXISTS registry.type_file;

CREATE TYPE registry.type_file AS
(
	id text,
	checksum text
);

ALTER TYPE registry.type_file
    OWNER TO postgres;

-- Type: refs

-- DROP TYPE IF EXISTS registry.refs;

CREATE TYPE registry.refs AS
(
	ref_table text,
	ref_col text,
	ref_id text,
	lookup_col text,
	list_delim character(1)
);

ALTER TYPE registry.refs
    OWNER TO postgres;

-- Type: type_operation

-- DROP TYPE IF EXISTS registry.type_operation;

CREATE TYPE registry.type_operation AS ENUM
    ('S', 'I', 'U', 'D');

ALTER TYPE registry.type_operation
    OWNER TO postgres;

-- PROCEDURE: registry.p_load_table_from_csv(text, text, text[], text[])

-- DROP PROCEDURE IF EXISTS registry.p_load_table_from_csv(text, text, text[], text[]);

CREATE OR REPLACE PROCEDURE registry.p_load_table_from_csv(
    IN p_table_name text,
    IN p_file_name text,
    IN p_table_columns text[],
    IN p_target_table_columns text[] DEFAULT NULL::text[]
)
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
BEGIN
    -- Do nothing
    RETURN;
END;
$BODY$;
ALTER PROCEDURE registry.p_load_table_from_csv(text, text, text[], text[])
    OWNER TO postgres;

GRANT EXECUTE ON PROCEDURE registry.p_load_table_from_csv(text, text, text[], text[]) TO PUBLIC;

GRANT EXECUTE ON PROCEDURE registry.p_load_table_from_csv(text, text, text[], text[]) TO application_role;

GRANT EXECUTE ON PROCEDURE registry.p_load_table_from_csv(text, text, text[], text[]) TO postgres;

GRANT EXECUTE ON PROCEDURE registry.p_load_table_from_csv(text, text, text[], text[]) TO registry_owner_role;


-- PROCEDURE: registry.p_raise_notice(text)

-- DROP PROCEDURE IF EXISTS registry.p_raise_notice(text);

CREATE OR REPLACE PROCEDURE registry.p_raise_notice(
	IN p_string_to_log text)
LANGUAGE 'plpgsql'
    SECURITY DEFINER 
    SET search_path=registry, public, pg_temp
AS $BODY$
BEGIN
--  RAISE NOTICE '%', p_string_to_log;
END;
$BODY$;
ALTER PROCEDURE registry.p_raise_notice(text)
    OWNER TO postgres;

GRANT EXECUTE ON PROCEDURE registry.p_raise_notice(text) TO PUBLIC;

GRANT EXECUTE ON PROCEDURE registry.p_raise_notice(text) TO application_role;

GRANT EXECUTE ON PROCEDURE registry.p_raise_notice(text) TO postgres;

GRANT EXECUTE ON PROCEDURE registry.p_raise_notice(text) TO registry_owner_role;

--
-- TOC entry 2210 (class 1247 OID 26333)
-- Name: dn_edrpou; Type: DOMAIN; Schema: registry; Owner: registry_owner_role
--

CREATE DOMAIN registry.dn_edrpou AS text
	CONSTRAINT edrpou_chk CHECK ((VALUE ~ '^\d{8}|\d{9}|\d{10}$'::text));


ALTER DOMAIN registry.dn_edrpou OWNER TO registry_owner_role;

--
-- TOC entry 2206 (class 1247 OID 26330)
-- Name: dn_passport_num; Type: DOMAIN; Schema: registry; Owner: registry_owner_role
--

CREATE DOMAIN registry.dn_passport_num AS character(8)
	CONSTRAINT passport_number_chk CHECK ((VALUE ~ '^[АВЕІКМНОРСТХ]{2}\d{6}$'::text));


ALTER DOMAIN registry.dn_passport_num OWNER TO registry_owner_role;

CREATE OR REPLACE FUNCTION registry.f_trg_check_m2m_integrity()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF SECURITY DEFINER
    SET search_path=registry, public, pg_temp
AS $BODY$
declare
    v_field_for_check text;
    v_id_for_check    text;
    v_id_new          text;
    v_table           text;
    v_array_field     text;
    v_is_value_found  integer;
begin
    -- set local variables
    v_field_for_check := tg_argv[0];
    execute 'select $1.' || v_field_for_check into v_id_for_check using old;
    execute 'select $1.' || v_field_for_check into v_id_new using new;
    v_table := tg_argv[1];
    v_array_field := tg_argv[2];
    -- if check needed
    if tg_op = 'DELETE' or tg_op = 'UPDATE' and v_id_for_check <> v_id_new then
        -- check if value exists in reference table
        execute 'select 1 from ' || v_table || ' where ''' || v_id_for_check || ''' = any(' || v_array_field || ') limit 1' into v_is_value_found;
        if v_is_value_found is not null then
            raise exception '% = ''%'' in "%" is used in "%.%". Operation % is aborted.', v_field_for_check, v_id_for_check, tg_table_name, v_table, v_array_field, tg_op;
        end if;
    end if;
    -- return
    if tg_op = 'DELETE' then
        return old;
    else
        return new;
    end if;
end;
$BODY$;

ALTER FUNCTION registry.f_trg_check_m2m_integrity()
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION registry.f_trg_check_m2m_integrity() TO PUBLIC;

GRANT EXECUTE ON FUNCTION registry.f_trg_check_m2m_integrity() TO application_role;

GRANT EXECUTE ON FUNCTION registry.f_trg_check_m2m_integrity() TO postgres;

GRANT EXECUTE ON FUNCTION registry.f_trg_check_m2m_integrity() TO registry_owner_role;

