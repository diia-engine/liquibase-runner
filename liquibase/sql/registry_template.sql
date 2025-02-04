--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.6

-- Started on 2025-02-03 14:29:50 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE registry_template;
--
-- TOC entry 4500 (class 1262 OID 16656)
-- Name: registry_template; Type: DATABASE; Schema: -; Owner: registry_template_owner_role
--

CREATE DATABASE registry_template WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf-8';


ALTER DATABASE registry_template OWNER TO registry_template_owner_role;

\connect registry_template

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 11 (class 2615 OID 19124)
-- Name: archive; Type: SCHEMA; Schema: -; Owner: registry_owner_role
--

CREATE SCHEMA archive;


ALTER SCHEMA archive OWNER TO registry_owner_role;

--
-- TOC entry 13 (class 2615 OID 19451)
-- Name: registry; Type: SCHEMA; Schema: -; Owner: registry_owner_role
--

CREATE SCHEMA registry;


ALTER SCHEMA registry OWNER TO registry_owner_role;

--
-- TOC entry 6 (class 3079 OID 19345)
-- Name: file_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS file_fdw WITH SCHEMA public;


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION file_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION file_fdw IS 'foreign-data wrapper for flat file access';


--
-- TOC entry 3 (class 3079 OID 19125)
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- TOC entry 4 (class 3079 OID 19253)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- TOC entry 2 (class 3079 OID 16390)
-- Name: pgaudit; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgaudit WITH SCHEMA public;


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgaudit; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgaudit IS 'provides auditing functionality';


--
-- TOC entry 7 (class 3079 OID 19454)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 5 (class 3079 OID 19334)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1714 (class 1247 OID 19369)
-- Name: refs; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.refs AS (
	ref_table text,
	ref_col text,
	ref_id text,
	lookup_col text,
	list_delim character(1)
);


ALTER TYPE public.refs OWNER TO postgres;

--
-- TOC entry 1723 (class 1247 OID 19380)
-- Name: type_access_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_access_role AS (
	data_column_name text,
	access_role text[]
);


ALTER TYPE public.type_access_role OWNER TO postgres;

--
-- TOC entry 1717 (class 1247 OID 19371)
-- Name: type_classification_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_classification_enum AS ENUM (
    'private',
    'confidential'
);


ALTER TYPE public.type_classification_enum OWNER TO postgres;

--
-- TOC entry 1720 (class 1247 OID 19377)
-- Name: type_classification; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_classification AS (
	data_column_name text,
	data_classification public.type_classification_enum
);


ALTER TYPE public.type_classification OWNER TO postgres;

--
-- TOC entry 1711 (class 1247 OID 19360)
-- Name: type_dml; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_dml AS ENUM (
    'I',
    'U',
    'D'
);


ALTER TYPE public.type_dml OWNER TO postgres;

--
-- TOC entry 1726 (class 1247 OID 19383)
-- Name: type_file; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_file AS (
	id text,
	checksum text
);


ALTER TYPE public.type_file OWNER TO postgres;

--
-- TOC entry 1786 (class 1247 OID 20503)
-- Name: type_object; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_object AS ENUM (
    'table',
    'search_condition'
);


ALTER TYPE public.type_object OWNER TO postgres;

--
-- TOC entry 1708 (class 1247 OID 19351)
-- Name: type_operation; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_operation AS ENUM (
    'S',
    'I',
    'U',
    'D'
);


ALTER TYPE public.type_operation OWNER TO postgres;

--
-- TOC entry 1065 (class 1255 OID 20508)
-- Name: f_check_permissions(text, text[], public.type_operation, text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_check_permissions(p_object_name text, p_roles_arr text[], p_operation public.type_operation DEFAULT 'S'::public.type_operation, p_columns_arr text[] DEFAULT NULL::text[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  c_unit_name text := 'f_check_permissions';
  l_ret BOOLEAN;
  l_is_role_found integer;
BEGIN

  call p_raise_notice(format('%s: p_object_name [%s]', c_unit_name, p_object_name));
  call p_raise_notice(format('%s: p_roles_arr (list of user roles) [%s]', c_unit_name, p_roles_arr));
  call p_raise_notice(format('%s: p_operation [%s]', c_unit_name, p_operation));
  call p_raise_notice(format('%s: p_columns_arr (list of updated columns) [%s]', c_unit_name, p_columns_arr));

  -- check list of user roles
  if p_roles_arr is not null and cardinality(p_roles_arr) = 4 then
    select 1
      into l_is_role_found
      from (select unnest(p_roles_arr) as role) as t
      where t.role is not null
      limit 1;
    if l_is_role_found is null then
      call p_raise_notice(format('%s: list of user roles has four null elements => system role marker => rbac check is skipped', c_unit_name));
      return true;
    end if;
  end if;

  -- check if table is RBAC regulated
  SELECT count(1) = 0 INTO l_ret FROM (SELECT 1 FROM ddm_role_permission WHERE object_name = p_object_name LIMIT 1) s;
  IF l_ret THEN
    call p_raise_notice(format('%s: table [%s] is not RBAC regiulated => rbac check is skipped', c_unit_name, p_object_name));
    RETURN l_ret;
  END IF;

  -- check permission for all columns
  call p_raise_notice(format('%s: list of user roles for check [%s]', c_unit_name, array_append(p_roles_arr,'isAuthenticated')));
  SELECT count(1) > 0 INTO l_ret FROM ddm_role_permission
  WHERE object_name = p_object_name AND operation = p_operation AND role_name = ANY(array_append(p_roles_arr,'isAuthenticated')) AND trim(coalesce(column_name, '')) = '';
  --
  if l_ret then
    call p_raise_notice(format('%s: table [%s], operation [%s], one of user roles found => access permitted', c_unit_name, p_object_name, p_operation));
    return l_ret;
  elsif not l_ret and p_operation in ('S', 'I', 'D') then
    call p_raise_notice(format('%s: table [%s], operation [%s], none of user roles found => access denied', c_unit_name, p_object_name, p_operation));
    return l_ret;
  end if;

  -- we are here if operation = U and permission for all columns is not set

  -- check the list of updated columns
  if p_columns_arr is null or cardinality(p_columns_arr) = 0 then
    call p_raise_notice(format('%s: table [%s], operation [%s], none of user roles found, list of updated columns is empty => access denied', c_unit_name, p_object_name, p_operation));
    return false;
  end if;

  -- check permissions per column
  SELECT count(DISTINCT column_name) = array_length(p_columns_arr, 1) INTO l_ret FROM ddm_role_permission
  WHERE object_name = p_object_name AND operation = p_operation AND role_name = ANY(array_append(p_roles_arr,'isAuthenticated')) AND column_name = ANY(p_columns_arr);
  --
  call p_raise_notice(format('%s: table [%s], operation [%s] => access ' || case when l_ret then 'permitted' else 'denied' end, c_unit_name, p_object_name, p_operation));
  RETURN l_ret;

END;
$$;


ALTER FUNCTION public.f_check_permissions(p_object_name text, p_roles_arr text[], p_operation public.type_operation, p_columns_arr text[]) OWNER TO postgres;

--
-- TOC entry 1068 (class 1255 OID 20509)
-- Name: f_check_permissions_dcm(text, text, uuid, text[], text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_check_permissions_dcm(p_table_name text, p_key_name text, p_uuid uuid, p_columns_arr text[], p_roles_arr text[], OUT r_is_check_passed boolean, OUT r_columns4rbac_arr text[]) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
declare
  c_unit_name       text := 'f_check_permissions_dcm';
  l_sql             text;
  l_column_name     text;
  l_dcm_access_role type_access_role[];
  i                 record;
begin

  call p_raise_notice(format('%s: p_table_name [%s]', c_unit_name, p_table_name));
  call p_raise_notice(format('%s: p_key_name [%s]', c_unit_name, p_key_name));
  call p_raise_notice(format('%s: p_uuid [%s]', c_unit_name, p_uuid));
  call p_raise_notice(format('%s: p_columns_arr (list of updated columns) [%s]', c_unit_name, p_columns_arr));
  call p_raise_notice(format('%s: p_roles_arr (list of user roles) [%s]', c_unit_name, p_roles_arr));

  r_is_check_passed := true;
  r_columns4rbac_arr := p_columns_arr;

  -- check if dcm_access_role column exists in p_table_name
  l_sql := 'select column_name
              from information_schema.columns
              where table_schema = ''registry''
                and table_name = ''' || p_table_name || '''
                and column_name = ''dcm_access_role''
           ';
  execute l_sql into l_column_name;

  if l_column_name is null then
    call p_raise_notice(format('%s: column [dcm_access_role] not found in table [%s] => dcm check is skipped', c_unit_name, p_table_name));
    return;
  end if;


  -- get dcm_access_role value
  l_sql := 'select dcm_access_role from ' || p_table_name || ' where ' || p_key_name || ' = ''' || p_uuid || '''';
  execute l_sql into l_dcm_access_role;

  -- check if dcm_access_role is empty
  call p_raise_notice(format('%s: l_dcm_access_role [%s]', c_unit_name, l_dcm_access_role));
  call p_raise_notice(format('%s: cardinality(l_dcm_access_role) [%s]', c_unit_name, cardinality(l_dcm_access_role)));
  if l_dcm_access_role is null or cardinality(l_dcm_access_role) = 0 then
    call p_raise_notice(format('%s: dcm_access_role is empty => dcm check is skipped', c_unit_name));
    return;
  end if;


  -- check permissions for columns specified in data_column_name
  foreach i in array l_dcm_access_role loop
    call p_raise_notice(format('%s: i.data_column_name [%s], i.access_role[%s]', c_unit_name, i.data_column_name, i.access_role));

    if trim(coalesce(i.data_column_name, '')) = '' then
      call p_raise_notice(format('%s: data_column_name is empty => skip', c_unit_name));
      continue;
    end if;

    if not (i.data_column_name = any(p_columns_arr)) then
      call p_raise_notice(format('%s: column [%s] not found in the list of updated columns => skip', c_unit_name, i.data_column_name));
      continue;
    end if;

    -- NB. i.access_role is not checked for null or empty

    if p_roles_arr is null or cardinality(p_roles_arr) = 0 or not (p_roles_arr && i.access_role) then
      call p_raise_notice(format('%s: column [%s], ' || case when p_roles_arr is null or cardinality(p_roles_arr) = 0 then
                                                               'list of user roles is empty'
                                                             else
                                                               'none of user roles found in access_role'
                                                        end || ' => access denied', c_unit_name, i.data_column_name));
      r_is_check_passed := false;
      return;
    end if;

    -- access permitted => exclude i.data_column_name from the list of updated columns for further checks
    call p_raise_notice(format('%s: column [%s], one of user roles found in access_role => access permitted', c_unit_name, i.data_column_name));
    r_columns4rbac_arr := array_remove(r_columns4rbac_arr, i.data_column_name);

  end loop;

  call p_raise_notice(format('%s: r_columns4rbac_arr [%s]', c_unit_name, r_columns4rbac_arr));
  return;
end;
$$;


ALTER FUNCTION public.f_check_permissions_dcm(p_table_name text, p_key_name text, p_uuid uuid, p_columns_arr text[], p_roles_arr text[], OUT r_is_check_passed boolean, OUT r_columns4rbac_arr text[]) OWNER TO postgres;

--
-- TOC entry 1069 (class 1255 OID 20510)
-- Name: f_edrpou_is_correct(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_edrpou_is_correct(character) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
BEGIN
  RETURN true;
END;
$$;


ALTER FUNCTION public.f_edrpou_is_correct(character) OWNER TO postgres;

--
-- TOC entry 1070 (class 1255 OID 20511)
-- Name: f_get_id_from_ref_array_table(text, text, text, text, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_id_from_ref_array_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text, p_delim character) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_ret TEXT;
  l_arr_lookup TEXT[];
  l_arr_id TEXT[];
begin
  -- get lookup values from the list
  l_arr_lookup := string_to_array(rtrim(ltrim(p_lookup_val,'{'),'}'),p_delim);
  CALL p_raise_notice(l_arr_lookup::text);
  -- build up an appropriate uuid list
  IF l_arr_lookup IS NOT NULL THEN
    FOR i IN 1..array_upper(l_arr_lookup, 1) loop
      l_arr_id[i] := f_get_id_from_ref_table(p_ref_table, p_ref_col, p_ref_id, trim(l_arr_lookup[i],' '));
      l_ret := array_to_string(l_arr_id,',');
    END LOOP;
  END IF;
  --
  RETURN l_ret;
END;
$$;


ALTER FUNCTION public.f_get_id_from_ref_array_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text, p_delim character) OWNER TO postgres;

--
-- TOC entry 1071 (class 1255 OID 20512)
-- Name: f_get_id_from_ref_table(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_id_from_ref_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_sql TEXT;
  l_ret TEXT;
BEGIN
  IF p_lookup_val IS NULL THEN
    RETURN NULL;
  END IF;
  l_sql := format('SELECT %I::text FROM %I WHERE %I = ''%s''', p_ref_id, p_ref_table, p_ref_col, replace(p_lookup_val,'''',''''''));
  --
  CALL p_raise_notice(l_sql);
  EXECUTE l_sql INTO STRICT l_ret;
  --
  RETURN l_ret;
EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION  '%: table [%] column [% = ''%'']', SQLERRM, p_ref_table, p_ref_col ,p_lookup_val USING ERRCODE = SQLSTATE;
END;
$$;


ALTER FUNCTION public.f_get_id_from_ref_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text) OWNER TO postgres;

--
-- TOC entry 1072 (class 1255 OID 20513)
-- Name: f_get_id_name(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_id_name(p_table_name text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_id_name TEXT;
BEGIN
  SELECT cc.column_name INTO STRICT l_id_name
  FROM information_schema.table_constraints c JOIN information_schema.constraint_column_usage cc USING (constraint_name,table_name,table_schema,table_catalog)
  WHERE c.table_name = p_table_name AND c.constraint_type = 'PRIMARY KEY'
  LIMIT 1;
  --
  RETURN l_id_name;
EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION  '%: Can''t detect PK for table "%"',SQLERRM, p_table_name USING ERRCODE = SQLSTATE;
END;
$$;


ALTER FUNCTION public.f_get_id_name(p_table_name text) OWNER TO postgres;

--
-- TOC entry 1073 (class 1255 OID 20514)
-- Name: f_get_ref_record(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_ref_record(p_ref_path text) RETURNS public.refs
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_ret refs;
BEGIN
  l_ret.lookup_col := substring(p_ref_path,'lookup_col:(.*),ref_table:');
  l_ret.ref_table := substring(p_ref_path,'ref_table:(.*),ref_col:');
  l_ret.ref_col := substring(p_ref_path,'ref_col:(.*),ref_id:');
  l_ret.ref_id := coalesce(substring(p_ref_path,'ref_id:(.*),delim:'), substring(p_ref_path,'ref_id:(.*)\)'));
  l_ret.list_delim := coalesce(substring(p_ref_path,'delim:(.)\)'), ',')::char(1);
  --
  RETURN l_ret;
END;
$$;


ALTER FUNCTION public.f_get_ref_record(p_ref_path text) OWNER TO postgres;

--
-- TOC entry 1074 (class 1255 OID 20515)
-- Name: f_get_source_data_id(text, text, text, text, boolean, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_source_data_id(p_table_name text, p_id_name text, p_source_col_name text, p_source_col_value text, p_to_insert boolean DEFAULT false, p_created_by text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_id UUID;
  l_sql TEXT;
BEGIN
  -- looks if value aleady exists
  l_sql := format('SELECT %I FROM %I WHERE %I = lower(%L)', p_id_name, p_table_name, p_source_col_name,p_source_col_value);
  CALL p_raise_notice(l_sql);
  EXECUTE l_sql INTO l_id;
  -- inserts row if it doesn't exist
  IF l_id IS NULL AND p_to_insert THEN
    l_id := uuid_generate_v4();
    l_sql := format('INSERT INTO %I (%I,%I,created_by) VALUES (%L,lower(%L),%L)', p_table_name, p_id_name, p_source_col_name, l_id, p_source_col_value, p_created_by);
    CALL p_raise_notice(l_sql);
    EXECUTE l_sql;
  END IF;
  --
  RETURN l_id;
END;
$$;


ALTER FUNCTION public.f_get_source_data_id(p_table_name text, p_id_name text, p_source_col_name text, p_source_col_value text, p_to_insert boolean, p_created_by text) OWNER TO postgres;

--
-- TOC entry 1075 (class 1255 OID 20516)
-- Name: f_get_tables_to_replicate(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_tables_to_replicate(p_publication_name text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
BEGIN
  RETURN (SELECT string_agg('"'||table_name||'"', ', ')
            FROM (
                    SELECT table_name
                    FROM information_schema.tables
                    WHERE table_type = 'BASE TABLE'
                        AND (
                            table_schema = 'registry'
                            OR (
                                table_schema = 'public'
                                and table_name like 'ddm_source%'
                            )
                        )
                    EXCEPT
                    SELECT tablename
                    FROM pg_catalog.pg_publication_tables
                    WHERE pubname = p_publication_name
                ) s
         );
END;
$$;


ALTER FUNCTION public.f_get_tables_to_replicate(p_publication_name text) OWNER TO postgres;

--
-- TOC entry 1066 (class 1255 OID 20517)
-- Name: f_like_escape(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_like_escape(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE
    AS $_$
SELECT replace(replace(replace($1
    , '\', '\\') -- must come 1st
    , '%', '\%')
    , '_', '\_');
$_$;


ALTER FUNCTION public.f_like_escape(text) OWNER TO postgres;

--
-- TOC entry 1067 (class 1255 OID 20518)
-- Name: f_regexp_escape(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_regexp_escape(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE
    AS $_$
SELECT regexp_replace($1, '([!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g')
$_$;


ALTER FUNCTION public.f_regexp_escape(text) OWNER TO postgres;

--
-- TOC entry 1076 (class 1255 OID 20519)
-- Name: f_row_insert(text, public.hstore, public.hstore, text[], uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_row_insert(p_table_name text, p_sys_key_val public.hstore, p_business_key_val public.hstore, p_roles_arr text[] DEFAULT NULL::text[], p_uuid uuid DEFAULT public.uuid_generate_v4()) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_key_name TEXT;
  c_history_suffix CONSTANT TEXT := '_hst';
  l_table_hst TEXT := p_table_name||c_history_suffix;
  l_table_rcnt TEXT := p_table_name;
  --
  lr_kv RECORD;
  l_id UUID := p_uuid;
  --
  l_cols_rcnt TEXT := '';
  l_vals_rcnt TEXT := '';
  l_sys_kv_rcnt hstore;
  --
  l_cols_hst TEXT := '';
  l_vals_hst TEXT := '';
  l_sys_kv_hst hstore;
  --
  l_sql_hst TEXT;
  l_sql_rcnt TEXT;
BEGIN
  -- check permissions
  IF NOT f_check_permissions(p_table_name, p_roles_arr, 'I') THEN
    RAISE EXCEPTION 'ERROR: Permission denied' USING ERRCODE = '20003';
  END IF;
  -- gets pkey column name
  l_key_name := f_get_id_name(p_table_name);
  -- gets system column pairs
  CALL p_format_sys_columns(p_sys_key_val,l_sys_kv_hst,l_sys_kv_rcnt);
  -- processes system columns
  FOR lr_kv IN SELECT * FROM each(l_sys_kv_rcnt) LOOP
      l_cols_rcnt := l_cols_rcnt || lr_kv.key || ',';
      l_vals_rcnt := l_vals_rcnt || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  FOR lr_kv IN SELECT * FROM each(l_sys_kv_hst) LOOP
      l_cols_hst := l_cols_hst || lr_kv.key || ',';
      l_vals_hst := l_vals_hst || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  -- processes business columns
  FOR lr_kv IN SELECT * FROM each(p_business_key_val) LOOP
      l_cols_rcnt := l_cols_rcnt || lr_kv.key || ',';
      l_vals_rcnt := l_vals_rcnt || quote_nullable(lr_kv.value) || ',';
      l_cols_hst := l_cols_hst || lr_kv.key || ',';
      l_vals_hst := l_vals_hst || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  -- removes trailing delimeters
  l_cols_rcnt := l_cols_rcnt || l_key_name;
  l_vals_rcnt := l_vals_rcnt || '''' || l_id || '''::uuid';
  l_cols_hst := l_cols_hst || l_key_name;
  l_vals_hst := l_vals_hst || '''' || l_id || '''::uuid';
  --
  l_sql_rcnt := format('INSERT INTO %I (%s) VALUES (%s)', l_table_rcnt, l_cols_rcnt, l_vals_rcnt);
  CALL p_raise_notice(l_sql_rcnt);
  EXECUTE l_sql_rcnt;
  l_sql_hst := format('INSERT INTO %I (%s) VALUES (%s)', l_table_hst, 'ddm_dml_op,'||l_cols_hst, '''I'','||l_vals_hst);
  CALL p_raise_notice(l_sql_hst);
  EXECUTE l_sql_hst;
  RETURN l_id;
END;
$$;


ALTER FUNCTION public.f_row_insert(p_table_name text, p_sys_key_val public.hstore, p_business_key_val public.hstore, p_roles_arr text[], p_uuid uuid) OWNER TO postgres;

--
-- TOC entry 1077 (class 1255 OID 20520)
-- Name: f_starts_with_array(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_starts_with_array(text) RETURNS text[]
    LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE
    AS $_$
select string_to_array(regexp_replace(regexp_replace(replace(regexp_replace($1
, '[\[\]\s'']', '', 'g')
, ',', '%,')
, '$', '%')
, '^%', ''), ',');
$_$;


ALTER FUNCTION public.f_starts_with_array(text) OWNER TO postgres;

--
-- TOC entry 1078 (class 1255 OID 20521)
-- Name: f_trg_check_m2m_integrity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_trg_check_m2m_integrity() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $_$
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
$_$;


ALTER FUNCTION public.f_trg_check_m2m_integrity() OWNER TO postgres;

--
-- TOC entry 1079 (class 1255 OID 20522)
-- Name: p_alter_publicaton(text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_alter_publicaton(IN p_publication_name text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_table_list TEXT;
BEGIN
  l_table_list := f_get_tables_to_replicate(p_publication_name);
  IF l_table_list IS NOT NULL THEN
    EXECUTE 'ALTER PUBLICATION ' || p_publication_name || ' ADD TABLE ' || l_table_list || ';';
  END IF;
END;
$$;


ALTER PROCEDURE public.p_alter_publicaton(IN p_publication_name text) OWNER TO postgres;

--
-- TOC entry 1080 (class 1255 OID 20523)
-- Name: p_alter_subscription(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_alter_subscription()
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
BEGIN
  EXECUTE 'ALTER SUBSCRIPTION operational_sub REFRESH PUBLICATION';
END;
$$;


ALTER PROCEDURE public.p_alter_subscription() OWNER TO postgres;

--
-- TOC entry 1081 (class 1255 OID 20524)
-- Name: p_create_analytics_user(text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_create_analytics_user(IN p_user_name text, IN p_user_pwd text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  v_user_name text := replace(p_user_name, '"', '');
BEGIN
  v_user_name :='"'||v_user_name||'"'; 

  EXECUTE 'CREATE ROLE ' || v_user_name || ' LOGIN PASSWORD ''' || p_user_pwd || ''';';
  EXECUTE 'GRANT CONNECT ON DATABASE ' || current_database() || ' TO ' || v_user_name || ';';

 END;
$$;


ALTER PROCEDURE public.p_create_analytics_user(IN p_user_name text, IN p_user_pwd text) OWNER TO postgres;

--
-- TOC entry 1082 (class 1255 OID 20525)
-- Name: p_delete_analytics_user(text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_delete_analytics_user(IN p_user_name text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  v_user_name text := replace(p_user_name, '"', '');
BEGIN
     v_user_name :='"'||v_user_name||'"'; 
     EXECUTE 'REVOKE ALL PRIVILEGES ON DATABASE ' || current_database() || ' FROM ' || v_user_name || ';';
     EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA public  FROM ' || v_user_name || ';';
     EXECUTE 'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM ' || v_user_name || ';';
     EXECUTE 'REVOKE ALL PRIVILEGES ON ALL ROUTINES IN SCHEMA public FROM ' || v_user_name || ';';

     EXECUTE 'REVOKE ALL PRIVILEGES ON SCHEMA registry  FROM ' || v_user_name || ';';
     EXECUTE 'REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA registry FROM ' || v_user_name || ';';
     EXECUTE 'REVOKE ALL PRIVILEGES ON ALL ROUTINES IN SCHEMA registry FROM ' || v_user_name || ';';

     EXECUTE 'DROP ROLE ' || v_user_name || ';';

 END;
$$;


ALTER PROCEDURE public.p_delete_analytics_user(IN p_user_name text) OWNER TO postgres;

--
-- TOC entry 1083 (class 1255 OID 20526)
-- Name: p_format_sys_columns(public.hstore, public.hstore, public.hstore); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_format_sys_columns(IN p_sys_key_val public.hstore, INOUT op_sys_hist public.hstore, INOUT op_sys_rcnt public.hstore)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_curr_time TIMESTAMPTZ;
  --
  l_curr_user TEXT;
  l_source_system TEXT;
  l_source_application TEXT;
  l_source_process TEXT;
  l_source_business_process_definition_id TEXT;
  l_source_business_process_instance_id TEXT;
  l_source_business_activity TEXT;
  l_source_business_activity_instance_id TEXT;
  l_digital_sign TEXT;
  l_digital_sign_derived TEXT;
  l_digital_sign_checksum TEXT;
  l_digital_sign_derived_checksum TEXT;
  --
  l_source_system_id UUID;
  l_source_application_id UUID;
  l_source_process_id UUID;
BEGIN
  --
  IF NOT (p_sys_key_val ? 'curr_user') THEN
    RAISE EXCEPTION 'ERROR: Parameter "curr_user" doesn''t defined correctly' USING ERRCODE = '20001';
  END IF;
  --
  IF NOT (p_sys_key_val ? 'source_system') THEN
    RAISE EXCEPTION 'ERROR: Parameter "source_system" doesn''t defined correctly' USING ERRCODE = '20001';
  END IF;
  --
  IF NOT (p_sys_key_val ? 'source_application') THEN
    RAISE EXCEPTION 'ERROR: Parameter "source_application" doesn''t defined correctly' USING ERRCODE = '20001';
  END IF;
  --
  l_curr_time := now();
  l_curr_user := p_sys_key_val -> 'curr_user';
  --RAISE NOTICE '%, %', p_sys_key_val, l_curr_user;
  --
  l_source_system :=  p_sys_key_val -> 'source_system';
  l_source_application :=  p_sys_key_val -> 'source_application';
  l_source_process :=  p_sys_key_val -> 'source_process';
  l_source_business_process_definition_id := p_sys_key_val -> 'source_process_definition_id';
  l_source_business_process_instance_id := p_sys_key_val -> 'source_process_instance_id';
  l_source_business_activity := p_sys_key_val -> 'business_activity';
  l_source_business_activity_instance_id := p_sys_key_val -> 'source_activity_instance_id';
  --
  l_digital_sign :=  p_sys_key_val -> 'digital_sign';
  l_digital_sign_derived :=  p_sys_key_val -> 'digital_sign_derived';
  --
  l_digital_sign_checksum :=  p_sys_key_val -> 'ddm_digital_sign_checksum';
  l_digital_sign_derived_checksum :=  p_sys_key_val -> 'ddm_digital_sign_derived_checksum';
  --
  l_source_system_id :=  f_get_source_data_id('ddm_source_system','system_id','system_name',l_source_system,true,l_curr_user);
  l_source_application_id :=  f_get_source_data_id('ddm_source_application','application_id','application_name',l_source_application,true,l_curr_user);
  --
  IF l_source_process IS NOT NULL THEN
    l_source_process_id :=  f_get_source_data_id('ddm_source_business_process','business_process_id','business_process_name',l_source_process,true,l_curr_user);
  END IF;
  --
  op_sys_hist := (    'ddm_created_at=>"'     || l_curr_time::text       || '"'
                 || ', ddm_created_by=>"'     || l_curr_user             || '"'
                 || ', ddm_system_id=>"'      || l_source_system_id      || '"'
                 || ', ddm_application_id=>"' || l_source_application_id || '"'
                 || CASE WHEN l_source_process                        IS NOT NULL THEN ', ddm_business_process_id=>"'            || l_source_process_id                     || '"' ELSE '' END
                 || CASE WHEN l_source_business_process_definition_id IS NOT NULL THEN ', ddm_business_process_definition_id=>"' || l_source_business_process_definition_id || '"' ELSE '' END
                 || CASE WHEN l_source_business_process_instance_id   IS NOT NULL THEN ', ddm_business_process_instance_id=>"'   || l_source_business_process_instance_id   || '"' ELSE '' END
                 || CASE WHEN l_source_business_activity              IS NOT NULL THEN ', ddm_business_activity=>"'              || l_source_business_activity              || '"' ELSE '' END
                 || CASE WHEN l_source_business_activity_instance_id  IS NOT NULL THEN ', ddm_business_activity_instance_id=>"'  || l_source_business_activity_instance_id  || '"' ELSE '' END
                 || CASE WHEN l_digital_sign                          IS NOT NULL THEN ', ddm_digital_sign=>"'                   || l_digital_sign                          || '"' ELSE '' END
                 || CASE WHEN l_digital_sign_derived                  IS NOT NULL THEN ', ddm_digital_sign_derived=>"'           || l_digital_sign_derived                  || '"' ELSE '' END
                 || CASE WHEN l_digital_sign_checksum                 IS NOT NULL THEN ', ddm_digital_sign_checksum=>"'          || l_digital_sign_checksum                 || '"' ELSE '' END
                 || CASE WHEN l_digital_sign_derived_checksum         IS NOT NULL THEN ', ddm_digital_sign_derived_checksum=>"'  || l_digital_sign_derived_checksum         || '"' ELSE '' END
                 )::hstore;

  op_sys_rcnt := (    'ddm_created_at=>"' || l_curr_time::text || '"'
                 || ', ddm_created_by=>"' || l_curr_user       || '"'
                 || ', ddm_updated_at=>"' || l_curr_time::text || '"'
                 || ', ddm_updated_by=>"' || l_curr_user       || '"'
                 )::hstore;

  CALL p_raise_notice(op_sys_hist::text);
  CALL p_raise_notice(op_sys_rcnt::text);
END;
$$;


ALTER PROCEDURE public.p_format_sys_columns(IN p_sys_key_val public.hstore, INOUT op_sys_hist public.hstore, INOUT op_sys_rcnt public.hstore) OWNER TO postgres;

--
-- TOC entry 1084 (class 1255 OID 20527)
-- Name: p_grant_analytics_user(text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_grant_analytics_user(IN p_user_name text, IN p_table_name text DEFAULT NULL::text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  c_obj_pattern TEXT := 'report%v';
  r RECORD;
  is_role_found integer;
  v_user_name text := replace(p_user_name, '"', '');
BEGIN
  if p_table_name is not null then
    if not exists (select from information_schema.views 
                   where table_name = p_table_name 
                   and table_schema = 'registry') then
      raise exception 'Table [%] is not found', p_table_name;
    end if;
    c_obj_pattern := p_table_name;
  end if;
  -- check if role exists
  select 1
    into is_role_found
    from pg_catalog.pg_roles
    where rolname = v_user_name;

  if is_role_found is null then
    raise exception 'Role [%] is not found', v_user_name;
  end if;

  execute 'grant connect on database ' || current_database() || ' to "' || v_user_name || '";';

  FOR r IN SELECT * FROM information_schema.views WHERE table_name LIKE c_obj_pattern AND table_schema = 'registry' LOOP
    EXECUTE 'GRANT SELECT ON "' || r.table_name || '" TO "' || v_user_name || '";';
  END LOOP;
 END;
$$;


ALTER PROCEDURE public.p_grant_analytics_user(IN p_user_name text, IN p_table_name text) OWNER TO postgres;

--
-- TOC entry 1085 (class 1255 OID 20528)
-- Name: p_init_new_hist_table(text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_init_new_hist_table(IN p_source_table text, IN p_target_table text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_col_lst TEXT;
  l_part_key TEXT;
  l_sql TEXT;
BEGIN
  SELECT string_agg(column_name,',') into l_col_lst
  FROM information_schema.columns
  WHERE table_schema = 'registry'
    AND table_name   = p_source_table;
  --
  SELECT column_name INTO l_part_key
  FROM information_schema.constraint_column_usage
  WHERE table_schema = 'registry' AND table_name = p_target_table AND constraint_name like 'ui%' LIMIT 1;
  --
  l_sql := 'WITH S AS (SELECT row_number() OVER (PARTITION BY ' || l_part_key || ' ORDER BY ddm_created_at DESC) rn,* FROM '|| p_source_table ||')
            INSERT INTO ' || p_target_table || '(' || l_col_lst || ')
            SELECT ' || l_col_lst || ' FROM s WHERE rn = 1';
  --
  CALL p_raise_notice(l_sql);
  EXECUTE l_sql;
END;
$$;


ALTER PROCEDURE public.p_init_new_hist_table(IN p_source_table text, IN p_target_table text) OWNER TO postgres;

--
-- TOC entry 1086 (class 1255 OID 20529)
-- Name: p_load_table_from_csv(text, text, text[], text[]); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_load_table_from_csv(IN p_table_name text, IN p_file_name text, IN p_table_columns text[], IN p_target_table_columns text[] DEFAULT NULL::text[])
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $_$
DECLARE
  l_sql TEXT;
  l_sys_cols text := 'curr_user=>"admin",source_system=>"Initial load",source_application=>"Initial load",source_process=>"Initial load process",process_id=>"0000"';
  l_cols text := '';
  l_row record;
  l_target_table_columns text[] := coalesce(p_target_table_columns,p_table_columns);
  l_col_name TEXT;
  l_col_value TEXT;
  l_is_uuid BOOLEAN := FALSE;
  l_uuid TEXT := NULL;
  j INT := 0;
  l_ref refs;
  l_col_names TEXT[];
  l_col_vals TEXT[];
  l_curr_idx int;
  l_system_roles_arr text := 'array[null, null, null, null]::text[]'; -- system role marker to skip RBAC check during initial data load
BEGIN
  --
  FOR i IN array_lower(p_table_columns, 1)..array_upper(p_table_columns, 1) LOOP
    l_cols := l_cols || p_table_columns[i] || ' TEXT,';
    IF p_table_columns[i] = 'uuid' THEN
      l_is_uuid := TRUE;
    END IF;
  END LOOP;
  l_cols := TRIM(TRAILING ',' FROM l_cols);
  --
  l_sql := format($$DROP FOREIGN TABLE IF EXISTS %I_csv$$, p_table_name);
  execute l_sql;
  --
  l_sql := format($$CREATE FOREIGN TABLE %I_csv(%s) SERVER srv_file_fdw
                    OPTIONS (FILENAME '%s', FORMAT 'csv', HEADER 'true', DELIMITER ',', ENCODING 'UTF8' )$$, p_table_name, l_cols, p_file_name);
  CALL p_raise_notice(l_sql);
  execute l_sql;
  --
  l_cols := '';
  FOR i IN array_lower(l_target_table_columns, 1)..array_upper(l_target_table_columns, 1) LOOP
    --
    CASE WHEN split_part(l_target_table_columns[i],'::',2) = '' THEN
           l_col_name := split_part(l_target_table_columns[i],'::',1);
           l_col_value := l_col_name;
         WHEN split_part(l_target_table_columns[i],'::',2) LIKE 'ref(%' THEN
           l_col_name := split_part(l_target_table_columns[i],'::',1);
           l_ref := f_get_ref_record(l_target_table_columns[i]);
           l_col_value := format('(f_get_id_from_ref_table(''%s'',''%s'',''%s'',%s))', l_ref.ref_table, l_ref.ref_col, l_ref.ref_id, l_ref.lookup_col);
         WHEN split_part(l_target_table_columns[i],'::',2) LIKE 'ref_array(%' then
           NULL;
         ELSE
           l_col_name := split_part(l_target_table_columns[i],'::',1);
           l_col_value := split_part(l_target_table_columns[i],'::',2) ;
    END CASE;
    l_cols := l_cols ||''||l_col_name||'=>''||coalesce(''"''||REGEXP_REPLACE(trim('||l_col_value||', chr(160)),''"'',''\"'',''g'')||''"'',''NULL'')||'',' ;
    --
  END LOOP;
  --
  FOR i IN array_lower(l_target_table_columns, 1)..array_upper(l_target_table_columns, 1) LOOP
    CASE WHEN split_part(l_target_table_columns[i],'::',2) LIKE 'ref_array(%' then
           -- merge duplicated columns
           l_curr_idx := array_position(l_col_names, split_part(l_target_table_columns[i],'::',1));
           IF l_curr_idx IS NULL THEN
             l_col_names := array_append(l_col_names, split_part(l_target_table_columns[i],'::',1));
             l_col_vals  := array_append(l_col_vals, NULL);
             l_curr_idx  := array_position(l_col_names, split_part(l_target_table_columns[i],'::',1));
           END IF;
           l_ref := f_get_ref_record(l_target_table_columns[i]);
           l_col_vals[l_curr_idx] := concat_ws(',', l_col_vals[l_curr_idx], format('(f_get_id_from_ref_array_table(''%s'',''%s'',''%s'',%s,''%s''))', l_ref.ref_table, l_ref.ref_col, l_ref.ref_id, l_ref.lookup_col, l_ref.list_delim));
      ELSE
           NULL;
    END CASE;
  END LOOP;
  --
  IF array_length(l_col_names, 1) > 0 then
    FOR i IN array_lower(l_col_names, 1)..array_upper(l_col_names, 1) LOOP
      l_cols := l_cols ||''||l_col_names[i]||'=>''||coalesce(''"{''||REGEXP_REPLACE(trim(concat_ws('','','||l_col_vals[i]||'), chr(160)),''"'',''\"'',''g'')||''}"'',''NULL'')||'',' ;
    END LOOP;
  END IF;
  --
  l_cols := TRIM(TRAILING ',' FROM l_cols);
  CALL p_raise_notice(l_cols);
  --
  IF l_is_uuid THEN
--    l_sql := format('SELECT ''($$%s$$)::hstore);'' f FROM %I_csv', l_cols, p_table_name);
    l_sql := format('SELECT ''SELECT f_row_insert(''''%I'''', (''''%s'''')::hstore,($$%s$$)::hstore, ' || l_system_roles_arr || ', ''''''||uuid||''''''::uuid);'' f
                 FROM %I_csv'
                 , p_table_name, l_sys_cols, l_cols, p_table_name);
--                 , array_to_string(l_lookups,', '), p_table_name, l_sys_cols, l_cols, p_table_name);
  ELSE
    l_sql := format('SELECT ''SELECT f_row_insert(''''%I'''', (''''%s'''')::hstore,($$%s$$)::hstore, ' || l_system_roles_arr || ');'' f
                 FROM %I_csv'
                 , p_table_name, l_sys_cols, l_cols, p_table_name);
  END IF;
  CALL p_raise_notice(l_sql);
  --
  FOR l_row IN EXECUTE l_sql LOOP
    CALL p_raise_notice(l_row.f);
    EXECUTE l_row.f;
  END LOOP;
  --
  l_sql := format($$DROP FOREIGN TABLE IF EXISTS %I_csv$$, p_table_name);
  execute l_sql;
  --
END;
$_$;


ALTER PROCEDURE public.p_load_table_from_csv(IN p_table_name text, IN p_file_name text, IN p_table_columns text[], IN p_target_table_columns text[]) OWNER TO postgres;

--
-- TOC entry 1087 (class 1255 OID 20531)
-- Name: p_raise_notice(text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_raise_notice(IN p_string_to_log text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
BEGIN
--  RAISE NOTICE '%', p_string_to_log;
END;
$$;


ALTER PROCEDURE public.p_raise_notice(IN p_string_to_log text) OWNER TO postgres;

--
-- TOC entry 1088 (class 1255 OID 20532)
-- Name: p_revoke_analytics_user(text, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_revoke_analytics_user(IN p_user_name text, IN p_table_name text DEFAULT NULL::text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  c_obj_pattern TEXT := 'report%v';
  r RECORD;
  is_role_found integer;
  v_user_name text := replace(p_user_name, '"', '');
BEGIN
  if p_table_name is not null then
    if not exists (select from information_schema.views 
                   where table_name = p_table_name 
                   and table_schema = 'registry') then
      raise exception 'Table [%] is not found', p_table_name;
    end if;
    c_obj_pattern := p_table_name;
  end if;
  -- check if role exists
  select 1
    into is_role_found
    from pg_catalog.pg_roles
    where rolname = v_user_name;

  if is_role_found is null then
    raise exception 'Role [%] is not found', v_user_name;
  end if;

  FOR r IN SELECT * FROM information_schema.views WHERE table_name LIKE c_obj_pattern AND table_schema = 'registry' LOOP
    EXECUTE 'REVOKE SELECT ON "' || r.table_name || '" FROM "' || v_user_name || '";';
  END LOOP;
 END;
$$;


ALTER PROCEDURE public.p_revoke_analytics_user(IN p_user_name text, IN p_table_name text) OWNER TO postgres;

--
-- TOC entry 1089 (class 1255 OID 20533)
-- Name: p_row_delete(text, uuid, public.hstore, text[]); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_row_delete(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_roles_arr text[] DEFAULT NULL::text[])
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_key_name TEXT;
  c_history_suffix CONSTANT TEXT := '_hst';
  l_table_hst TEXT := p_table_name||c_history_suffix;
  l_table_rcnt TEXT := p_table_name;
  --
  lr_kv RECORD;
  lr_rcnt RECORD;
  l_kv_hst hstore;
  --
  l_cols_hst TEXT := '';
  l_vals_hst TEXT := '';
  --
  l_sys_kv_hst hstore;
  l_sys_kv_rcnt hstore;
  --
  l_sql_hst TEXT;
  l_sql_rcnt TEXT;
  l_cnt SMALLINT;
BEGIN
  -- check permissions
  IF NOT f_check_permissions(p_table_name, p_roles_arr, 'D') THEN
    RAISE EXCEPTION 'ERROR: Permission denied' USING ERRCODE = '20003';
  END IF;
  -- gets pkey column name
  l_key_name := f_get_id_name(p_table_name);
  CALL p_raise_notice(l_key_name);
  -- gets system column pairs
  CALL p_format_sys_columns(p_sys_key_val,l_sys_kv_hst,l_sys_kv_rcnt);
  -- gets current values
  EXECUTE format('SELECT * FROM %I WHERE %I = ''%s''::uuid', l_table_rcnt, l_key_name, p_uuid) INTO lr_rcnt;
  --
  GET DIAGNOSTICS l_cnt = ROW_COUNT;
  IF l_cnt = 0 THEN
    RAISE EXCEPTION 'ERROR: There is no row in table [%] with [% = ''%'']', l_table_rcnt, l_key_name, p_uuid USING ERRCODE = '20002';
  END IF;
  --
  l_kv_hst := hstore(lr_rcnt) - akeys(l_sys_kv_rcnt) || l_sys_kv_hst;
  CALL p_raise_notice(l_kv_hst::text);
  -- processes columns
  FOR lr_kv IN SELECT * FROM each(l_kv_hst) LOOP
      l_cols_hst := l_cols_hst || lr_kv.key || ',';
      l_vals_hst := l_vals_hst || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  -- removes trailing delimeters
  l_cols_hst := trim(trailing ',' from l_cols_hst);
  l_vals_hst := trim(trailing ',' from l_vals_hst);
  --
  l_sql_rcnt := format('DELETE FROM %I WHERE %I = ''%s''::uuid', l_table_rcnt, l_key_name, p_uuid);
  CALL p_raise_notice(l_sql_rcnt);
  EXECUTE l_sql_rcnt;
  l_sql_hst := format('INSERT INTO %I (%s) VALUES (%s)', l_table_hst, 'ddm_dml_op,'||l_cols_hst, '''D'','||l_vals_hst);
  CALL p_raise_notice(l_sql_hst);
  EXECUTE l_sql_hst;
END;
$$;


ALTER PROCEDURE public.p_row_delete(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_roles_arr text[]) OWNER TO postgres;

--
-- TOC entry 1090 (class 1255 OID 20534)
-- Name: p_row_update(text, uuid, public.hstore, public.hstore, text[]); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_row_update(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_business_key_val public.hstore, IN p_roles_arr text[] DEFAULT NULL::text[])
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $$
DECLARE
  l_key_name TEXT;
  c_history_suffix CONSTANT TEXT := '_hst';
  l_table_hst TEXT := p_table_name||c_history_suffix;
  l_table_rcnt TEXT := p_table_name;
  --
  lr_kv RECORD;
  lr_rcnt RECORD;
  l_kv_hst hstore;
  --
  l_sys_kv_rcnt hstore;
  --
  l_cols_hst TEXT := '';
  l_vals_hst TEXT := '';
  l_sys_kv_hst hstore;
  --
  l_upd_list TEXT := '';
  --
  l_sql_hst TEXT;
  l_sql_rcnt TEXT;
  l_cnt SMALLINT;
  --
  l_is_check_passed boolean;
  l_columns4rbac_arr text[];
BEGIN
  -- gets pkey column name
  l_key_name := f_get_id_name(p_table_name);
  -- processes business columns
  FOR lr_kv IN SELECT * FROM each(p_business_key_val) LOOP
      l_cols_hst := l_cols_hst || lr_kv.key || ',';
      l_vals_hst := l_vals_hst || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  --
  -- check permissions based on Data Classification Model (dcm)
  select r_is_check_passed, r_columns4rbac_arr
    into l_is_check_passed, l_columns4rbac_arr
    from f_check_permissions_dcm (p_table_name, l_key_name, p_uuid, string_to_array(rtrim(l_cols_hst, ','), ','), p_roles_arr);
  if not l_is_check_passed then
    RAISE EXCEPTION '(dcm) Permission denied' USING ERRCODE = '20003';
  end if;
  --
  -- check permissions based on RBAC
  -- if any columns left after previous check
  if cardinality(l_columns4rbac_arr) > 0 and 
  NOT f_check_permissions(p_table_name, p_roles_arr, 'U', l_columns4rbac_arr) THEN
    RAISE EXCEPTION '(rbac) Permission denied' USING ERRCODE = '20003';
  END IF;
  -- gets system column pairs
  CALL p_format_sys_columns(p_sys_key_val,l_sys_kv_hst,l_sys_kv_rcnt);
  -- creates update list
  FOR lr_kv IN SELECT * FROM each(l_sys_kv_rcnt - akeys(l_sys_kv_hst) || p_business_key_val) LOOP
    l_upd_list := trim(leading ',' from concat_ws(',', l_upd_list, lr_kv.key || '=' || quote_nullable(lr_kv.value)));
  END LOOP;
  -- makes update
  l_sql_rcnt := format('UPDATE %I SET %s WHERE %I = ''%s''::uuid', l_table_rcnt, l_upd_list, l_key_name, p_uuid);
  CALL p_raise_notice(l_sql_rcnt);
  EXECUTE l_sql_rcnt;
  -- raises error if row doesn't exist
  GET DIAGNOSTICS l_cnt = ROW_COUNT;
  IF l_cnt = 0 THEN
    RAISE EXCEPTION 'ERROR: There is no row in table [%] with [% = ''%'']', l_table_rcnt, l_key_name, p_uuid USING ERRCODE = '20002';
  END IF;
  --
  -- gets current values after update
  EXECUTE format('SELECT * FROM %I WHERE %I = ''%s''::uuid', l_table_rcnt, l_key_name, p_uuid) INTO lr_rcnt;
  --
  l_kv_hst := hstore(lr_rcnt) - akeys(l_sys_kv_rcnt) || l_sys_kv_hst;
  CALL p_raise_notice(l_kv_hst::text);
  -- processes columns
  l_cols_hst := '';
  l_vals_hst := '';
  FOR lr_kv IN SELECT * FROM each(l_kv_hst) LOOP
      l_cols_hst := l_cols_hst || lr_kv.key || ',';
      l_vals_hst := l_vals_hst || quote_nullable(lr_kv.value) || ',';
  END LOOP;
  -- removes trailing delimeters
  l_cols_hst := trim(trailing ',' from l_cols_hst);
  l_vals_hst := trim(trailing ',' from l_vals_hst);
  --
  l_sql_hst := format('INSERT INTO %I (%s) VALUES (%s)', l_table_hst, 'ddm_dml_op,'||l_cols_hst, '''U'','||l_vals_hst);
  CALL p_raise_notice(l_sql_hst);
  EXECUTE l_sql_hst;
END;
$$;


ALTER PROCEDURE public.p_row_update(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_business_key_val public.hstore, IN p_roles_arr text[]) OWNER TO postgres;

--
-- TOC entry 1091 (class 1255 OID 20535)
-- Name: p_version_control(text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_version_control(IN p_version text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'registry', 'public', 'pg_temp'
    AS $_$
DECLARE
    c_change_type TEXT := 'versioning';
    c_change_name TEXT := 'registry_version';
    c_attr_curr TEXT := 'current';
    c_attr_prev TEXT := 'previous';
    l_ver_curr TEXT;
    l_ret text;
BEGIN
    -- check input params
    if p_version is null then
      raise exception 'New registry version is not set (p_version is null).';
    end if;

    if not exists (select 1 where p_version ~ '^\d+[.]\d+[.]\d+$') then
      raise exception 'Format of the new registry version is not followed. Expecting x.x.x (for example 1.0.0).';
    end if;

    -- get current version
    SELECT attribute_value INTO l_ver_curr FROM ddm_liquibase_metadata
    WHERE change_type = c_change_type AND change_name = c_change_name AND attribute_name = c_attr_curr;

    -- update
    -- change current version
    UPDATE ddm_liquibase_metadata SET attribute_value = p_version
    WHERE change_type = c_change_type AND change_name = c_change_name AND attribute_name = c_attr_curr
    returning attribute_value into l_ret;

    --
    IF l_ret IS NULL THEN
        INSERT INTO ddm_liquibase_metadata (change_name, change_type, attribute_name, attribute_value) VALUES (c_change_name, c_change_type, c_attr_curr, p_version);
    END IF;

    -- change previous version
    UPDATE ddm_liquibase_metadata SET attribute_value = l_ver_curr
    WHERE change_type = c_change_type AND change_name = c_change_name AND attribute_name = c_attr_prev
    returning attribute_value into l_ret;

    --
    IF l_ret IS NULL THEN
        INSERT INTO ddm_liquibase_metadata (change_name, change_type, attribute_name, attribute_value) VALUES (c_change_name, c_change_type, c_attr_prev, coalesce(l_ver_curr,'N/A'));
    END IF;
END;
$_$;


ALTER PROCEDURE public.p_version_control(IN p_version text) OWNER TO postgres;

--
-- TOC entry 3131 (class 1417 OID 19349)
-- Name: srv_file_fdw; Type: SERVER; Schema: -; Owner: postgres
--

CREATE SERVER srv_file_fdw FOREIGN DATA WRAPPER file_fdw;


ALTER SERVER srv_file_fdw OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 19119)
-- Name: ddm_db_changelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_db_changelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.ddm_db_changelog OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 19114)
-- Name: ddm_db_changelog_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_db_changelog_lock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.ddm_db_changelog_lock OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 20497)
-- Name: ddm_geoserver_pk_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_geoserver_pk_metadata (
    table_schema character varying(32) NOT NULL,
    table_name character varying(64) NOT NULL,
    pk_column character varying(32) NOT NULL,
    pk_column_idx integer,
    pk_policy character varying(32),
    pk_sequence character varying(64)
);


ALTER TABLE public.ddm_geoserver_pk_metadata OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 19403)
-- Name: ddm_liquibase_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_liquibase_metadata (
    metadata_id integer NOT NULL,
    change_type text NOT NULL,
    change_name text NOT NULL,
    attribute_name text NOT NULL,
    attribute_value text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ddm_liquibase_metadata OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19402)
-- Name: ddm_liquibase_metadata_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ddm_liquibase_metadata ALTER COLUMN metadata_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ddm_liquibase_metadata_metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 20486)
-- Name: ddm_rls_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_rls_metadata (
    rls_id integer NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    jwt_attribute text NOT NULL,
    check_column text NOT NULL,
    check_table text NOT NULL
);


ALTER TABLE public.ddm_rls_metadata OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 20485)
-- Name: ddm_rls_metadata_rls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ddm_rls_metadata ALTER COLUMN rls_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ddm_rls_metadata_rls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 19385)
-- Name: ddm_role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_role_permission (
    permission_id integer NOT NULL,
    role_name text NOT NULL,
    object_name text NOT NULL,
    column_name text,
    operation public.type_operation NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    object_type public.type_object DEFAULT 'table'::public.type_object NOT NULL
);


ALTER TABLE public.ddm_role_permission OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19384)
-- Name: ddm_role_permission_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ddm_role_permission ALTER COLUMN permission_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ddm_role_permission_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 19430)
-- Name: ddm_source_application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_source_application (
    application_id uuid NOT NULL,
    application_name text NOT NULL,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ddm_source_application OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19440)
-- Name: ddm_source_business_process; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_source_business_process (
    business_process_id uuid NOT NULL,
    business_process_name text NOT NULL,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ddm_source_business_process OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 19420)
-- Name: ddm_source_system; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ddm_source_system (
    system_id uuid NOT NULL,
    system_name text NOT NULL,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ddm_source_system OWNER TO postgres;

--
-- TOC entry 4484 (class 0 OID 19119)
-- Dependencies: 218
-- Data for Name: ddm_db_changelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_db_changelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
create-archive-schema	platform	changesets/registry/00010_init-db.sql	2024-12-16 12:27:06.04257	1	EXECUTED	8:d1f4f91dbe9b2d2c0af77c83d1edba97	sql		\N	4.15.0	\N	\N	4352025992
set-privileges	platform	changesets/registry/00010_init-db.sql	2024-12-16 12:27:06.082033	2	EXECUTED	8:442a02771f0bd8a29a820d7eaa9fa279	sql		\N	4.15.0	\N	\N	4352025992
app-role-grant	platform	changesets/registry/00030_grant-connect.sql	2024-12-16 12:27:06.098237	3	EXECUTED	8:9e359426fde2c127541671bda0fbba32	sql		\N	4.15.0	pub	\N	4352025992
admin-role-grant	platform	changesets/registry/00030_grant-connect.sql	2024-12-16 12:27:06.113627	4	EXECUTED	8:8cd9524ba2ce76b10c6c4ab830e68901	sql		\N	4.15.0	pub	\N	4352025992
registry-regulation-management-role-grant	platform	changesets/registry/00030_grant-connect.sql	2024-12-16 12:27:06.127672	5	EXECUTED	8:dc8902274c64dbd2ff8625226040161f	sql		\N	4.15.0	pub	\N	4352025992
create-extensions-fdw	platform	changesets/registry/00040_create-extensions.sql	2024-12-16 12:27:06.167896	6	EXECUTED	8:fc58dd96fa9dc9e85dc90ec51c8ce9fa	sql		\N	4.15.0	\N	\N	4352025992
create-types	platform	changesets/registry/00050_create-types.sql	2024-12-16 12:27:06.188627	7	EXECUTED	8:07374f0e1020d8d0196b96a1a2cc35bd	sql		\N	4.15.0	\N	\N	4352025992
table-ddm_role_permission	platform	changesets/registry/00060_create-tables.sql	2024-12-16 12:27:06.286175	8	EXECUTED	8:ccf9776cf269efe423ca618f250aa3f7	sql		\N	4.15.0	\N	\N	4352025992
table-ddm_liquibase_metadata	platform	changesets/registry/00060_create-tables.sql	2024-12-16 12:27:06.3872	9	EXECUTED	8:a314b08263d8e64c715035a1d7e265b3	sql		\N	4.15.0	\N	\N	4352025992
tables-ddm_source	platform	changesets/registry/00060_create-tables.sql	2024-12-16 12:27:06.520585	10	EXECUTED	8:adbcfb83b511c731c6a0548f3697f6fe	sql		\N	4.15.0	\N	\N	4352025992
publication-analytical_pub	platform	changesets/registry/00070_publication.sql	2024-12-16 12:27:06.532563	11	EXECUTED	8:83a6d81725a47a2afd83451c1aa8cc5e	sql		\N	4.15.0	pub	\N	4352025992
create-registry-schema	platform	changesets/registry/00090_registry-schema.sql	2024-12-16 12:27:06.545555	12	EXECUTED	8:eca62ee33eafad2c35ce5a70a79d0e3f	sql		\N	4.15.0	\N	\N	4352025992
registry-schema-grants	platform	changesets/registry/00090_registry-schema.sql	2024-12-16 12:27:06.558637	13	EXECUTED	8:ca97100b5cee05e7db69a4f49c7006fd	sql		\N	4.15.0	\N	\N	4352025992
set-default-privileges	platform	changesets/registry/00100_set-default-privileges.sql	2024-12-16 12:27:06.571952	14	EXECUTED	8:dd7688345466a7a66ba38ee89b174944	sql		\N	4.15.0	\N	\N	4352025992
change-owner	platform	changesets/registry/00130_change-owner.sql	2024-12-16 12:27:06.585151	15	EXECUTED	8:349c07637bc474ef5dbeb08357fc19d3	sql		\N	4.15.0	\N	\N	4352025992
create-postgis-extension	platform	changesets/registry/00140_create-postgis.sql	2024-12-16 12:27:07.082944	16	EXECUTED	8:fe785108f322429adaa84f3a91b00602	sql		\N	4.15.0	\N	\N	4352025992
revoke-privileges-on-postgis-tables	platform	changesets/registry/00140_create-postgis.sql	2024-12-16 12:27:07.095259	17	EXECUTED	8:71d7bc0c6af1db99ebc84667ea73dc9f	sql		\N	4.15.0	\N	\N	4352025992
rename-file-attributes	platform	changesets/registry/00150_rename-file-attributes.sql	2024-12-16 12:27:07.109412	18	EXECUTED	8:8987b0ae72806fff0676148a01786ced	sql		\N	4.15.0	\N	\N	4352025992
grant-to-geocolumns	platform	changesets/registry/00160_grant-georole-to-geocolumns.sql	2024-12-16 12:27:07.121353	19	EXECUTED	8:b1522a50287908c3a4ec80779a070c7a	sql		\N	4.15.0	pub	\N	4352025992
table-ddm_rls_metadata	platform	changesets/registry/00170_create-rls.sql	2024-12-16 12:27:07.185196	20	EXECUTED	8:36900314b4f2d033ddb64f9913e2055c	sql		\N	4.15.0	\N	\N	4352025992
ddm_geoserver_pk_metadata	platform	changesets/registry/00180_create_table_geo_metadata.sql	2024-12-16 12:27:07.210821	21	EXECUTED	8:4a44dd7146516953e1c46688bd36dc84	sql		\N	4.15.0	\N	\N	4352025992
grant-to-geo-metadata	platform	changesets/registry/00180_create_table_geo_metadata.sql	2024-12-16 12:27:07.223453	22	EXECUTED	8:1a1956be9fc6b030dfdf3183b4f11eed	sql		\N	4.15.0	pub	\N	4352025992
create-type-object	platform	changesets/registry/00190_add-object-type-column.sql	2024-12-16 12:27:07.234694	23	EXECUTED	8:8626ba0d44eae58336160cbcd550a067	sql		\N	4.15.0	\N	\N	4352025992
add-object-type-column	platform	changesets/registry/00190_add-object-type-column.sql	2024-12-16 12:27:07.24611	24	EXECUTED	8:171a5934b95099dda1cb08c8b4055a60	sql		\N	4.15.0	\N	\N	4352025992
f_check_permissions	platform	changesets/registry/procedures/f_check_permissions.sql	2024-12-16 12:27:07.260322	25	EXECUTED	8:fbcce2b738021c3f37c109776e300b2e	sql		\N	4.15.0	\N	\N	4352025992
f_check_permissions_dcm	platform	changesets/registry/procedures/f_check_permissions_dcm.sql	2024-12-16 12:27:07.274079	26	EXECUTED	8:7d4ce50e0ef5ef15cd32dab140349097	sql		\N	4.15.0	\N	\N	4352025992
f_edrpou_is_correct	platform	changesets/registry/procedures/f_edrpou_is_correct.sql	2024-12-16 12:27:07.285653	27	EXECUTED	8:60e0806aab33b92d71311c76a5281c25	sql		\N	4.15.0	\N	\N	4352025992
f_get_id_from_ref_array_table	platform	changesets/registry/procedures/f_get_id_from_ref_array_table.sql	2024-12-16 12:27:07.296853	28	EXECUTED	8:794a5914641e788252d4c10cc8344ce9	sql		\N	4.15.0	\N	\N	4352025992
f_get_id_from_ref_table	platform	changesets/registry/procedures/f_get_id_from_ref_table.sql	2024-12-16 12:27:07.309247	29	EXECUTED	8:acd094c1b0bdf461755249d25c30cfd6	sql		\N	4.15.0	\N	\N	4352025992
f_get_id_name	platform	changesets/registry/procedures/f_get_id_name.sql	2024-12-16 12:27:07.32409	30	EXECUTED	8:b90555305e9b8ea41109e07fdfe38c1b	sql		\N	4.15.0	\N	\N	4352025992
f_get_ref_record	platform	changesets/registry/procedures/f_get_ref_record.sql	2024-12-16 12:27:07.337394	31	EXECUTED	8:e5dfd63ef2706e785a74b6c15e8f513c	sql		\N	4.15.0	\N	\N	4352025992
f_get_source_data_id	platform	changesets/registry/procedures/f_get_source_data_id.sql	2024-12-16 12:27:07.351144	32	EXECUTED	8:a92607a056a5be51f71509aedc5cc803	sql		\N	4.15.0	\N	\N	4352025992
f_get_tables_to_replicate	platform	changesets/registry/procedures/f_get_tables_to_replicate.sql	2024-12-16 12:27:07.365966	33	EXECUTED	8:f50f352e25f796cefd38ba7fb576c84e	sql		\N	4.15.0	\N	\N	4352025992
f_like_escape	platform	changesets/registry/procedures/f_like_escape.sql	2024-12-16 12:27:07.378044	34	EXECUTED	8:a2762fcb274ed9d8b9cb537fd6fbeea5	sql		\N	4.15.0	\N	\N	4352025992
f_regexp_escape	platform	changesets/registry/procedures/f_regexp_escape.sql	2024-12-16 12:27:07.38954	35	EXECUTED	8:95d8aca679c34809e87d7ca3dfbc000f	sql		\N	4.15.0	\N	\N	4352025992
f_row_insert	platform	changesets/registry/procedures/f_row_insert.sql	2024-12-16 12:27:07.404633	36	EXECUTED	8:929cc38e513b257f9d614731c5c40691	sql		\N	4.15.0	\N	\N	4352025992
f_starts_with_array	platform	changesets/registry/procedures/f_starts_with_array.sql	2024-12-16 12:27:07.416188	37	EXECUTED	8:74a86744a8443d68b3f3acea95773284	sql		\N	4.15.0	\N	\N	4352025992
f_trg_check_m2m_integrity	platform	changesets/registry/procedures/f_trg_check_m2m_integrity.sql	2024-12-16 12:27:07.429413	38	EXECUTED	8:6879183d60259db0aa958e9768787379	sql		\N	4.15.0	\N	\N	4352025992
p_alter_publicaton	platform	changesets/registry/procedures/p_alter_publicaton.sql	2024-12-16 12:27:07.440834	39	EXECUTED	8:e968cf581334b6ef29305b07758665b4	sql		\N	4.15.0	\N	\N	4352025992
p_alter_subscription	platform	changesets/registry/procedures/p_alter_subscription.sql	2024-12-16 12:27:07.452521	40	EXECUTED	8:da49ff02d14079b5cb434291b055cde2	sql		\N	4.15.0	\N	\N	4352025992
p_create_analytics_user	platform	changesets/registry/procedures/p_create_analytics_user.sql	2024-12-16 12:27:07.465074	41	EXECUTED	8:e12dcaff8af10ae38cf57f24384af811	sql		\N	4.15.0	\N	\N	4352025992
p_delete_analytics_user	platform	changesets/registry/procedures/p_delete_analytics_user.sql	2024-12-16 12:27:07.47698	42	EXECUTED	8:c05631661524eebdf6644110459fc81e	sql		\N	4.15.0	\N	\N	4352025992
p_format_sys_columns	platform	changesets/registry/procedures/p_format_sys_columns.sql	2024-12-16 12:27:07.492227	43	EXECUTED	8:1e91b42d848796a66ee3486d63e1aea6	sql		\N	4.15.0	\N	\N	4352025992
p_grant_analytics_user	platform	changesets/registry/procedures/p_grant_analytics_user.sql	2024-12-16 12:27:07.505786	44	EXECUTED	8:dd9b546fbcfdef6154f43bcac25fa6b1	sql		\N	4.15.0	\N	\N	4352025992
p_init_new_hist_table	platform	changesets/registry/procedures/p_init_new_hist_table.sql	2024-12-16 12:27:07.517709	45	EXECUTED	8:003794d0925ef4373840b2899b70ea6a	sql		\N	4.15.0	\N	\N	4352025992
p_load_table_from_csv	platform	changesets/registry/procedures/p_load_table_from_csv.sql	2024-12-16 12:27:07.532531	46	EXECUTED	8:66dc19bf11e73052d18e811eea206f47	sql		\N	4.15.0	\N	\N	4352025992
p_raise_notice	platform	changesets/registry/procedures/p_raise_notice.sql	2024-12-16 12:27:07.543869	47	EXECUTED	8:eb723f56c4c0bcec4f9715f863c51457	sql		\N	4.15.0	\N	\N	4352025992
p_revoke_analytics_user	platform	changesets/registry/procedures/p_revoke_analytics_user.sql	2024-12-16 12:27:07.555678	48	EXECUTED	8:27e13b9892b753f41206d53dab60498d	sql		\N	4.15.0	\N	\N	4352025992
p_row_delete	platform	changesets/registry/procedures/p_row_delete.sql	2024-12-16 12:27:07.569486	49	EXECUTED	8:c2d0fdcb5ade42992b3be83d9691041e	sql		\N	4.15.0	\N	\N	4352025992
p_row_update	platform	changesets/registry/procedures/p_row_update.sql	2024-12-16 12:27:07.583043	50	EXECUTED	8:1ce567036d1171b22c18eee31d9a712e	sql		\N	4.15.0	\N	\N	4352025992
p_version_control	platform	changesets/registry/procedures/p_version_control.sql	2024-12-16 12:27:07.595664	51	EXECUTED	8:5cf242e0ad6354d67c0d1b62ba0ee9c0	sql		\N	4.15.0	\N	\N	4352025992
app-role-post-deploy-grant	platform	changesets/registry/z-post-update/00010_grants-on-master.sql	2024-12-16 12:27:07.6355	52	EXECUTED	8:360eeb90e82ce7356850906ef867fe6a	sql		\N	4.15.0	pub	\N	4352025992
admin-role-post-deploy-grants	platform	changesets/registry/z-post-update/00010_grants-on-master.sql	2024-12-16 12:27:07.648512	53	EXECUTED	8:ee783c5e884593dccbddb54ed9720022	sql		\N	4.15.0	pub	\N	4352025992
\.


--
-- TOC entry 4483 (class 0 OID 19114)
-- Dependencies: 217
-- Data for Name: ddm_db_changelog_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_db_changelog_lock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 4494 (class 0 OID 20497)
-- Dependencies: 237
-- Data for Name: ddm_geoserver_pk_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_geoserver_pk_metadata (table_schema, table_name, pk_column, pk_column_idx, pk_policy, pk_sequence) FROM stdin;
\.


--
-- TOC entry 4488 (class 0 OID 19403)
-- Dependencies: 226
-- Data for Name: ddm_liquibase_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_liquibase_metadata (metadata_id, change_type, change_name, attribute_name, attribute_value, created_at) FROM stdin;
\.


--
-- TOC entry 4493 (class 0 OID 20486)
-- Dependencies: 236
-- Data for Name: ddm_rls_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_rls_metadata (rls_id, name, type, jwt_attribute, check_column, check_table) FROM stdin;
\.


--
-- TOC entry 4486 (class 0 OID 19385)
-- Dependencies: 224
-- Data for Name: ddm_role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_role_permission (permission_id, role_name, object_name, column_name, operation, created_at, object_type) FROM stdin;
\.


--
-- TOC entry 4490 (class 0 OID 19430)
-- Dependencies: 228
-- Data for Name: ddm_source_application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_source_application (application_id, application_name, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4491 (class 0 OID 19440)
-- Dependencies: 229
-- Data for Name: ddm_source_business_process; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_source_business_process (business_process_id, business_process_name, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4489 (class 0 OID 19420)
-- Dependencies: 227
-- Data for Name: ddm_source_system; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ddm_source_system (system_id, system_name, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4298 (class 0 OID 19764)
-- Dependencies: 231
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 5384 (class 0 OID 0)
-- Dependencies: 225
-- Name: ddm_liquibase_metadata_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ddm_liquibase_metadata_metadata_id_seq', 1, false);


--
-- TOC entry 5385 (class 0 OID 0)
-- Dependencies: 235
-- Name: ddm_rls_metadata_rls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ddm_rls_metadata_rls_id_seq', 1, false);


--
-- TOC entry 5386 (class 0 OID 0)
-- Dependencies: 223
-- Name: ddm_role_permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ddm_role_permission_permission_id_seq', 1, false);


--
-- TOC entry 4307 (class 2606 OID 19118)
-- Name: ddm_db_changelog_lock ddm_db_changelog_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_db_changelog_lock
    ADD CONSTRAINT ddm_db_changelog_lock_pkey PRIMARY KEY (id);


--
-- TOC entry 4337 (class 2606 OID 20501)
-- Name: ddm_geoserver_pk_metadata ddm_geoserver_pk_metadata_table_schema_table_name_pk_column_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_geoserver_pk_metadata
    ADD CONSTRAINT ddm_geoserver_pk_metadata_table_schema_table_name_pk_column_key UNIQUE (table_schema, table_name, pk_column);


--
-- TOC entry 4313 (class 2606 OID 19412)
-- Name: ddm_liquibase_metadata iu_ddm_liquibase_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_liquibase_metadata
    ADD CONSTRAINT iu_ddm_liquibase_metadata UNIQUE (change_name, change_type, attribute_name, attribute_value);

ALTER TABLE public.ddm_liquibase_metadata CLUSTER ON iu_ddm_liquibase_metadata;


--
-- TOC entry 4331 (class 2606 OID 20494)
-- Name: ddm_rls_metadata iu_ddm_rls_metadata_n; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_rls_metadata
    ADD CONSTRAINT iu_ddm_rls_metadata_n UNIQUE (name, type);


--
-- TOC entry 4333 (class 2606 OID 20496)
-- Name: ddm_rls_metadata iu_ddm_rls_metadata_t; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_rls_metadata
    ADD CONSTRAINT iu_ddm_rls_metadata_t UNIQUE (check_table, type);


--
-- TOC entry 4309 (class 2606 OID 19394)
-- Name: ddm_role_permission iu_ddm_role_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_role_permission
    ADD CONSTRAINT iu_ddm_role_permission UNIQUE (role_name, object_name, operation, column_name);

ALTER TABLE public.ddm_role_permission CLUSTER ON iu_ddm_role_permission;


--
-- TOC entry 4321 (class 2606 OID 19439)
-- Name: ddm_source_application iu_ddm_source_application; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_application
    ADD CONSTRAINT iu_ddm_source_application UNIQUE (application_name);


--
-- TOC entry 4325 (class 2606 OID 19449)
-- Name: ddm_source_business_process iu_ddm_source_business_process; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_business_process
    ADD CONSTRAINT iu_ddm_source_business_process UNIQUE (business_process_name);


--
-- TOC entry 4317 (class 2606 OID 19429)
-- Name: ddm_source_system iu_ddm_source_system; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_system
    ADD CONSTRAINT iu_ddm_source_system UNIQUE (system_name);


--
-- TOC entry 4315 (class 2606 OID 19410)
-- Name: ddm_liquibase_metadata pk_ddm_liquibase_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_liquibase_metadata
    ADD CONSTRAINT pk_ddm_liquibase_metadata PRIMARY KEY (metadata_id);


--
-- TOC entry 4335 (class 2606 OID 20492)
-- Name: ddm_rls_metadata pk_ddm_rls_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_rls_metadata
    ADD CONSTRAINT pk_ddm_rls_metadata PRIMARY KEY (rls_id);


--
-- TOC entry 4311 (class 2606 OID 19392)
-- Name: ddm_role_permission pk_ddm_role_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_role_permission
    ADD CONSTRAINT pk_ddm_role_permission PRIMARY KEY (permission_id);


--
-- TOC entry 4323 (class 2606 OID 19437)
-- Name: ddm_source_application pk_ddm_source_application; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_application
    ADD CONSTRAINT pk_ddm_source_application PRIMARY KEY (application_id);


--
-- TOC entry 4327 (class 2606 OID 19447)
-- Name: ddm_source_business_process pk_ddm_source_business_process; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_business_process
    ADD CONSTRAINT pk_ddm_source_business_process PRIMARY KEY (business_process_id);


--
-- TOC entry 4319 (class 2606 OID 19427)
-- Name: ddm_source_system pk_ddm_source_system; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ddm_source_system
    ADD CONSTRAINT pk_ddm_source_system PRIMARY KEY (system_id);


--
-- TOC entry 4482 (class 6104 OID 19450)
-- Name: analytical_pub; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION analytical_pub WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION analytical_pub OWNER TO postgres;

--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA registry; Type: ACL; Schema: -; Owner: registry_owner_role
--

GRANT USAGE ON SCHEMA registry TO PUBLIC;


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION box2d_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2d_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2d_in(cstring) TO application_role;


--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION box2d_out(public.box2d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2d_out(public.box2d) TO application_role;


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION box2df_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2df_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2df_in(cstring) TO application_role;


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION box2df_out(public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2df_out(public.box2df) TO application_role;


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION box3d_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box3d_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box3d_in(cstring) TO application_role;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION box3d_out(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box3d_out(public.box3d) TO application_role;


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 896
-- Name: FUNCTION geography_analyze(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_analyze(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_analyze(internal) TO application_role;


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 892
-- Name: FUNCTION geography_in(cstring, oid, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_in(cstring, oid, integer) TO application_role;


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 893
-- Name: FUNCTION geography_out(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_out(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_out(public.geography) TO application_role;


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 894
-- Name: FUNCTION geography_recv(internal, oid, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_recv(internal, oid, integer) TO application_role;


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 895
-- Name: FUNCTION geography_send(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_send(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_send(public.geography) TO application_role;


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 890
-- Name: FUNCTION geography_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_typmod_in(cstring[]) TO application_role;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 891
-- Name: FUNCTION geography_typmod_out(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_typmod_out(integer) TO application_role;


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 364
-- Name: FUNCTION geometry_analyze(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_analyze(internal) TO application_role;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 360
-- Name: FUNCTION geometry_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_in(cstring) TO application_role;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 361
-- Name: FUNCTION geometry_out(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_out(public.geometry) TO application_role;


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 365
-- Name: FUNCTION geometry_recv(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_recv(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_recv(internal) TO application_role;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 366
-- Name: FUNCTION geometry_send(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_send(public.geometry) TO application_role;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 362
-- Name: FUNCTION geometry_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_typmod_in(cstring[]) TO application_role;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 363
-- Name: FUNCTION geometry_typmod_out(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_typmod_out(integer) TO application_role;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 301
-- Name: FUNCTION ghstore_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_in(cstring) TO application_role;


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 302
-- Name: FUNCTION ghstore_out(public.ghstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_out(public.ghstore) TO application_role;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION gidx_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gidx_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gidx_in(cstring) TO application_role;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 356
-- Name: FUNCTION gidx_out(public.gidx); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gidx_out(public.gidx) TO application_role;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 323
-- Name: FUNCTION gtrgm_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_in(cstring) TO application_role;


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 324
-- Name: FUNCTION gtrgm_out(public.gtrgm); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_out(public.gtrgm) TO application_role;


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 264
-- Name: FUNCTION hstore_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_in(cstring) TO application_role;


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 265
-- Name: FUNCTION hstore_out(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_out(public.hstore) TO application_role;


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 266
-- Name: FUNCTION hstore_recv(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_recv(internal) TO application_role;


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 267
-- Name: FUNCTION hstore_send(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_send(public.hstore) TO application_role;


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 315
-- Name: FUNCTION hstore_subscript_handler(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_subscript_handler(internal) TO application_role;


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 358
-- Name: FUNCTION spheroid_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.spheroid_in(cstring) TO application_role;


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 359
-- Name: FUNCTION spheroid_out(public.spheroid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO registry_owner_role;
GRANT ALL ON FUNCTION public.spheroid_out(public.spheroid) TO application_role;


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 278
-- Name: FUNCTION hstore(text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text[]) TO application_role;


--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 614
-- Name: FUNCTION box3d(public.box2d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box3d(public.box2d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box3d(public.box2d) TO application_role;


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 618
-- Name: FUNCTION geometry(public.box2d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(public.box2d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(public.box2d) TO application_role;


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 615
-- Name: FUNCTION box(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box(public.box3d) TO application_role;


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 613
-- Name: FUNCTION box2d(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2d(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2d(public.box3d) TO application_role;


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 619
-- Name: FUNCTION geometry(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(public.box3d) TO application_role;


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 898
-- Name: FUNCTION geography(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography(bytea) TO application_role;


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 621
-- Name: FUNCTION geometry(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(bytea) TO application_role;


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 899
-- Name: FUNCTION bytea(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.bytea(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.bytea(public.geography) TO application_role;


--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 897
-- Name: FUNCTION geography(public.geography, integer, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography(public.geography, integer, boolean) TO application_role;


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 870
-- Name: FUNCTION geometry(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(public.geography) TO application_role;


--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 612
-- Name: FUNCTION box(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box(public.geometry) TO application_role;


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 610
-- Name: FUNCTION box2d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box2d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box2d(public.geometry) TO application_role;


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 611
-- Name: FUNCTION box3d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box3d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box3d(public.geometry) TO application_role;


--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 622
-- Name: FUNCTION bytea(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.bytea(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.bytea(public.geometry) TO application_role;


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 908
-- Name: FUNCTION geography(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography(public.geometry) TO application_role;


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 367
-- Name: FUNCTION geometry(public.geometry, integer, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(public.geometry, integer, boolean) TO application_role;


--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 764
-- Name: FUNCTION json(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.json(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.json(public.geometry) TO application_role;


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 765
-- Name: FUNCTION jsonb(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.jsonb(public.geometry) TO application_role;


--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION path(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.path(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.path(public.geometry) TO application_role;


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION point(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.point(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.point(public.geometry) TO application_role;


--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION polygon(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.polygon(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.polygon(public.geometry) TO application_role;


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 616
-- Name: FUNCTION text(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.text(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.text(public.geometry) TO application_role;


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 279
-- Name: FUNCTION hstore_to_json(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_json(public.hstore) TO application_role;


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 281
-- Name: FUNCTION hstore_to_jsonb(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_jsonb(public.hstore) TO application_role;


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 370
-- Name: FUNCTION geometry(path); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(path) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(path) TO application_role;


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 368
-- Name: FUNCTION geometry(point); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(point) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(point) TO application_role;


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 372
-- Name: FUNCTION geometry(polygon); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(polygon) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(polygon) TO application_role;


--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 620
-- Name: FUNCTION geometry(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry(text) TO application_role;


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION _postgis_deprecate(oldname text, newname text, version text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_deprecate(oldname text, newname text, version text) TO application_role;


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION _postgis_index_extent(tbl regclass, col text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_index_extent(tbl regclass, col text) TO application_role;


--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION _postgis_join_selectivity(regclass, text, regclass, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_join_selectivity(regclass, text, regclass, text, text) TO application_role;


--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 605
-- Name: FUNCTION _postgis_pgsql_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_pgsql_version() TO application_role;


--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 604
-- Name: FUNCTION _postgis_scripts_pgsql_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_scripts_pgsql_version() TO application_role;


--
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION _postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_selectivity(tbl regclass, att_name text, geom public.geometry, mode text) TO application_role;


--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION _postgis_stats(tbl regclass, att_name text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._postgis_stats(tbl regclass, att_name text, text) TO application_role;


--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 713
-- Name: FUNCTION _st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4578 (class 0 OID 0)
-- Dependencies: 712
-- Name: FUNCTION _st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4579 (class 0 OID 0)
-- Dependencies: 714
-- Name: FUNCTION _st_3dintersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 757
-- Name: FUNCTION _st_asgml(integer, public.geometry, integer, integer, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_asgml(integer, public.geometry, integer, integer, text, text) TO application_role;


--
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 1035
-- Name: FUNCTION _st_asx3d(integer, public.geometry, integer, integer, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_asx3d(integer, public.geometry, integer, integer, text) TO application_role;


--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 955
-- Name: FUNCTION _st_bestsrid(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography) TO application_role;


--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 954
-- Name: FUNCTION _st_bestsrid(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_bestsrid(public.geography, public.geography) TO application_role;


--
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 1033
-- Name: FUNCTION _st_concavehull(param_inputgeom public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_concavehull(param_inputgeom public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_concavehull(param_inputgeom public.geometry) TO application_role;


--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 705
-- Name: FUNCTION _st_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_contains(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 706
-- Name: FUNCTION _st_containsproperly(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 979
-- Name: FUNCTION _st_coveredby(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_coveredby(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 708
-- Name: FUNCTION _st_coveredby(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_coveredby(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 977
-- Name: FUNCTION _st_covers(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_covers(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 707
-- Name: FUNCTION _st_covers(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_covers(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION _st_crosses(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_crosses(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 711
-- Name: FUNCTION _st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4593 (class 0 OID 0)
-- Dependencies: 942
-- Name: FUNCTION _st_distancetree(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography) TO application_role;


--
-- TOC entry 4594 (class 0 OID 0)
-- Dependencies: 941
-- Name: FUNCTION _st_distancetree(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_distancetree(public.geography, public.geography, double precision, boolean) TO application_role;


--
-- TOC entry 4595 (class 0 OID 0)
-- Dependencies: 940
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography) TO application_role;


--
-- TOC entry 4596 (class 0 OID 0)
-- Dependencies: 939
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, boolean) TO application_role;


--
-- TOC entry 4597 (class 0 OID 0)
-- Dependencies: 938
-- Name: FUNCTION _st_distanceuncached(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_distanceuncached(public.geography, public.geography, double precision, boolean) TO application_role;


--
-- TOC entry 4598 (class 0 OID 0)
-- Dependencies: 701
-- Name: FUNCTION _st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4599 (class 0 OID 0)
-- Dependencies: 978
-- Name: FUNCTION _st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO application_role;


--
-- TOC entry 4600 (class 0 OID 0)
-- Dependencies: 944
-- Name: FUNCTION _st_dwithinuncached(public.geography, public.geography, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision) TO application_role;


--
-- TOC entry 4601 (class 0 OID 0)
-- Dependencies: 943
-- Name: FUNCTION _st_dwithinuncached(public.geography, public.geography, double precision, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_dwithinuncached(public.geography, public.geography, double precision, boolean) TO application_role;


--
-- TOC entry 4602 (class 0 OID 0)
-- Dependencies: 716
-- Name: FUNCTION _st_equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_equals(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 937
-- Name: FUNCTION _st_expand(public.geography, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_expand(public.geography, double precision) TO application_role;


--
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 745
-- Name: FUNCTION _st_geomfromgml(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_geomfromgml(text, integer) TO application_role;


--
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION _st_intersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_intersects(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION _st_linecrossingdirection(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO application_role;


--
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 866
-- Name: FUNCTION _st_longestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_longestline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 862
-- Name: FUNCTION _st_maxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 715
-- Name: FUNCTION _st_orderingequals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION _st_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_overlaps(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4611 (class 0 OID 0)
-- Dependencies: 952
-- Name: FUNCTION _st_pointoutside(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_pointoutside(public.geography) TO application_role;


--
-- TOC entry 4612 (class 0 OID 0)
-- Dependencies: 786
-- Name: FUNCTION _st_sortablehash(geom public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_sortablehash(geom public.geometry) TO application_role;


--
-- TOC entry 4613 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION _st_touches(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_touches(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4614 (class 0 OID 0)
-- Dependencies: 678
-- Name: FUNCTION _st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_voronoi(g1 public.geometry, clip public.geometry, tolerance double precision, return_polygons boolean) TO application_role;


--
-- TOC entry 4615 (class 0 OID 0)
-- Dependencies: 709
-- Name: FUNCTION _st_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public._st_within(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 879
-- Name: FUNCTION addauth(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addauth(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.addauth(text) TO application_role;


--
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 570
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO application_role;


--
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 568
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO application_role;


--
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 567
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO application_role;


--
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 286
-- Name: FUNCTION akeys(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.akeys(public.hstore) TO application_role;


--
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 287
-- Name: FUNCTION avals(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.avals(public.hstore) TO application_role;


--
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 617
-- Name: FUNCTION box3dtobox(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.box3dtobox(public.box3d) TO application_role;


--
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 881
-- Name: FUNCTION checkauth(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.checkauth(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.checkauth(text, text) TO application_role;


--
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 880
-- Name: FUNCTION checkauth(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.checkauth(text, text, text) TO application_role;


--
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 882
-- Name: FUNCTION checkauthtrigger(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.checkauthtrigger() TO registry_owner_role;
GRANT ALL ON FUNCTION public.checkauthtrigger() TO application_role;


--
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 1024
-- Name: FUNCTION contains_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.box2df) TO application_role;


--
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 1020
-- Name: FUNCTION contains_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.contains_2d(public.box2df, public.geometry) TO application_role;


--
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 1026
-- Name: FUNCTION contains_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.contains_2d(public.geometry, public.box2df) TO application_role;


--
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 252
-- Name: FUNCTION defined(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.defined(public.hstore, text) TO application_role;


--
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 254
-- Name: FUNCTION delete(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, text[]) TO application_role;


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 253
-- Name: FUNCTION delete(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, text) TO application_role;


--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 255
-- Name: FUNCTION delete(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 889
-- Name: FUNCTION disablelongtransactions(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.disablelongtransactions() TO registry_owner_role;
GRANT ALL ON FUNCTION public.disablelongtransactions() TO application_role;


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 574
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(table_name character varying, column_name character varying) TO application_role;


--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 573
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO application_role;


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 572
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO application_role;


--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 577
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrytable(table_name character varying) TO application_role;


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 576
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrytable(schema_name character varying, table_name character varying) TO application_role;


--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 575
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO application_role;


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 291
-- Name: FUNCTION each(hs public.hstore, OUT key text, OUT value text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.each(hs public.hstore, OUT key text, OUT value text) TO application_role;


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 887
-- Name: FUNCTION enablelongtransactions(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.enablelongtransactions() TO registry_owner_role;
GRANT ALL ON FUNCTION public.enablelongtransactions() TO application_role;


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 744
-- Name: FUNCTION equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.equals(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 273
-- Name: FUNCTION exist(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exist(public.hstore, text) TO application_role;


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 275
-- Name: FUNCTION exists_all(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exists_all(public.hstore, text[]) TO application_role;


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 274
-- Name: FUNCTION exists_any(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exists_any(public.hstore, text[]) TO application_role;


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 1065
-- Name: FUNCTION f_check_permissions(p_object_name text, p_roles_arr text[], p_operation public.type_operation, p_columns_arr text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_check_permissions(p_object_name text, p_roles_arr text[], p_operation public.type_operation, p_columns_arr text[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_check_permissions(p_object_name text, p_roles_arr text[], p_operation public.type_operation, p_columns_arr text[]) TO application_role;


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 1068
-- Name: FUNCTION f_check_permissions_dcm(p_table_name text, p_key_name text, p_uuid uuid, p_columns_arr text[], p_roles_arr text[], OUT r_is_check_passed boolean, OUT r_columns4rbac_arr text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_check_permissions_dcm(p_table_name text, p_key_name text, p_uuid uuid, p_columns_arr text[], p_roles_arr text[], OUT r_is_check_passed boolean, OUT r_columns4rbac_arr text[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_check_permissions_dcm(p_table_name text, p_key_name text, p_uuid uuid, p_columns_arr text[], p_roles_arr text[], OUT r_is_check_passed boolean, OUT r_columns4rbac_arr text[]) TO application_role;


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 1069
-- Name: FUNCTION f_edrpou_is_correct(character); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_edrpou_is_correct(character) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_edrpou_is_correct(character) TO application_role;


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 1070
-- Name: FUNCTION f_get_id_from_ref_array_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text, p_delim character); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_id_from_ref_array_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text, p_delim character) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_id_from_ref_array_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text, p_delim character) TO application_role;


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 1071
-- Name: FUNCTION f_get_id_from_ref_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_id_from_ref_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_id_from_ref_table(p_ref_table text, p_ref_col text, p_ref_id text, p_lookup_val text) TO application_role;


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 1072
-- Name: FUNCTION f_get_id_name(p_table_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_id_name(p_table_name text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_id_name(p_table_name text) TO application_role;


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 1073
-- Name: FUNCTION f_get_ref_record(p_ref_path text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_ref_record(p_ref_path text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_ref_record(p_ref_path text) TO application_role;


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 1074
-- Name: FUNCTION f_get_source_data_id(p_table_name text, p_id_name text, p_source_col_name text, p_source_col_value text, p_to_insert boolean, p_created_by text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_source_data_id(p_table_name text, p_id_name text, p_source_col_name text, p_source_col_value text, p_to_insert boolean, p_created_by text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_source_data_id(p_table_name text, p_id_name text, p_source_col_name text, p_source_col_value text, p_to_insert boolean, p_created_by text) TO application_role;


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 1075
-- Name: FUNCTION f_get_tables_to_replicate(p_publication_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_get_tables_to_replicate(p_publication_name text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_get_tables_to_replicate(p_publication_name text) TO application_role;


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 1066
-- Name: FUNCTION f_like_escape(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_like_escape(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_like_escape(text) TO application_role;


--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 1067
-- Name: FUNCTION f_regexp_escape(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_regexp_escape(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_regexp_escape(text) TO application_role;


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 351
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v4() TO application_role;


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 1076
-- Name: FUNCTION f_row_insert(p_table_name text, p_sys_key_val public.hstore, p_business_key_val public.hstore, p_roles_arr text[], p_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_row_insert(p_table_name text, p_sys_key_val public.hstore, p_business_key_val public.hstore, p_roles_arr text[], p_uuid uuid) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_row_insert(p_table_name text, p_sys_key_val public.hstore, p_business_key_val public.hstore, p_roles_arr text[], p_uuid uuid) TO application_role;


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 1077
-- Name: FUNCTION f_starts_with_array(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_starts_with_array(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_starts_with_array(text) TO application_role;


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 1078
-- Name: FUNCTION f_trg_check_m2m_integrity(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.f_trg_check_m2m_integrity() TO registry_owner_role;
GRANT ALL ON FUNCTION public.f_trg_check_m2m_integrity() TO application_role;


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 269
-- Name: FUNCTION fetchval(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.fetchval(public.hstore, text) TO application_role;


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 353
-- Name: FUNCTION file_fdw_handler(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.file_fdw_handler() TO application_role;


--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 354
-- Name: FUNCTION file_fdw_validator(text[], oid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.file_fdw_validator(text[], oid) TO application_role;


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 583
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO registry_owner_role;
GRANT ALL ON FUNCTION public.find_srid(character varying, character varying, character varying) TO application_role;


--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 919
-- Name: FUNCTION geog_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 925
-- Name: FUNCTION geography_cmp(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_cmp(public.geography, public.geography) TO application_role;


--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 914
-- Name: FUNCTION geography_distance_knn(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_distance_knn(public.geography, public.geography) TO application_role;


--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 924
-- Name: FUNCTION geography_eq(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_eq(public.geography, public.geography) TO application_role;


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 923
-- Name: FUNCTION geography_ge(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_ge(public.geography, public.geography) TO application_role;


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 885
-- Name: FUNCTION geography_gist_compress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_compress(internal) TO application_role;


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 884
-- Name: FUNCTION geography_gist_consistent(internal, public.geography, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_consistent(internal, public.geography, integer) TO application_role;


--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 912
-- Name: FUNCTION geography_gist_decompress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_decompress(internal) TO application_role;


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 915
-- Name: FUNCTION geography_gist_distance(internal, public.geography, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_distance(internal, public.geography, integer) TO application_role;


--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 886
-- Name: FUNCTION geography_gist_penalty(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_penalty(internal, internal, internal) TO application_role;


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 909
-- Name: FUNCTION geography_gist_picksplit(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_picksplit(internal, internal) TO application_role;


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 911
-- Name: FUNCTION geography_gist_same(public.box2d, public.box2d, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_same(public.box2d, public.box2d, internal) TO application_role;


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 910
-- Name: FUNCTION geography_gist_union(bytea, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gist_union(bytea, internal) TO application_role;


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 922
-- Name: FUNCTION geography_gt(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_gt(public.geography, public.geography) TO application_role;


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 921
-- Name: FUNCTION geography_le(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_le(public.geography, public.geography) TO application_role;


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 920
-- Name: FUNCTION geography_lt(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_lt(public.geography, public.geography) TO application_role;


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 913
-- Name: FUNCTION geography_overlaps(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_overlaps(public.geography, public.geography) TO application_role;


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 1060
-- Name: FUNCTION geography_spgist_choose_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_choose_nd(internal, internal) TO application_role;


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 1064
-- Name: FUNCTION geography_spgist_compress_nd(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_compress_nd(internal) TO application_role;


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 1059
-- Name: FUNCTION geography_spgist_config_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_config_nd(internal, internal) TO application_role;


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 1062
-- Name: FUNCTION geography_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_inner_consistent_nd(internal, internal) TO application_role;


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 1063
-- Name: FUNCTION geography_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_leaf_consistent_nd(internal, internal) TO application_role;


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 1061
-- Name: FUNCTION geography_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geography_spgist_picksplit_nd(internal, internal) TO application_role;


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 1031
-- Name: FUNCTION geom2d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 1032
-- Name: FUNCTION geom3d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 974
-- Name: FUNCTION geom4d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION geometry_above(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_above(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION geometry_below(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_below(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION geometry_cmp(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_cmp(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 1047
-- Name: FUNCTION geometry_contained_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_contained_3d(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION geometry_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_contains(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 1046
-- Name: FUNCTION geometry_contains_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_contains_3d(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION geometry_contains_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_contains_nd(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION geometry_distance_box(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_distance_box(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_distance_centroid(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION geometry_distance_centroid_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_distance_centroid_nd(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION geometry_distance_cpa(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_distance_cpa(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION geometry_eq(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_eq(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION geometry_ge(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_ge(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION geometry_gist_compress_2d(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_compress_2d(internal) TO application_role;


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION geometry_gist_compress_nd(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_compress_nd(internal) TO application_role;


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION geometry_gist_consistent_2d(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_2d(internal, public.geometry, integer) TO application_role;


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION geometry_gist_consistent_nd(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_consistent_nd(internal, public.geometry, integer) TO application_role;


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION geometry_gist_decompress_2d(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_2d(internal) TO application_role;


--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION geometry_gist_decompress_nd(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_decompress_nd(internal) TO application_role;


--
-- TOC entry 4710 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION geometry_gist_distance_2d(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_distance_2d(internal, public.geometry, integer) TO application_role;


--
-- TOC entry 4711 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION geometry_gist_distance_nd(internal, public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_distance_nd(internal, public.geometry, integer) TO application_role;


--
-- TOC entry 4712 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION geometry_gist_penalty_2d(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_2d(internal, internal, internal) TO application_role;


--
-- TOC entry 4713 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION geometry_gist_penalty_nd(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_penalty_nd(internal, internal, internal) TO application_role;


--
-- TOC entry 4714 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION geometry_gist_picksplit_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_2d(internal, internal) TO application_role;


--
-- TOC entry 4715 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION geometry_gist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_picksplit_nd(internal, internal) TO application_role;


--
-- TOC entry 4716 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_same_2d(geom1 public.geometry, geom2 public.geometry, internal) TO application_role;


--
-- TOC entry 4717 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION geometry_gist_same_nd(public.geometry, public.geometry, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_same_nd(public.geometry, public.geometry, internal) TO application_role;


--
-- TOC entry 4718 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION geometry_gist_sortsupport_2d(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_sortsupport_2d(internal) TO application_role;


--
-- TOC entry 4719 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION geometry_gist_union_2d(bytea, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_union_2d(bytea, internal) TO application_role;


--
-- TOC entry 4720 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION geometry_gist_union_nd(bytea, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gist_union_nd(bytea, internal) TO application_role;


--
-- TOC entry 4721 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION geometry_gt(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_gt(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4722 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION geometry_hash(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_hash(public.geometry) TO application_role;


--
-- TOC entry 4723 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION geometry_le(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_le(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4724 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION geometry_left(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_left(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4725 (class 0 OID 0)
-- Dependencies: 384
-- Name: FUNCTION geometry_lt(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_lt(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4726 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION geometry_overabove(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overabove(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4727 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION geometry_overbelow(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overbelow(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4728 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION geometry_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overlaps(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4729 (class 0 OID 0)
-- Dependencies: 1045
-- Name: FUNCTION geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overlaps_3d(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4730 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION geometry_overlaps_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overlaps_nd(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4731 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION geometry_overleft(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overleft(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4732 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION geometry_overright(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_overright(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4733 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION geometry_right(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_right(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4734 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION geometry_same(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_same(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4735 (class 0 OID 0)
-- Dependencies: 1048
-- Name: FUNCTION geometry_same_3d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_same_3d(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4736 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION geometry_same_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_same_nd(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4737 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION geometry_sortsupport(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_sortsupport(internal) TO application_role;


--
-- TOC entry 4738 (class 0 OID 0)
-- Dependencies: 1040
-- Name: FUNCTION geometry_spgist_choose_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_2d(internal, internal) TO application_role;


--
-- TOC entry 4739 (class 0 OID 0)
-- Dependencies: 1050
-- Name: FUNCTION geometry_spgist_choose_3d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_3d(internal, internal) TO application_role;


--
-- TOC entry 4740 (class 0 OID 0)
-- Dependencies: 1054
-- Name: FUNCTION geometry_spgist_choose_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_choose_nd(internal, internal) TO application_role;


--
-- TOC entry 4741 (class 0 OID 0)
-- Dependencies: 1044
-- Name: FUNCTION geometry_spgist_compress_2d(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_2d(internal) TO application_role;


--
-- TOC entry 4742 (class 0 OID 0)
-- Dependencies: 1011
-- Name: FUNCTION geometry_spgist_compress_3d(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_3d(internal) TO application_role;


--
-- TOC entry 4743 (class 0 OID 0)
-- Dependencies: 1058
-- Name: FUNCTION geometry_spgist_compress_nd(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_compress_nd(internal) TO application_role;


--
-- TOC entry 4744 (class 0 OID 0)
-- Dependencies: 1039
-- Name: FUNCTION geometry_spgist_config_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_config_2d(internal, internal) TO application_role;


--
-- TOC entry 4745 (class 0 OID 0)
-- Dependencies: 1049
-- Name: FUNCTION geometry_spgist_config_3d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_config_3d(internal, internal) TO application_role;


--
-- TOC entry 4746 (class 0 OID 0)
-- Dependencies: 1053
-- Name: FUNCTION geometry_spgist_config_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_config_nd(internal, internal) TO application_role;


--
-- TOC entry 4747 (class 0 OID 0)
-- Dependencies: 1042
-- Name: FUNCTION geometry_spgist_inner_consistent_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_2d(internal, internal) TO application_role;


--
-- TOC entry 4748 (class 0 OID 0)
-- Dependencies: 1052
-- Name: FUNCTION geometry_spgist_inner_consistent_3d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_3d(internal, internal) TO application_role;


--
-- TOC entry 4749 (class 0 OID 0)
-- Dependencies: 1056
-- Name: FUNCTION geometry_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_inner_consistent_nd(internal, internal) TO application_role;


--
-- TOC entry 4750 (class 0 OID 0)
-- Dependencies: 1043
-- Name: FUNCTION geometry_spgist_leaf_consistent_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_2d(internal, internal) TO application_role;


--
-- TOC entry 4751 (class 0 OID 0)
-- Dependencies: 1010
-- Name: FUNCTION geometry_spgist_leaf_consistent_3d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_3d(internal, internal) TO application_role;


--
-- TOC entry 4752 (class 0 OID 0)
-- Dependencies: 1057
-- Name: FUNCTION geometry_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_leaf_consistent_nd(internal, internal) TO application_role;


--
-- TOC entry 4753 (class 0 OID 0)
-- Dependencies: 1041
-- Name: FUNCTION geometry_spgist_picksplit_2d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_2d(internal, internal) TO application_role;


--
-- TOC entry 4754 (class 0 OID 0)
-- Dependencies: 1051
-- Name: FUNCTION geometry_spgist_picksplit_3d(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_3d(internal, internal) TO application_role;


--
-- TOC entry 4755 (class 0 OID 0)
-- Dependencies: 1055
-- Name: FUNCTION geometry_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_spgist_picksplit_nd(internal, internal) TO application_role;


--
-- TOC entry 4756 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION geometry_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_within(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4757 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION geometry_within_nd(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometry_within_nd(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 4758 (class 0 OID 0)
-- Dependencies: 969
-- Name: FUNCTION geometrytype(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometrytype(public.geography) TO application_role;


--
-- TOC entry 4759 (class 0 OID 0)
-- Dependencies: 798
-- Name: FUNCTION geometrytype(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geometrytype(public.geometry) TO application_role;


--
-- TOC entry 4760 (class 0 OID 0)
-- Dependencies: 517
-- Name: FUNCTION geomfromewkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geomfromewkb(bytea) TO application_role;


--
-- TOC entry 4761 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION geomfromewkt(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.geomfromewkt(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.geomfromewkt(text) TO application_role;


--
-- TOC entry 4762 (class 0 OID 0)
-- Dependencies: 584
-- Name: FUNCTION get_proj4_from_srid(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.get_proj4_from_srid(integer) TO application_role;


--
-- TOC entry 4763 (class 0 OID 0)
-- Dependencies: 883
-- Name: FUNCTION gettransactionid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gettransactionid() TO registry_owner_role;
GRANT ALL ON FUNCTION public.gettransactionid() TO application_role;


--
-- TOC entry 4764 (class 0 OID 0)
-- Dependencies: 303
-- Name: FUNCTION ghstore_compress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_compress(internal) TO application_role;


--
-- TOC entry 4765 (class 0 OID 0)
-- Dependencies: 309
-- Name: FUNCTION ghstore_consistent(internal, public.hstore, smallint, oid, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_consistent(internal, public.hstore, smallint, oid, internal) TO application_role;


--
-- TOC entry 4766 (class 0 OID 0)
-- Dependencies: 304
-- Name: FUNCTION ghstore_decompress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_decompress(internal) TO application_role;


--
-- TOC entry 4767 (class 0 OID 0)
-- Dependencies: 314
-- Name: FUNCTION ghstore_options(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_options(internal) TO application_role;


--
-- TOC entry 4768 (class 0 OID 0)
-- Dependencies: 305
-- Name: FUNCTION ghstore_penalty(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_penalty(internal, internal, internal) TO application_role;


--
-- TOC entry 4769 (class 0 OID 0)
-- Dependencies: 306
-- Name: FUNCTION ghstore_picksplit(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_picksplit(internal, internal) TO application_role;


--
-- TOC entry 4770 (class 0 OID 0)
-- Dependencies: 308
-- Name: FUNCTION ghstore_same(public.ghstore, public.ghstore, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_same(public.ghstore, public.ghstore, internal) TO application_role;


--
-- TOC entry 4771 (class 0 OID 0)
-- Dependencies: 307
-- Name: FUNCTION ghstore_union(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_union(internal, internal) TO application_role;


--
-- TOC entry 4772 (class 0 OID 0)
-- Dependencies: 312
-- Name: FUNCTION gin_consistent_hstore(internal, smallint, public.hstore, integer, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_consistent_hstore(internal, smallint, public.hstore, integer, internal, internal) TO application_role;


--
-- TOC entry 4773 (class 0 OID 0)
-- Dependencies: 310
-- Name: FUNCTION gin_extract_hstore(public.hstore, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_hstore(public.hstore, internal) TO application_role;


--
-- TOC entry 4774 (class 0 OID 0)
-- Dependencies: 311
-- Name: FUNCTION gin_extract_hstore_query(public.hstore, internal, smallint, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_hstore_query(public.hstore, internal, smallint, internal, internal) TO application_role;


--
-- TOC entry 4775 (class 0 OID 0)
-- Dependencies: 334
-- Name: FUNCTION gin_extract_query_trgm(text, internal, smallint, internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_query_trgm(text, internal, smallint, internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4776 (class 0 OID 0)
-- Dependencies: 333
-- Name: FUNCTION gin_extract_value_trgm(text, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_value_trgm(text, internal) TO application_role;


--
-- TOC entry 4777 (class 0 OID 0)
-- Dependencies: 335
-- Name: FUNCTION gin_trgm_consistent(internal, smallint, text, integer, internal, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_trgm_consistent(internal, smallint, text, integer, internal, internal, internal, internal) TO application_role;


--
-- TOC entry 4778 (class 0 OID 0)
-- Dependencies: 336
-- Name: FUNCTION gin_trgm_triconsistent(internal, smallint, text, integer, internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_trgm_triconsistent(internal, smallint, text, integer, internal, internal, internal) TO application_role;


--
-- TOC entry 4779 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION gserialized_gist_joinsel_2d(internal, oid, internal, smallint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO application_role;


--
-- TOC entry 4780 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION gserialized_gist_joinsel_nd(internal, oid, internal, smallint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO application_role;


--
-- TOC entry 4781 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION gserialized_gist_sel_2d(internal, oid, internal, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_2d(internal, oid, internal, integer) TO application_role;


--
-- TOC entry 4782 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION gserialized_gist_sel_nd(internal, oid, internal, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.gserialized_gist_sel_nd(internal, oid, internal, integer) TO application_role;


--
-- TOC entry 4783 (class 0 OID 0)
-- Dependencies: 327
-- Name: FUNCTION gtrgm_compress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_compress(internal) TO application_role;


--
-- TOC entry 4784 (class 0 OID 0)
-- Dependencies: 325
-- Name: FUNCTION gtrgm_consistent(internal, text, smallint, oid, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_consistent(internal, text, smallint, oid, internal) TO application_role;


--
-- TOC entry 4785 (class 0 OID 0)
-- Dependencies: 328
-- Name: FUNCTION gtrgm_decompress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_decompress(internal) TO application_role;


--
-- TOC entry 4786 (class 0 OID 0)
-- Dependencies: 326
-- Name: FUNCTION gtrgm_distance(internal, text, smallint, oid, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_distance(internal, text, smallint, oid, internal) TO application_role;


--
-- TOC entry 4787 (class 0 OID 0)
-- Dependencies: 342
-- Name: FUNCTION gtrgm_options(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_options(internal) TO application_role;


--
-- TOC entry 4788 (class 0 OID 0)
-- Dependencies: 329
-- Name: FUNCTION gtrgm_penalty(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_penalty(internal, internal, internal) TO application_role;


--
-- TOC entry 4789 (class 0 OID 0)
-- Dependencies: 330
-- Name: FUNCTION gtrgm_picksplit(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_picksplit(internal, internal) TO application_role;


--
-- TOC entry 4790 (class 0 OID 0)
-- Dependencies: 332
-- Name: FUNCTION gtrgm_same(public.gtrgm, public.gtrgm, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_same(public.gtrgm, public.gtrgm, internal) TO application_role;


--
-- TOC entry 4791 (class 0 OID 0)
-- Dependencies: 331
-- Name: FUNCTION gtrgm_union(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gtrgm_union(internal, internal) TO application_role;


--
-- TOC entry 4792 (class 0 OID 0)
-- Dependencies: 256
-- Name: FUNCTION hs_concat(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_concat(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4793 (class 0 OID 0)
-- Dependencies: 258
-- Name: FUNCTION hs_contained(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_contained(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4794 (class 0 OID 0)
-- Dependencies: 257
-- Name: FUNCTION hs_contains(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_contains(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4795 (class 0 OID 0)
-- Dependencies: 283
-- Name: FUNCTION hstore(record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(record) TO application_role;


--
-- TOC entry 4796 (class 0 OID 0)
-- Dependencies: 277
-- Name: FUNCTION hstore(text[], text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text[], text[]) TO application_role;


--
-- TOC entry 4797 (class 0 OID 0)
-- Dependencies: 251
-- Name: FUNCTION hstore(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text, text) TO application_role;


--
-- TOC entry 4798 (class 0 OID 0)
-- Dependencies: 299
-- Name: FUNCTION hstore_cmp(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_cmp(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4799 (class 0 OID 0)
-- Dependencies: 293
-- Name: FUNCTION hstore_eq(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_eq(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 296
-- Name: FUNCTION hstore_ge(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_ge(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 295
-- Name: FUNCTION hstore_gt(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_gt(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 300
-- Name: FUNCTION hstore_hash(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_hash(public.hstore) TO application_role;


--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 313
-- Name: FUNCTION hstore_hash_extended(public.hstore, bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_hash_extended(public.hstore, bigint) TO application_role;


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 298
-- Name: FUNCTION hstore_le(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_le(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4805 (class 0 OID 0)
-- Dependencies: 297
-- Name: FUNCTION hstore_lt(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_lt(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4806 (class 0 OID 0)
-- Dependencies: 294
-- Name: FUNCTION hstore_ne(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_ne(public.hstore, public.hstore) TO application_role;


--
-- TOC entry 4807 (class 0 OID 0)
-- Dependencies: 284
-- Name: FUNCTION hstore_to_array(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_array(public.hstore) TO application_role;


--
-- TOC entry 4808 (class 0 OID 0)
-- Dependencies: 280
-- Name: FUNCTION hstore_to_json_loose(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_json_loose(public.hstore) TO application_role;


--
-- TOC entry 4809 (class 0 OID 0)
-- Dependencies: 282
-- Name: FUNCTION hstore_to_jsonb_loose(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_jsonb_loose(public.hstore) TO application_role;


--
-- TOC entry 4810 (class 0 OID 0)
-- Dependencies: 285
-- Name: FUNCTION hstore_to_matrix(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_matrix(public.hstore) TO application_role;


--
-- TOC entry 4811 (class 0 OID 0)
-- Dependencies: 268
-- Name: FUNCTION hstore_version_diag(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_version_diag(public.hstore) TO application_role;


--
-- TOC entry 4812 (class 0 OID 0)
-- Dependencies: 1025
-- Name: FUNCTION is_contained_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.box2df) TO application_role;


--
-- TOC entry 4813 (class 0 OID 0)
-- Dependencies: 1021
-- Name: FUNCTION is_contained_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.is_contained_2d(public.box2df, public.geometry) TO application_role;


--
-- TOC entry 4814 (class 0 OID 0)
-- Dependencies: 1027
-- Name: FUNCTION is_contained_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.is_contained_2d(public.geometry, public.box2df) TO application_role;


--
-- TOC entry 4815 (class 0 OID 0)
-- Dependencies: 276
-- Name: FUNCTION isdefined(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.isdefined(public.hstore, text) TO application_role;


--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 272
-- Name: FUNCTION isexists(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.isexists(public.hstore, text) TO application_role;


--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 876
-- Name: FUNCTION lockrow(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.lockrow(text, text, text) TO application_role;


--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 875
-- Name: FUNCTION lockrow(text, text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text) TO application_role;


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 877
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO registry_owner_role;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, timestamp without time zone) TO application_role;


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 874
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO registry_owner_role;
GRANT ALL ON FUNCTION public.lockrow(text, text, text, text, timestamp without time zone) TO application_role;


--
-- TOC entry 4821 (class 0 OID 0)
-- Dependencies: 888
-- Name: FUNCTION longtransactionsenabled(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.longtransactionsenabled() TO registry_owner_role;
GRANT ALL ON FUNCTION public.longtransactionsenabled() TO application_role;


--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 1023
-- Name: FUNCTION overlaps_2d(public.box2df, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.box2df) TO application_role;


--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 1022
-- Name: FUNCTION overlaps_2d(public.box2df, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_2d(public.box2df, public.geometry) TO application_role;


--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 1028
-- Name: FUNCTION overlaps_2d(public.geometry, public.box2df); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_2d(public.geometry, public.box2df) TO application_role;


--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 918
-- Name: FUNCTION overlaps_geog(public.geography, public.gidx); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_geog(public.geography, public.gidx) TO application_role;


--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 916
-- Name: FUNCTION overlaps_geog(public.gidx, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.geography) TO application_role;


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 917
-- Name: FUNCTION overlaps_geog(public.gidx, public.gidx); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_geog(public.gidx, public.gidx) TO application_role;


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 1030
-- Name: FUNCTION overlaps_nd(public.geometry, public.gidx); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_nd(public.geometry, public.gidx) TO application_role;


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 1029
-- Name: FUNCTION overlaps_nd(public.gidx, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.geometry) TO application_role;


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 990
-- Name: FUNCTION overlaps_nd(public.gidx, public.gidx); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO registry_owner_role;
GRANT ALL ON FUNCTION public.overlaps_nd(public.gidx, public.gidx) TO application_role;


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 1079
-- Name: PROCEDURE p_alter_publicaton(IN p_publication_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_alter_publicaton(IN p_publication_name text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_alter_publicaton(IN p_publication_name text) TO application_role;


--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 1080
-- Name: PROCEDURE p_alter_subscription(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_alter_subscription() TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_alter_subscription() TO application_role;


--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 1081
-- Name: PROCEDURE p_create_analytics_user(IN p_user_name text, IN p_user_pwd text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_create_analytics_user(IN p_user_name text, IN p_user_pwd text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_create_analytics_user(IN p_user_name text, IN p_user_pwd text) TO application_role;


--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 1082
-- Name: PROCEDURE p_delete_analytics_user(IN p_user_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_delete_analytics_user(IN p_user_name text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_delete_analytics_user(IN p_user_name text) TO application_role;


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 1083
-- Name: PROCEDURE p_format_sys_columns(IN p_sys_key_val public.hstore, INOUT op_sys_hist public.hstore, INOUT op_sys_rcnt public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_format_sys_columns(IN p_sys_key_val public.hstore, INOUT op_sys_hist public.hstore, INOUT op_sys_rcnt public.hstore) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_format_sys_columns(IN p_sys_key_val public.hstore, INOUT op_sys_hist public.hstore, INOUT op_sys_rcnt public.hstore) TO application_role;


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 1084
-- Name: PROCEDURE p_grant_analytics_user(IN p_user_name text, IN p_table_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_grant_analytics_user(IN p_user_name text, IN p_table_name text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_grant_analytics_user(IN p_user_name text, IN p_table_name text) TO application_role;


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 1085
-- Name: PROCEDURE p_init_new_hist_table(IN p_source_table text, IN p_target_table text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_init_new_hist_table(IN p_source_table text, IN p_target_table text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_init_new_hist_table(IN p_source_table text, IN p_target_table text) TO application_role;


--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 1086
-- Name: PROCEDURE p_load_table_from_csv(IN p_table_name text, IN p_file_name text, IN p_table_columns text[], IN p_target_table_columns text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_load_table_from_csv(IN p_table_name text, IN p_file_name text, IN p_table_columns text[], IN p_target_table_columns text[]) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_load_table_from_csv(IN p_table_name text, IN p_file_name text, IN p_table_columns text[], IN p_target_table_columns text[]) TO application_role;


--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 1087
-- Name: PROCEDURE p_raise_notice(IN p_string_to_log text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_raise_notice(IN p_string_to_log text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_raise_notice(IN p_string_to_log text) TO application_role;


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 1088
-- Name: PROCEDURE p_revoke_analytics_user(IN p_user_name text, IN p_table_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_revoke_analytics_user(IN p_user_name text, IN p_table_name text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_revoke_analytics_user(IN p_user_name text, IN p_table_name text) TO application_role;


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 1089
-- Name: PROCEDURE p_row_delete(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_roles_arr text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_row_delete(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_roles_arr text[]) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_row_delete(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_roles_arr text[]) TO application_role;


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 1090
-- Name: PROCEDURE p_row_update(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_business_key_val public.hstore, IN p_roles_arr text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_row_update(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_business_key_val public.hstore, IN p_roles_arr text[]) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_row_update(IN p_table_name text, IN p_uuid uuid, IN p_sys_key_val public.hstore, IN p_business_key_val public.hstore, IN p_roles_arr text[]) TO application_role;


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 1091
-- Name: PROCEDURE p_version_control(IN p_version text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON PROCEDURE public.p_version_control(IN p_version text) TO registry_owner_role;
GRANT ALL ON PROCEDURE public.p_version_control(IN p_version text) TO application_role;


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 261
-- Name: FUNCTION pgaudit_ddl_command_end(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.pgaudit_ddl_command_end() FROM PUBLIC;
GRANT ALL ON FUNCTION public.pgaudit_ddl_command_end() TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgaudit_ddl_command_end() TO application_role;


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 263
-- Name: FUNCTION pgaudit_sql_drop(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.pgaudit_sql_drop() FROM PUBLIC;
GRANT ALL ON FUNCTION public.pgaudit_sql_drop() TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgaudit_sql_drop() TO application_role;


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 782
-- Name: FUNCTION pgis_asflatgeobuf_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_finalfn(internal) TO application_role;


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 762
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement) TO application_role;


--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 780
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO application_role;


--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 781
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO application_role;


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 779
-- Name: FUNCTION pgis_asgeobuf_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_finalfn(internal) TO application_role;


--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 777
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement) TO application_role;


--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 778
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asgeobuf_transfn(internal, anyelement, text) TO application_role;


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 772
-- Name: FUNCTION pgis_asmvt_combinefn(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_combinefn(internal, internal) TO application_role;


--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 774
-- Name: FUNCTION pgis_asmvt_deserialfn(bytea, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_deserialfn(bytea, internal) TO application_role;


--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 771
-- Name: FUNCTION pgis_asmvt_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_finalfn(internal) TO application_role;


--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 773
-- Name: FUNCTION pgis_asmvt_serialfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_serialfn(internal) TO application_role;


--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 766
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement) TO application_role;


--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 767
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text) TO application_role;


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 768
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer) TO application_role;


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 769
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO application_role;


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 770
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO application_role;


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 686
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry) TO application_role;


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 687
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision) TO application_role;


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 688
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_accum_transfn(internal, public.geometry, double precision, integer) TO application_role;


--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 692
-- Name: FUNCTION pgis_geometry_clusterintersecting_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterintersecting_finalfn(internal) TO application_role;


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 693
-- Name: FUNCTION pgis_geometry_clusterwithin_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_clusterwithin_finalfn(internal) TO application_role;


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 690
-- Name: FUNCTION pgis_geometry_collect_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_collect_finalfn(internal) TO application_role;


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 694
-- Name: FUNCTION pgis_geometry_makeline_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_makeline_finalfn(internal) TO application_role;


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 691
-- Name: FUNCTION pgis_geometry_polygonize_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_polygonize_finalfn(internal) TO application_role;


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 689
-- Name: FUNCTION pgis_geometry_union_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_union_finalfn(internal) TO application_role;


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 565
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.populate_geometry_columns(use_typmod boolean) TO application_role;


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 566
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO application_role;


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 292
-- Name: FUNCTION populate_record(anyelement, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.populate_record(anyelement, public.hstore) TO application_role;


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION postgis_addbbox(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_addbbox(public.geometry) TO application_role;


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 522
-- Name: FUNCTION postgis_cache_bbox(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_cache_bbox() TO application_role;


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 993
-- Name: FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO application_role;


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 992
-- Name: FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO application_role;


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 994
-- Name: FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO application_role;


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION postgis_dropbbox(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_dropbbox(public.geometry) TO application_role;


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 606
-- Name: FUNCTION postgis_extensions_upgrade(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_extensions_upgrade() TO application_role;


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 609
-- Name: FUNCTION postgis_full_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_full_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_full_version() TO application_role;


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 484
-- Name: FUNCTION postgis_geos_noop(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_geos_noop(public.geometry) TO application_role;


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 598
-- Name: FUNCTION postgis_geos_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_geos_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_geos_version() TO application_role;


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION postgis_getbbox(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_getbbox(public.geometry) TO application_role;


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION postgis_hasbbox(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_hasbbox(public.geometry) TO application_role;


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 717
-- Name: FUNCTION postgis_index_supportfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_index_supportfn(internal) TO application_role;


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 603
-- Name: FUNCTION postgis_lib_build_date(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_lib_build_date() TO application_role;


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 599
-- Name: FUNCTION postgis_lib_revision(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_lib_revision() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_lib_revision() TO application_role;


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 596
-- Name: FUNCTION postgis_lib_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_lib_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_lib_version() TO application_role;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 249
-- Name: FUNCTION postgis_libjson_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_libjson_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_libjson_version() TO application_role;


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 592
-- Name: FUNCTION postgis_liblwgeom_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_liblwgeom_version() TO application_role;


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 776
-- Name: FUNCTION postgis_libprotobuf_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_libprotobuf_version() TO application_role;


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 601
-- Name: FUNCTION postgis_libxml_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_libxml_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_libxml_version() TO application_role;


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION postgis_noop(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_noop(public.geometry) TO application_role;


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 593
-- Name: FUNCTION postgis_proj_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_proj_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_proj_version() TO application_role;


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 602
-- Name: FUNCTION postgis_scripts_build_date(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_scripts_build_date() TO application_role;


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 595
-- Name: FUNCTION postgis_scripts_installed(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_scripts_installed() TO application_role;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 597
-- Name: FUNCTION postgis_scripts_released(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_scripts_released() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_scripts_released() TO application_role;


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 600
-- Name: FUNCTION postgis_svn_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_svn_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_svn_version() TO application_role;


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 571
-- Name: FUNCTION postgis_transform_geometry(geom public.geometry, text, text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_transform_geometry(geom public.geometry, text, text, integer) TO application_role;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 991
-- Name: FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO application_role;


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 905
-- Name: FUNCTION postgis_typmod_dims(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_typmod_dims(integer) TO application_role;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 906
-- Name: FUNCTION postgis_typmod_srid(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_typmod_srid(integer) TO application_role;


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 907
-- Name: FUNCTION postgis_typmod_type(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_typmod_type(integer) TO application_role;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 591
-- Name: FUNCTION postgis_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_version() TO application_role;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 594
-- Name: FUNCTION postgis_wagyu_version(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO registry_owner_role;
GRANT ALL ON FUNCTION public.postgis_wagyu_version() TO application_role;


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 316
-- Name: FUNCTION set_limit(real); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_limit(real) TO application_role;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 317
-- Name: FUNCTION show_limit(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.show_limit() TO application_role;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 318
-- Name: FUNCTION show_trgm(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.show_trgm(text) TO application_role;


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 319
-- Name: FUNCTION similarity(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.similarity(text, text) TO application_role;


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 290
-- Name: FUNCTION similarity_dist(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.similarity_dist(text, text) TO application_role;


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 320
-- Name: FUNCTION similarity_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.similarity_op(text, text) TO application_role;


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 288
-- Name: FUNCTION skeys(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.skeys(public.hstore) TO application_role;


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 271
-- Name: FUNCTION slice(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.slice(public.hstore, text[]) TO application_role;


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 270
-- Name: FUNCTION slice_array(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.slice_array(public.hstore, text[]) TO application_role;


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 997
-- Name: FUNCTION st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dclosestpoint(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 731
-- Name: FUNCTION st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3ddfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 995
-- Name: FUNCTION st_3ddistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3ddistance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 730
-- Name: FUNCTION st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3ddwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 732
-- Name: FUNCTION st_3dintersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dintersects(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION st_3dlength(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dlength(public.geometry) TO application_role;


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 1038
-- Name: FUNCTION st_3dlineinterpolatepoint(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dlineinterpolatepoint(public.geometry, double precision) TO application_role;


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 999
-- Name: FUNCTION st_3dlongestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dlongestline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 527
-- Name: FUNCTION st_3dmakebox(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dmakebox(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 996
-- Name: FUNCTION st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dmaxdistance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION st_3dperimeter(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dperimeter(public.geometry) TO application_role;


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 998
-- Name: FUNCTION st_3dshortestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dshortestline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 633
-- Name: FUNCTION st_addmeasure(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_addmeasure(public.geometry, double precision, double precision) TO application_role;


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 531
-- Name: FUNCTION st_addpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 532
-- Name: FUNCTION st_addpoint(geom1 public.geometry, geom2 public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_addpoint(geom1 public.geometry, geom2 public.geometry, integer) TO application_role;


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 546
-- Name: FUNCTION st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 545
-- Name: FUNCTION st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_affine(public.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 1037
-- Name: FUNCTION st_angle(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_angle(line1 public.geometry, line2 public.geometry) TO application_role;


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_angle(pt1 public.geometry, pt2 public.geometry, pt3 public.geometry, pt4 public.geometry) TO application_role;


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 946
-- Name: FUNCTION st_area(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_area(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_area(text) TO application_role;


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 471
-- Name: FUNCTION st_area(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_area(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_area(public.geometry) TO application_role;


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 945
-- Name: FUNCTION st_area(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_area(geog public.geography, use_spheroid boolean) TO application_role;


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION st_area2d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_area2d(public.geometry) TO application_role;


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 964
-- Name: FUNCTION st_asbinary(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography) TO application_role;


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 808
-- Name: FUNCTION st_asbinary(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry) TO application_role;


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 965
-- Name: FUNCTION st_asbinary(public.geography, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asbinary(public.geography, text) TO application_role;


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 807
-- Name: FUNCTION st_asbinary(public.geometry, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asbinary(public.geometry, text) TO application_role;


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 755
-- Name: FUNCTION st_asencodedpolyline(geom public.geometry, nprecision integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asencodedpolyline(geom public.geometry, nprecision integer) TO application_role;


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION st_asewkb(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry) TO application_role;


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 515
-- Name: FUNCTION st_asewkb(public.geometry, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkb(public.geometry, text) TO application_role;


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 968
-- Name: FUNCTION st_asewkt(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkt(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkt(text) TO application_role;


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 966
-- Name: FUNCTION st_asewkt(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography) TO application_role;


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION st_asewkt(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry) TO application_role;


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 967
-- Name: FUNCTION st_asewkt(public.geography, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkt(public.geography, integer) TO application_role;


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION st_asewkt(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asewkt(public.geometry, integer) TO application_role;


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 934
-- Name: FUNCTION st_asgeojson(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeojson(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeojson(text) TO application_role;


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 933
-- Name: FUNCTION st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeojson(geog public.geography, maxdecimaldigits integer, options integer) TO application_role;


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 761
-- Name: FUNCTION st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeojson(geom public.geometry, maxdecimaldigits integer, options integer) TO application_role;


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 763
-- Name: FUNCTION st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO application_role;


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 930
-- Name: FUNCTION st_asgml(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgml(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgml(text) TO application_role;


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 758
-- Name: FUNCTION st_asgml(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgml(geom public.geometry, maxdecimaldigits integer, options integer) TO application_role;


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 929
-- Name: FUNCTION st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgml(geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO application_role;


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 928
-- Name: FUNCTION st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geog public.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO application_role;


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 759
-- Name: FUNCTION st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgml(version integer, geom public.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO application_role;


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 513
-- Name: FUNCTION st_ashexewkb(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry) TO application_role;


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION st_ashexewkb(public.geometry, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ashexewkb(public.geometry, text) TO application_role;


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 932
-- Name: FUNCTION st_askml(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_askml(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_askml(text) TO application_role;


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 931
-- Name: FUNCTION st_askml(geog public.geography, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_askml(geog public.geography, maxdecimaldigits integer, nprefix text) TO application_role;


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 760
-- Name: FUNCTION st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_askml(geom public.geometry, maxdecimaldigits integer, nprefix text) TO application_role;


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION st_aslatlontext(geom public.geometry, tmpl text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_aslatlontext(geom public.geometry, tmpl text) TO application_role;


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 775
-- Name: FUNCTION st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvtgeom(geom public.geometry, bounds public.box2d, extent integer, buffer integer, clip_geom boolean) TO application_role;


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 927
-- Name: FUNCTION st_assvg(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_assvg(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_assvg(text) TO application_role;


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 926
-- Name: FUNCTION st_assvg(geog public.geography, rel integer, maxdecimaldigits integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_assvg(geog public.geography, rel integer, maxdecimaldigits integer) TO application_role;


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 756
-- Name: FUNCTION st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_assvg(geom public.geometry, rel integer, maxdecimaldigits integer) TO application_role;


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 901
-- Name: FUNCTION st_astext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astext(text) TO application_role;


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 878
-- Name: FUNCTION st_astext(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astext(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astext(public.geography) TO application_role;


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 809
-- Name: FUNCTION st_astext(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astext(public.geometry) TO application_role;


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 900
-- Name: FUNCTION st_astext(public.geography, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astext(public.geography, integer) TO application_role;


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 810
-- Name: FUNCTION st_astext(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astext(public.geometry, integer) TO application_role;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO application_role;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_astwkb(geom public.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO application_role;


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 1036
-- Name: FUNCTION st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asx3d(geom public.geometry, maxdecimaldigits integer, options integer) TO application_role;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 950
-- Name: FUNCTION st_azimuth(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_azimuth(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION st_azimuth(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_azimuth(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 872
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_bdmpolyfromtext(text, integer) TO application_role;


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 871
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_bdpolyfromtext(text, integer) TO application_role;


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 657
-- Name: FUNCTION st_boundary(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_boundary(public.geometry) TO application_role;


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION st_boundingdiagonal(geom public.geometry, fits boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_boundingdiagonal(geom public.geometry, fits boolean) TO application_role;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 787
-- Name: FUNCTION st_box2dfromgeohash(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_box2dfromgeohash(text, integer) TO application_role;


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 959
-- Name: FUNCTION st_buffer(text, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision) TO application_role;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 956
-- Name: FUNCTION st_buffer(public.geography, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision) TO application_role;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 960
-- Name: FUNCTION st_buffer(text, double precision, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, integer) TO application_role;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 961
-- Name: FUNCTION st_buffer(text, double precision, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(text, double precision, text) TO application_role;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 957
-- Name: FUNCTION st_buffer(public.geography, double precision, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, integer) TO application_role;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 958
-- Name: FUNCTION st_buffer(public.geography, double precision, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(public.geography, double precision, text) TO application_role;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 640
-- Name: FUNCTION st_buffer(geom public.geometry, radius double precision, quadsegs integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, quadsegs integer) TO application_role;


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 639
-- Name: FUNCTION st_buffer(geom public.geometry, radius double precision, options text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buffer(geom public.geometry, radius double precision, options text) TO application_role;


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 539
-- Name: FUNCTION st_buildarea(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_buildarea(public.geometry) TO application_role;


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 976
-- Name: FUNCTION st_centroid(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_centroid(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_centroid(text) TO application_role;


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 738
-- Name: FUNCTION st_centroid(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_centroid(public.geometry) TO application_role;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 975
-- Name: FUNCTION st_centroid(public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_centroid(public.geography, use_spheroid boolean) TO application_role;


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 625
-- Name: FUNCTION st_chaikinsmoothing(public.geometry, integer, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_chaikinsmoothing(public.geometry, integer, boolean) TO application_role;


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 671
-- Name: FUNCTION st_cleangeometry(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_cleangeometry(public.geometry) TO application_role;


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 665
-- Name: FUNCTION st_clipbybox2d(geom public.geometry, box public.box2d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clipbybox2d(geom public.geometry, box public.box2d) TO application_role;


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 864
-- Name: FUNCTION st_closestpoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_closestpoint(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 634
-- Name: FUNCTION st_closestpointofapproach(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_closestpointofapproach(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 543
-- Name: FUNCTION st_clusterdbscan(public.geometry, eps double precision, minpoints integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterdbscan(public.geometry, eps double precision, minpoints integer) TO application_role;


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 541
-- Name: FUNCTION st_clusterintersecting(public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry[]) TO application_role;


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 679
-- Name: FUNCTION st_clusterkmeans(geom public.geometry, k integer, max_radius double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterkmeans(geom public.geometry, k integer, max_radius double precision) TO application_role;


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 542
-- Name: FUNCTION st_clusterwithin(public.geometry[], double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry[], double precision) TO application_role;


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 685
-- Name: FUNCTION st_collect(public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collect(public.geometry[]) TO application_role;


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 666
-- Name: FUNCTION st_collect(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collect(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION st_collectionextract(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry) TO application_role;


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 488
-- Name: FUNCTION st_collectionextract(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collectionextract(public.geometry, integer) TO application_role;


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 490
-- Name: FUNCTION st_collectionhomogenize(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collectionhomogenize(public.geometry) TO application_role;


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 684
-- Name: FUNCTION st_combinebbox(public.box2d, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box2d, public.geometry) TO application_role;


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 683
-- Name: FUNCTION st_combinebbox(public.box3d, public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.box3d) TO application_role;


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 682
-- Name: FUNCTION st_combinebbox(public.box3d, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_combinebbox(public.box3d, public.geometry) TO application_role;


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 1034
-- Name: FUNCTION st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_concavehull(param_geom public.geometry, param_pctconvex double precision, param_allow_holes boolean) TO application_role;


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 723
-- Name: FUNCTION st_contains(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_contains(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 724
-- Name: FUNCTION st_containsproperly(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_containsproperly(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 646
-- Name: FUNCTION st_convexhull(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_convexhull(public.geometry) TO application_role;


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 1000
-- Name: FUNCTION st_coorddim(geometry public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_coorddim(geometry public.geometry) TO application_role;


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 985
-- Name: FUNCTION st_coveredby(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_coveredby(text, text) TO application_role;


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 982
-- Name: FUNCTION st_coveredby(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_coveredby(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 727
-- Name: FUNCTION st_coveredby(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_coveredby(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 984
-- Name: FUNCTION st_covers(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_covers(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_covers(text, text) TO application_role;


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 980
-- Name: FUNCTION st_covers(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_covers(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 726
-- Name: FUNCTION st_covers(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_covers(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 636
-- Name: FUNCTION st_cpawithin(public.geometry, public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_cpawithin(public.geometry, public.geometry, double precision) TO application_role;


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 722
-- Name: FUNCTION st_crosses(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_crosses(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 1001
-- Name: FUNCTION st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_curvetoline(geom public.geometry, tol double precision, toltype integer, flags integer) TO application_role;


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 677
-- Name: FUNCTION st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_delaunaytriangles(g1 public.geometry, tolerance double precision, flags integer) TO application_role;


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 729
-- Name: FUNCTION st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dfullywithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 656
-- Name: FUNCTION st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_difference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 793
-- Name: FUNCTION st_dimension(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dimension(public.geometry) TO application_role;


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 699
-- Name: FUNCTION st_disjoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_disjoint(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 936
-- Name: FUNCTION st_distance(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distance(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distance(text, text) TO application_role;


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION st_distance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 935
-- Name: FUNCTION st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distance(geog1 public.geography, geog2 public.geography, use_spheroid boolean) TO application_role;


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 635
-- Name: FUNCTION st_distancecpa(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distancecpa(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 988
-- Name: FUNCTION st_distancesphere(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distancesphere(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_distancespheroid(geom1 public.geometry, geom2 public.geometry, public.spheroid) TO application_role;


--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 561
-- Name: FUNCTION st_dump(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dump(public.geometry) TO application_role;


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 563
-- Name: FUNCTION st_dumppoints(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dumppoints(public.geometry) TO application_role;


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 562
-- Name: FUNCTION st_dumprings(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dumprings(public.geometry) TO application_role;


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 564
-- Name: FUNCTION st_dumpsegments(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dumpsegments(public.geometry) TO application_role;


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 986
-- Name: FUNCTION st_dwithin(text, text, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dwithin(text, text, double precision) TO application_role;


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 719
-- Name: FUNCTION st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dwithin(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 981
-- Name: FUNCTION st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_dwithin(geog1 public.geography, geog2 public.geography, tolerance double precision, use_spheroid boolean) TO application_role;


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 804
-- Name: FUNCTION st_endpoint(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_endpoint(public.geometry) TO application_role;


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION st_envelope(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_envelope(public.geometry) TO application_role;


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 734
-- Name: FUNCTION st_equals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_equals(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION st_estimatedextent(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text) TO application_role;


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION st_estimatedextent(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text) TO application_role;


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION st_estimatedextent(text, text, text, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_estimatedextent(text, text, text, boolean) TO application_role;


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION st_expand(public.box2d, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(public.box2d, double precision) TO application_role;


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION st_expand(public.box3d, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(public.box3d, double precision) TO application_role;


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION st_expand(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(public.geometry, double precision) TO application_role;


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION st_expand(box public.box2d, dx double precision, dy double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(box public.box2d, dx double precision, dy double precision) TO application_role;


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 496
-- Name: FUNCTION st_expand(box public.box3d, dx double precision, dy double precision, dz double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(box public.box3d, dx double precision, dy double precision, dz double precision) TO application_role;


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_expand(geom public.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO application_role;


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 794
-- Name: FUNCTION st_exteriorring(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_exteriorring(public.geometry) TO application_role;


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 624
-- Name: FUNCTION st_filterbym(public.geometry, double precision, double precision, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_filterbym(public.geometry, double precision, double precision, boolean) TO application_role;


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION st_findextent(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_findextent(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_findextent(text, text) TO application_role;


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION st_findextent(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_findextent(text, text, text) TO application_role;


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 869
-- Name: FUNCTION st_flipcoordinates(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_flipcoordinates(public.geometry) TO application_role;


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION st_force2d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_force2d(public.geometry) TO application_role;


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION st_force3d(geom public.geometry, zvalue double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_force3d(geom public.geometry, zvalue double precision) TO application_role;


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION st_force3dm(geom public.geometry, mvalue double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_force3dm(geom public.geometry, mvalue double precision) TO application_role;


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION st_force3dz(geom public.geometry, zvalue double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_force3dz(geom public.geometry, zvalue double precision) TO application_role;


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 486
-- Name: FUNCTION st_force4d(geom public.geometry, zvalue double precision, mvalue double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_force4d(geom public.geometry, zvalue double precision, mvalue double precision) TO application_role;


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION st_forcecollection(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcecollection(public.geometry) TO application_role;


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 492
-- Name: FUNCTION st_forcecurve(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcecurve(public.geometry) TO application_role;


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION st_forcepolygonccw(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcepolygonccw(public.geometry) TO application_role;


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION st_forcepolygoncw(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcepolygoncw(public.geometry) TO application_role;


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION st_forcerhr(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcerhr(public.geometry) TO application_role;


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION st_forcesfs(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry) TO application_role;


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION st_forcesfs(public.geometry, version text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_forcesfs(public.geometry, version text) TO application_role;


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 654
-- Name: FUNCTION st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_frechetdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 784
-- Name: FUNCTION st_fromflatgeobuf(anyelement, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_fromflatgeobuf(anyelement, bytea) TO application_role;


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 783
-- Name: FUNCTION st_fromflatgeobuftotable(text, text, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_fromflatgeobuftotable(text, text, bytea) TO application_role;


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 644
-- Name: FUNCTION st_generatepoints(area public.geometry, npoints integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer) TO application_role;


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 645
-- Name: FUNCTION st_generatepoints(area public.geometry, npoints integer, seed integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_generatepoints(area public.geometry, npoints integer, seed integer) TO application_role;


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 903
-- Name: FUNCTION st_geogfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geogfromtext(text) TO application_role;


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 904
-- Name: FUNCTION st_geogfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geogfromwkb(bytea) TO application_role;


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 902
-- Name: FUNCTION st_geographyfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geographyfromtext(text) TO application_role;


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 971
-- Name: FUNCTION st_geohash(geog public.geography, maxchars integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geohash(geog public.geography, maxchars integer) TO application_role;


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 785
-- Name: FUNCTION st_geohash(geom public.geometry, maxchars integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geohash(geom public.geometry, maxchars integer) TO application_role;


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 836
-- Name: FUNCTION st_geomcollfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text) TO application_role;


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 835
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomcollfromtext(text, integer) TO application_role;


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 861
-- Name: FUNCTION st_geomcollfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea) TO application_role;


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 860
-- Name: FUNCTION st_geomcollfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomcollfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 739
-- Name: FUNCTION st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geometricmedian(g public.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO application_role;


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 811
-- Name: FUNCTION st_geometryfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text) TO application_role;


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 812
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geometryfromtext(text, integer) TO application_role;


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 792
-- Name: FUNCTION st_geometryn(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geometryn(public.geometry, integer) TO application_role;


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 799
-- Name: FUNCTION st_geometrytype(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geometrytype(public.geometry) TO application_role;


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 518
-- Name: FUNCTION st_geomfromewkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromewkb(bytea) TO application_role;


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 521
-- Name: FUNCTION st_geomfromewkt(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromewkt(text) TO application_role;


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 789
-- Name: FUNCTION st_geomfromgeohash(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgeohash(text, integer) TO application_role;


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 752
-- Name: FUNCTION st_geomfromgeojson(json); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(json) TO application_role;


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 753
-- Name: FUNCTION st_geomfromgeojson(jsonb); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(jsonb) TO application_role;


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 751
-- Name: FUNCTION st_geomfromgeojson(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgeojson(text) TO application_role;


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 747
-- Name: FUNCTION st_geomfromgml(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgml(text) TO application_role;


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 746
-- Name: FUNCTION st_geomfromgml(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromgml(text, integer) TO application_role;


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 750
-- Name: FUNCTION st_geomfromkml(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromkml(text) TO application_role;


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 813
-- Name: FUNCTION st_geomfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromtext(text) TO application_role;


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 814
-- Name: FUNCTION st_geomfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromtext(text, integer) TO application_role;


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION st_geomfromtwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromtwkb(bytea) TO application_role;


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 837
-- Name: FUNCTION st_geomfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea) TO application_role;


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 838
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_geomfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 748
-- Name: FUNCTION st_gmltosql(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_gmltosql(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_gmltosql(text) TO application_role;


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 749
-- Name: FUNCTION st_gmltosql(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_gmltosql(text, integer) TO application_role;


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 1002
-- Name: FUNCTION st_hasarc(geometry public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_hasarc(geometry public.geometry) TO application_role;


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 652
-- Name: FUNCTION st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 653
-- Name: FUNCTION st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_hausdorffdistance(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 1016
-- Name: FUNCTION st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_hexagon(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO application_role;


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 1018
-- Name: FUNCTION st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_hexagongrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO application_role;


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 797
-- Name: FUNCTION st_interiorringn(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_interiorringn(public.geometry, integer) TO application_role;


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 1015
-- Name: FUNCTION st_interpolatepoint(line public.geometry, point public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_interpolatepoint(line public.geometry, point public.geometry) TO application_role;


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 963
-- Name: FUNCTION st_intersection(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersection(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersection(text, text) TO application_role;


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 962
-- Name: FUNCTION st_intersection(public.geography, public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersection(public.geography, public.geography) TO application_role;


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 638
-- Name: FUNCTION st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersection(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 987
-- Name: FUNCTION st_intersects(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersects(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersects(text, text) TO application_role;


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 983
-- Name: FUNCTION st_intersects(geog1 public.geography, geog2 public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersects(geog1 public.geography, geog2 public.geography) TO application_role;


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 721
-- Name: FUNCTION st_intersects(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_intersects(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 805
-- Name: FUNCTION st_isclosed(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isclosed(public.geometry) TO application_role;


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 743
-- Name: FUNCTION st_iscollection(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_iscollection(public.geometry) TO application_role;


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 806
-- Name: FUNCTION st_isempty(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isempty(public.geometry) TO application_role;


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 473
-- Name: FUNCTION st_ispolygonccw(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ispolygonccw(public.geometry) TO application_role;


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 472
-- Name: FUNCTION st_ispolygoncw(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ispolygoncw(public.geometry) TO application_role;


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 740
-- Name: FUNCTION st_isring(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isring(public.geometry) TO application_role;


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 742
-- Name: FUNCTION st_issimple(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_issimple(public.geometry) TO application_role;


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 735
-- Name: FUNCTION st_isvalid(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry) TO application_role;


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 651
-- Name: FUNCTION st_isvalid(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvalid(public.geometry, integer) TO application_role;


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 649
-- Name: FUNCTION st_isvaliddetail(geom public.geometry, flags integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvaliddetail(geom public.geometry, flags integer) TO application_role;


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 648
-- Name: FUNCTION st_isvalidreason(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry) TO application_role;


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 650
-- Name: FUNCTION st_isvalidreason(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvalidreason(public.geometry, integer) TO application_role;


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 637
-- Name: FUNCTION st_isvalidtrajectory(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_isvalidtrajectory(public.geometry) TO application_role;


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 948
-- Name: FUNCTION st_length(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_length(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_length(text) TO application_role;


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION st_length(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_length(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_length(public.geometry) TO application_role;


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 947
-- Name: FUNCTION st_length(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_length(geog public.geography, use_spheroid boolean) TO application_role;


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION st_length2d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_length2d(public.geometry) TO application_role;


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION st_length2dspheroid(public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_length2dspheroid(public.geometry, public.spheroid) TO application_role;


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 465
-- Name: FUNCTION st_lengthspheroid(public.geometry, public.spheroid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_lengthspheroid(public.geometry, public.spheroid) TO application_role;


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 718
-- Name: FUNCTION st_linecrossingdirection(line1 public.geometry, line2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linecrossingdirection(line1 public.geometry, line2 public.geometry) TO application_role;


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 754
-- Name: FUNCTION st_linefromencodedpolyline(txtin text, nprecision integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefromencodedpolyline(txtin text, nprecision integer) TO application_role;


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION st_linefrommultipoint(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefrommultipoint(public.geometry) TO application_role;


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 818
-- Name: FUNCTION st_linefromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefromtext(text) TO application_role;


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 819
-- Name: FUNCTION st_linefromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefromtext(text, integer) TO application_role;


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 842
-- Name: FUNCTION st_linefromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea) TO application_role;


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 841
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linefromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 629
-- Name: FUNCTION st_lineinterpolatepoint(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoint(public.geometry, double precision) TO application_role;


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 630
-- Name: FUNCTION st_lineinterpolatepoints(public.geometry, double precision, repeat boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_lineinterpolatepoints(public.geometry, double precision, repeat boolean) TO application_role;


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 632
-- Name: FUNCTION st_linelocatepoint(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linelocatepoint(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 544
-- Name: FUNCTION st_linemerge(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linemerge(public.geometry) TO application_role;


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 844
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea) TO application_role;


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 843
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linestringfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 631
-- Name: FUNCTION st_linesubstring(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linesubstring(public.geometry, double precision, double precision) TO application_role;


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 1003
-- Name: FUNCTION st_linetocurve(geometry public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_linetocurve(geometry public.geometry) TO application_role;


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 1013
-- Name: FUNCTION st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_locatealong(geometry public.geometry, measure double precision, leftrightoffset double precision) TO application_role;


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 1012
-- Name: FUNCTION st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_locatebetween(geometry public.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO application_role;


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 1014
-- Name: FUNCTION st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_locatebetweenelevations(geometry public.geometry, fromelevation double precision, toelevation double precision) TO application_role;


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 867
-- Name: FUNCTION st_longestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_longestline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION st_m(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_m(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_m(public.geometry) TO application_role;


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION st_makebox2d(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makebox2d(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 535
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO application_role;


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 528
-- Name: FUNCTION st_makeline(public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry[]) TO application_role;


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 530
-- Name: FUNCTION st_makeline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makeline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 523
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision) TO application_role;


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 525
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepoint(double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 526
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepointm(double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 538
-- Name: FUNCTION st_makepolygon(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry) TO application_role;


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION st_makepolygon(public.geometry, public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makepolygon(public.geometry, public.geometry[]) TO application_role;


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 669
-- Name: FUNCTION st_makevalid(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makevalid(public.geometry) TO application_role;


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 670
-- Name: FUNCTION st_makevalid(geom public.geometry, params text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makevalid(geom public.geometry, params text) TO application_role;


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 863
-- Name: FUNCTION st_maxdistance(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_maxdistance(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 655
-- Name: FUNCTION st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_maximuminscribedcircle(public.geometry, OUT center public.geometry, OUT nearest public.geometry, OUT radius double precision) TO application_role;


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION st_memsize(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_memsize(public.geometry) TO application_role;


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 582
-- Name: FUNCTION st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_minimumboundingcircle(inputgeom public.geometry, segs_per_quarter integer) TO application_role;


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 641
-- Name: FUNCTION st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_minimumboundingradius(public.geometry, OUT center public.geometry, OUT radius double precision) TO application_role;


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 736
-- Name: FUNCTION st_minimumclearance(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_minimumclearance(public.geometry) TO application_role;


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 737
-- Name: FUNCTION st_minimumclearanceline(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_minimumclearanceline(public.geometry) TO application_role;


--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 825
-- Name: FUNCTION st_mlinefromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text) TO application_role;


--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 824
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mlinefromtext(text, integer) TO application_role;


--
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 855
-- Name: FUNCTION st_mlinefromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea) TO application_role;


--
-- TOC entry 5184 (class 0 OID 0)
-- Dependencies: 854
-- Name: FUNCTION st_mlinefromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mlinefromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5185 (class 0 OID 0)
-- Dependencies: 829
-- Name: FUNCTION st_mpointfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text) TO application_role;


--
-- TOC entry 5186 (class 0 OID 0)
-- Dependencies: 828
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpointfromtext(text, integer) TO application_role;


--
-- TOC entry 5187 (class 0 OID 0)
-- Dependencies: 850
-- Name: FUNCTION st_mpointfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea) TO application_role;


--
-- TOC entry 5188 (class 0 OID 0)
-- Dependencies: 849
-- Name: FUNCTION st_mpointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpointfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5189 (class 0 OID 0)
-- Dependencies: 832
-- Name: FUNCTION st_mpolyfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text) TO application_role;


--
-- TOC entry 5190 (class 0 OID 0)
-- Dependencies: 831
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpolyfromtext(text, integer) TO application_role;


--
-- TOC entry 5191 (class 0 OID 0)
-- Dependencies: 857
-- Name: FUNCTION st_mpolyfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea) TO application_role;


--
-- TOC entry 5192 (class 0 OID 0)
-- Dependencies: 856
-- Name: FUNCTION st_mpolyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_mpolyfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5193 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION st_multi(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multi(public.geometry) TO application_role;


--
-- TOC entry 5194 (class 0 OID 0)
-- Dependencies: 853
-- Name: FUNCTION st_multilinefromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multilinefromwkb(bytea) TO application_role;


--
-- TOC entry 5195 (class 0 OID 0)
-- Dependencies: 826
-- Name: FUNCTION st_multilinestringfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text) TO application_role;


--
-- TOC entry 5196 (class 0 OID 0)
-- Dependencies: 827
-- Name: FUNCTION st_multilinestringfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multilinestringfromtext(text, integer) TO application_role;


--
-- TOC entry 5197 (class 0 OID 0)
-- Dependencies: 830
-- Name: FUNCTION st_multipointfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipointfromtext(text) TO application_role;


--
-- TOC entry 5198 (class 0 OID 0)
-- Dependencies: 852
-- Name: FUNCTION st_multipointfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea) TO application_role;


--
-- TOC entry 5199 (class 0 OID 0)
-- Dependencies: 851
-- Name: FUNCTION st_multipointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipointfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5200 (class 0 OID 0)
-- Dependencies: 859
-- Name: FUNCTION st_multipolyfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea) TO application_role;


--
-- TOC entry 5201 (class 0 OID 0)
-- Dependencies: 858
-- Name: FUNCTION st_multipolyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipolyfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5202 (class 0 OID 0)
-- Dependencies: 834
-- Name: FUNCTION st_multipolygonfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text) TO application_role;


--
-- TOC entry 5203 (class 0 OID 0)
-- Dependencies: 833
-- Name: FUNCTION st_multipolygonfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_multipolygonfromtext(text, integer) TO application_role;


--
-- TOC entry 5204 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION st_ndims(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ndims(public.geometry) TO application_role;


--
-- TOC entry 5205 (class 0 OID 0)
-- Dependencies: 676
-- Name: FUNCTION st_node(g public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_node(g public.geometry) TO application_role;


--
-- TOC entry 5206 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION st_normalize(geom public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_normalize(geom public.geometry) TO application_role;


--
-- TOC entry 5207 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION st_npoints(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_npoints(public.geometry) TO application_role;


--
-- TOC entry 5208 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION st_nrings(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_nrings(public.geometry) TO application_role;


--
-- TOC entry 5209 (class 0 OID 0)
-- Dependencies: 791
-- Name: FUNCTION st_numgeometries(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_numgeometries(public.geometry) TO application_role;


--
-- TOC entry 5210 (class 0 OID 0)
-- Dependencies: 796
-- Name: FUNCTION st_numinteriorring(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_numinteriorring(public.geometry) TO application_role;


--
-- TOC entry 5211 (class 0 OID 0)
-- Dependencies: 795
-- Name: FUNCTION st_numinteriorrings(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_numinteriorrings(public.geometry) TO application_role;


--
-- TOC entry 5212 (class 0 OID 0)
-- Dependencies: 801
-- Name: FUNCTION st_numpatches(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_numpatches(public.geometry) TO application_role;


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 790
-- Name: FUNCTION st_numpoints(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_numpoints(public.geometry) TO application_role;


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 643
-- Name: FUNCTION st_offsetcurve(line public.geometry, distance double precision, params text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_offsetcurve(line public.geometry, distance double precision, params text) TO application_role;


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 733
-- Name: FUNCTION st_orderingequals(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_orderingequals(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 642
-- Name: FUNCTION st_orientedenvelope(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_orientedenvelope(public.geometry) TO application_role;


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 728
-- Name: FUNCTION st_overlaps(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_overlaps(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 802
-- Name: FUNCTION st_patchn(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_patchn(public.geometry, integer) TO application_role;


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 469
-- Name: FUNCTION st_perimeter(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_perimeter(public.geometry) TO application_role;


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 951
-- Name: FUNCTION st_perimeter(geog public.geography, use_spheroid boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_perimeter(geog public.geography, use_spheroid boolean) TO application_role;


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION st_perimeter2d(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_perimeter2d(public.geometry) TO application_role;


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 1004
-- Name: FUNCTION st_point(double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision) TO application_role;


--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 1005
-- Name: FUNCTION st_point(double precision, double precision, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_point(double precision, double precision, srid integer) TO application_role;


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 788
-- Name: FUNCTION st_pointfromgeohash(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointfromgeohash(text, integer) TO application_role;


--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 816
-- Name: FUNCTION st_pointfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointfromtext(text) TO application_role;


--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 817
-- Name: FUNCTION st_pointfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointfromtext(text, integer) TO application_role;


--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 840
-- Name: FUNCTION st_pointfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea) TO application_role;


--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 839
-- Name: FUNCTION st_pointfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION st_pointinsidecircle(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointinsidecircle(public.geometry, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5230 (class 0 OID 0)
-- Dependencies: 989
-- Name: FUNCTION st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO application_role;


--
-- TOC entry 5231 (class 0 OID 0)
-- Dependencies: 800
-- Name: FUNCTION st_pointn(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointn(public.geometry, integer) TO application_role;


--
-- TOC entry 5232 (class 0 OID 0)
-- Dependencies: 741
-- Name: FUNCTION st_pointonsurface(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointonsurface(public.geometry) TO application_role;


--
-- TOC entry 5233 (class 0 OID 0)
-- Dependencies: 658
-- Name: FUNCTION st_points(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_points(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_points(public.geometry) TO application_role;


--
-- TOC entry 5234 (class 0 OID 0)
-- Dependencies: 1006
-- Name: FUNCTION st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO application_role;


--
-- TOC entry 5235 (class 0 OID 0)
-- Dependencies: 1007
-- Name: FUNCTION st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO application_role;


--
-- TOC entry 5236 (class 0 OID 0)
-- Dependencies: 820
-- Name: FUNCTION st_polyfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polyfromtext(text) TO application_role;


--
-- TOC entry 5237 (class 0 OID 0)
-- Dependencies: 821
-- Name: FUNCTION st_polyfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polyfromtext(text, integer) TO application_role;


--
-- TOC entry 5238 (class 0 OID 0)
-- Dependencies: 846
-- Name: FUNCTION st_polyfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea) TO application_role;


--
-- TOC entry 5239 (class 0 OID 0)
-- Dependencies: 845
-- Name: FUNCTION st_polyfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polyfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5240 (class 0 OID 0)
-- Dependencies: 1008
-- Name: FUNCTION st_polygon(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygon(public.geometry, integer) TO application_role;


--
-- TOC entry 5241 (class 0 OID 0)
-- Dependencies: 823
-- Name: FUNCTION st_polygonfromtext(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text) TO application_role;


--
-- TOC entry 5242 (class 0 OID 0)
-- Dependencies: 822
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonfromtext(text, integer) TO application_role;


--
-- TOC entry 5243 (class 0 OID 0)
-- Dependencies: 848
-- Name: FUNCTION st_polygonfromwkb(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea) TO application_role;


--
-- TOC entry 5244 (class 0 OID 0)
-- Dependencies: 847
-- Name: FUNCTION st_polygonfromwkb(bytea, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonfromwkb(bytea, integer) TO application_role;


--
-- TOC entry 5245 (class 0 OID 0)
-- Dependencies: 540
-- Name: FUNCTION st_polygonize(public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry[]) TO application_role;


--
-- TOC entry 5246 (class 0 OID 0)
-- Dependencies: 949
-- Name: FUNCTION st_project(geog public.geography, distance double precision, azimuth double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_project(geog public.geography, distance double precision, azimuth double precision) TO application_role;


--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_quantizecoordinates(g public.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO application_role;


--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 668
-- Name: FUNCTION st_reduceprecision(geom public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_reduceprecision(geom public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 696
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 697
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, integer) TO application_role;


--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 698
-- Name: FUNCTION st_relate(geom1 public.geometry, geom2 public.geometry, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_relate(geom1 public.geometry, geom2 public.geometry, text) TO application_role;


--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 675
-- Name: FUNCTION st_relatematch(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_relatematch(text, text) TO application_role;


--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 533
-- Name: FUNCTION st_removepoint(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_removepoint(public.geometry, integer) TO application_role;


--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 664
-- Name: FUNCTION st_removerepeatedpoints(geom public.geometry, tolerance double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_removerepeatedpoints(geom public.geometry, tolerance double precision) TO application_role;


--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION st_reverse(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_reverse(public.geometry) TO application_role;


--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 547
-- Name: FUNCTION st_rotate(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision) TO application_role;


--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 549
-- Name: FUNCTION st_rotate(public.geometry, double precision, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, public.geometry) TO application_role;


--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 548
-- Name: FUNCTION st_rotate(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotate(public.geometry, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5259 (class 0 OID 0)
-- Dependencies: 552
-- Name: FUNCTION st_rotatex(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotatex(public.geometry, double precision) TO application_role;


--
-- TOC entry 5260 (class 0 OID 0)
-- Dependencies: 553
-- Name: FUNCTION st_rotatey(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotatey(public.geometry, double precision) TO application_role;


--
-- TOC entry 5261 (class 0 OID 0)
-- Dependencies: 550
-- Name: FUNCTION st_rotatez(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_rotatez(public.geometry, double precision) TO application_role;


--
-- TOC entry 5262 (class 0 OID 0)
-- Dependencies: 556
-- Name: FUNCTION st_scale(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 5263 (class 0 OID 0)
-- Dependencies: 559
-- Name: FUNCTION st_scale(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision) TO application_role;


--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 557
-- Name: FUNCTION st_scale(public.geometry, public.geometry, origin public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, public.geometry, origin public.geometry) TO application_role;


--
-- TOC entry 5265 (class 0 OID 0)
-- Dependencies: 558
-- Name: FUNCTION st_scale(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_scale(public.geometry, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5266 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION st_scroll(public.geometry, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_scroll(public.geometry, public.geometry) TO application_role;


--
-- TOC entry 5267 (class 0 OID 0)
-- Dependencies: 953
-- Name: FUNCTION st_segmentize(geog public.geography, max_segment_length double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_segmentize(geog public.geography, max_segment_length double precision) TO application_role;


--
-- TOC entry 5268 (class 0 OID 0)
-- Dependencies: 628
-- Name: FUNCTION st_segmentize(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_segmentize(public.geometry, double precision) TO application_role;


--
-- TOC entry 5269 (class 0 OID 0)
-- Dependencies: 623
-- Name: FUNCTION st_seteffectivearea(public.geometry, double precision, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_seteffectivearea(public.geometry, double precision, integer) TO application_role;


--
-- TOC entry 5270 (class 0 OID 0)
-- Dependencies: 534
-- Name: FUNCTION st_setpoint(public.geometry, integer, public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_setpoint(public.geometry, integer, public.geometry) TO application_role;


--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 973
-- Name: FUNCTION st_setsrid(geog public.geography, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_setsrid(geog public.geography, srid integer) TO application_role;


--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 585
-- Name: FUNCTION st_setsrid(geom public.geometry, srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_setsrid(geom public.geometry, srid integer) TO application_role;


--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 673
-- Name: FUNCTION st_sharedpaths(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_sharedpaths(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION st_shiftlongitude(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_shiftlongitude(public.geometry) TO application_role;


--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 865
-- Name: FUNCTION st_shortestline(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_shortestline(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 551
-- Name: FUNCTION st_simplify(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision) TO application_role;


--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 569
-- Name: FUNCTION st_simplify(public.geometry, double precision, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_simplify(public.geometry, double precision, boolean) TO application_role;


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 647
-- Name: FUNCTION st_simplifypreservetopology(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_simplifypreservetopology(public.geometry, double precision) TO application_role;


--
-- TOC entry 5279 (class 0 OID 0)
-- Dependencies: 581
-- Name: FUNCTION st_simplifyvw(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_simplifyvw(public.geometry, double precision) TO application_role;


--
-- TOC entry 5280 (class 0 OID 0)
-- Dependencies: 674
-- Name: FUNCTION st_snap(geom1 public.geometry, geom2 public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_snap(geom1 public.geometry, geom2 public.geometry, double precision) TO application_role;


--
-- TOC entry 5281 (class 0 OID 0)
-- Dependencies: 626
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision) TO application_role;


--
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 608
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision) TO application_role;


--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 607
-- Name: FUNCTION st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_snaptogrid(public.geometry, double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 627
-- Name: FUNCTION st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_snaptogrid(geom1 public.geometry, geom2 public.geometry, double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5285 (class 0 OID 0)
-- Dependencies: 672
-- Name: FUNCTION st_split(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_split(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 1017
-- Name: FUNCTION st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_square(size double precision, cell_i integer, cell_j integer, origin public.geometry) TO application_role;


--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 1019
-- Name: FUNCTION st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_squaregrid(size double precision, bounds public.geometry, OUT geom public.geometry, OUT i integer, OUT j integer) TO application_role;


--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 972
-- Name: FUNCTION st_srid(geog public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_srid(geog public.geography) TO application_role;


--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 586
-- Name: FUNCTION st_srid(geom public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_srid(geom public.geometry) TO application_role;


--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 803
-- Name: FUNCTION st_startpoint(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_startpoint(public.geometry) TO application_role;


--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 667
-- Name: FUNCTION st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_subdivide(geom public.geometry, maxvertices integer, gridsize double precision) TO application_role;


--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 970
-- Name: FUNCTION st_summary(public.geography); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_summary(public.geography) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_summary(public.geography) TO application_role;


--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION st_summary(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_summary(public.geometry) TO application_role;


--
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 868
-- Name: FUNCTION st_swapordinates(geom public.geometry, ords cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_swapordinates(geom public.geometry, ords cstring) TO application_role;


--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 659
-- Name: FUNCTION st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_symdifference(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 660
-- Name: FUNCTION st_symmetricdifference(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_symmetricdifference(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 536
-- Name: FUNCTION st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_tileenvelope(zoom integer, x integer, y integer, bounds public.geometry, margin double precision) TO application_role;


--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 720
-- Name: FUNCTION st_touches(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_touches(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 587
-- Name: FUNCTION st_transform(public.geometry, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_transform(public.geometry, integer) TO application_role;


--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 588
-- Name: FUNCTION st_transform(geom public.geometry, to_proj text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, to_proj text) TO application_role;


--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 590
-- Name: FUNCTION st_transform(geom public.geometry, from_proj text, to_srid integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_srid integer) TO application_role;


--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 589
-- Name: FUNCTION st_transform(geom public.geometry, from_proj text, to_proj text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_transform(geom public.geometry, from_proj text, to_proj text) TO application_role;


--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 555
-- Name: FUNCTION st_translate(public.geometry, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision) TO application_role;


--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 554
-- Name: FUNCTION st_translate(public.geometry, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_translate(public.geometry, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 560
-- Name: FUNCTION st_transscale(public.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_transscale(public.geometry, double precision, double precision, double precision, double precision) TO application_role;


--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 663
-- Name: FUNCTION st_unaryunion(public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_unaryunion(public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 695
-- Name: FUNCTION st_union(public.geometry[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_union(public.geometry[]) TO application_role;


--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 661
-- Name: FUNCTION st_union(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 662
-- Name: FUNCTION st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_union(geom1 public.geometry, geom2 public.geometry, gridsize double precision) TO application_role;


--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 681
-- Name: FUNCTION st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_voronoilines(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO application_role;


--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 680
-- Name: FUNCTION st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_voronoipolygons(g1 public.geometry, tolerance double precision, extend_to public.geometry) TO application_role;


--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 725
-- Name: FUNCTION st_within(geom1 public.geometry, geom2 public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_within(geom1 public.geometry, geom2 public.geometry) TO application_role;


--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 1009
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_wkbtosql(wkb bytea) TO application_role;


--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 815
-- Name: FUNCTION st_wkttosql(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_wkttosql(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_wkttosql(text) TO application_role;


--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION st_wrapx(geom public.geometry, wrap double precision, move double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_wrapx(geom public.geometry, wrap double precision, move double precision) TO application_role;


--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION st_x(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_x(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_x(public.geometry) TO application_role;


--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION st_xmax(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_xmax(public.box3d) TO application_role;


--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION st_xmin(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_xmin(public.box3d) TO application_role;


--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION st_y(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_y(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_y(public.geometry) TO application_role;


--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION st_ymax(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ymax(public.box3d) TO application_role;


--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION st_ymin(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_ymin(public.box3d) TO application_role;


--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION st_z(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_z(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_z(public.geometry) TO application_role;


--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION st_zmax(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_zmax(public.box3d) TO application_role;


--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION st_zmflag(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_zmflag(public.geometry) TO application_role;


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION st_zmin(public.box3d); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_zmin(public.box3d) TO application_role;


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 337
-- Name: FUNCTION strict_word_similarity(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.strict_word_similarity(text, text) TO application_role;


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 339
-- Name: FUNCTION strict_word_similarity_commutator_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.strict_word_similarity_commutator_op(text, text) TO application_role;


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 341
-- Name: FUNCTION strict_word_similarity_dist_commutator_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.strict_word_similarity_dist_commutator_op(text, text) TO application_role;


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 340
-- Name: FUNCTION strict_word_similarity_dist_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.strict_word_similarity_dist_op(text, text) TO application_role;


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 338
-- Name: FUNCTION strict_word_similarity_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.strict_word_similarity_op(text, text) TO application_role;


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 289
-- Name: FUNCTION svals(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.svals(public.hstore) TO application_role;


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 250
-- Name: FUNCTION tconvert(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.tconvert(text, text) TO application_role;


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 873
-- Name: FUNCTION unlockrows(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.unlockrows(text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.unlockrows(text) TO application_role;


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 580
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, integer) TO application_role;


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 579
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) TO application_role;


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 578
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO application_role;


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 348
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1() TO application_role;


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 349
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1mc() TO application_role;


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 350
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v3(namespace uuid, name text) TO application_role;


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 352
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v5(namespace uuid, name text) TO application_role;


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 343
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_nil() TO application_role;


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 344
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_dns() TO application_role;


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 346
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_oid() TO application_role;


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 345
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_url() TO application_role;


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 347
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_x500() TO application_role;


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 259
-- Name: FUNCTION word_similarity(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.word_similarity(text, text) TO application_role;


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 262
-- Name: FUNCTION word_similarity_commutator_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.word_similarity_commutator_op(text, text) TO application_role;


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 322
-- Name: FUNCTION word_similarity_dist_commutator_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.word_similarity_dist_commutator_op(text, text) TO application_role;


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 321
-- Name: FUNCTION word_similarity_dist_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.word_similarity_dist_op(text, text) TO application_role;


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 260
-- Name: FUNCTION word_similarity_op(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.word_similarity_op(text, text) TO application_role;


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 1792
-- Name: FUNCTION st_3dextent(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_3dextent(public.geometry) TO application_role;


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 1808
-- Name: FUNCTION st_asflatgeobuf(anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement) TO application_role;


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 1809
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean) TO application_role;


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 1810
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asflatgeobuf(anyelement, boolean, text) TO application_role;


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 1806
-- Name: FUNCTION st_asgeobuf(anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement) TO application_role;


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 1807
-- Name: FUNCTION st_asgeobuf(anyelement, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asgeobuf(anyelement, text) TO application_role;


--
-- TOC entry 5357 (class 0 OID 0)
-- Dependencies: 1801
-- Name: FUNCTION st_asmvt(anyelement); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement) TO application_role;


--
-- TOC entry 5358 (class 0 OID 0)
-- Dependencies: 1802
-- Name: FUNCTION st_asmvt(anyelement, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text) TO application_role;


--
-- TOC entry 5359 (class 0 OID 0)
-- Dependencies: 1803
-- Name: FUNCTION st_asmvt(anyelement, text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer) TO application_role;


--
-- TOC entry 5360 (class 0 OID 0)
-- Dependencies: 1804
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text) TO application_role;


--
-- TOC entry 5361 (class 0 OID 0)
-- Dependencies: 1805
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_asmvt(anyelement, text, integer, text, text) TO application_role;


--
-- TOC entry 5362 (class 0 OID 0)
-- Dependencies: 1798
-- Name: FUNCTION st_clusterintersecting(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterintersecting(public.geometry) TO application_role;


--
-- TOC entry 5363 (class 0 OID 0)
-- Dependencies: 1799
-- Name: FUNCTION st_clusterwithin(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_clusterwithin(public.geometry, double precision) TO application_role;


--
-- TOC entry 5364 (class 0 OID 0)
-- Dependencies: 1797
-- Name: FUNCTION st_collect(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_collect(public.geometry) TO application_role;


--
-- TOC entry 5365 (class 0 OID 0)
-- Dependencies: 1793
-- Name: FUNCTION st_extent(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_extent(public.geometry) TO application_role;


--
-- TOC entry 5366 (class 0 OID 0)
-- Dependencies: 1791
-- Name: FUNCTION st_makeline(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_makeline(public.geometry) TO application_role;


--
-- TOC entry 5367 (class 0 OID 0)
-- Dependencies: 1790
-- Name: FUNCTION st_memcollect(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_memcollect(public.geometry) TO application_role;


--
-- TOC entry 5368 (class 0 OID 0)
-- Dependencies: 1794
-- Name: FUNCTION st_memunion(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_memunion(public.geometry) TO application_role;


--
-- TOC entry 5369 (class 0 OID 0)
-- Dependencies: 1800
-- Name: FUNCTION st_polygonize(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_polygonize(public.geometry) TO application_role;


--
-- TOC entry 5370 (class 0 OID 0)
-- Dependencies: 1795
-- Name: FUNCTION st_union(public.geometry); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_union(public.geometry) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_union(public.geometry) TO application_role;


--
-- TOC entry 5371 (class 0 OID 0)
-- Dependencies: 1796
-- Name: FUNCTION st_union(public.geometry, double precision); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO registry_owner_role;
GRANT ALL ON FUNCTION public.st_union(public.geometry, double precision) TO application_role;


--
-- TOC entry 5372 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE ddm_db_changelog; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_db_changelog TO registry_owner_role;
GRANT SELECT ON TABLE public.ddm_db_changelog TO admin_role;


--
-- TOC entry 5373 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE ddm_db_changelog_lock; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_db_changelog_lock TO registry_owner_role;
GRANT SELECT ON TABLE public.ddm_db_changelog_lock TO admin_role;


--
-- TOC entry 5374 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE ddm_geoserver_pk_metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_geoserver_pk_metadata TO registry_owner_role;
GRANT SELECT ON TABLE public.ddm_geoserver_pk_metadata TO geoserver_role;


--
-- TOC entry 5375 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE ddm_liquibase_metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_liquibase_metadata TO registry_owner_role;
GRANT SELECT ON TABLE public.ddm_liquibase_metadata TO geoserver_role;
GRANT SELECT ON TABLE public.ddm_liquibase_metadata TO admin_role;


--
-- TOC entry 5376 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE ddm_rls_metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_rls_metadata TO registry_owner_role;


--
-- TOC entry 5377 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE ddm_role_permission; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_role_permission TO registry_owner_role;


--
-- TOC entry 5378 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE ddm_source_application; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_source_application TO registry_owner_role;


--
-- TOC entry 5379 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE ddm_source_business_process; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_source_business_process TO registry_owner_role;


--
-- TOC entry 5380 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE ddm_source_system; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ddm_source_system TO registry_owner_role;


--
-- TOC entry 5381 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE geography_columns; Type: ACL; Schema: public; Owner: postgres
--

REVOKE SELECT ON TABLE public.geography_columns FROM PUBLIC;
GRANT SELECT ON TABLE public.geography_columns TO geoserver_role;


--
-- TOC entry 5382 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE geometry_columns; Type: ACL; Schema: public; Owner: postgres
--

REVOKE SELECT ON TABLE public.geometry_columns FROM PUBLIC;
GRANT SELECT ON TABLE public.geometry_columns TO geoserver_role;


--
-- TOC entry 5383 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE spatial_ref_sys; Type: ACL; Schema: public; Owner: postgres
--

REVOKE SELECT ON TABLE public.spatial_ref_sys FROM PUBLIC;
GRANT SELECT ON TABLE public.spatial_ref_sys TO geoserver_role;


--
-- TOC entry 3133 (class 826 OID 19453)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO registry_owner_role;


--
-- TOC entry 3132 (class 826 OID 19452)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO registry_owner_role;


-- Completed on 2025-02-03 14:29:51 UTC

--
-- PostgreSQL database dump complete
--

