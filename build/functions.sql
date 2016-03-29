CREATE FUNCTION _cat_snap.entity__get(
  entity _cat_snap.entity.entity%TYPE
) RETURNS _cat_snap.entity LANGUAGE plpgsql STABLE AS $body$
DECLARE
  o _cat_snap.entity;
BEGIN
  SELECT INTO STRICT o *
    FROM _cat_snap.entity e
    WHERE e.entity = entity__get.entity
  ;
  RETURN o;
END
$body$;

CREATE FUNCTION _cat_snap.catalog__get(
  version _cat_snap.catalog.version%TYPE
  , entity _cat_snap.catalog.entity%TYPE
) RETURNS _cat_snap.catalog LANGUAGE plpgsql STABLE AS $body$
DECLARE
  o _cat_snap.catalog;
BEGIN
  SELECT INTO STRICT o *
    FROM _cat_snap.catalog c
    WHERE row(c.version, c.entity) = row(catalog__get.version, catalog__get.entity)
  ;
  RETURN o;
END
$body$;

-- vi: expandtab ts=2 sw=2
