
CREATE OR REPLACE FUNCTION public.pgis_geometry_union_finalfn(
	internal)
    RETURNS geometry
    LANGUAGE 'c'
    COST 10000
    VOLATILE PARALLEL SAFE
AS '$libdir/postgis-3', 'pgis_geometry_union_finalfn'
;

--
-- Name: FUNCTION pgis_geometry_union_finalfn(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgis_geometry_union_finalfn(internal) TO registry_owner_role;
GRANT ALL ON FUNCTION public.pgis_geometry_union_finalfn(internal) TO application_role;