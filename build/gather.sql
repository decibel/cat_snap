CREATE FUNCTION cat_snap.gather_code(
    version numeric
    , entity text
) RETURNS text LANGUAGE plpgsql STABLE AS $body$
DECLARE
  e _cat_snap.entity;
  c _cat_snap.catalog;

  a _cat_snap.attribute;
BEGIN
  e := _cat_snap.entity__get(entity);
  c := _cat_snap.catalog__get(version, entity);

  RETURN format(
    $$SELECT %s FROM pg_catalog.%s$$
    , array_to_string(
      array(
        SELECT CASE WHEN array[attribute_name] <@ array(SELECT attribute_name FROM unnest(c.attributes))
              THEN attribute_name
              ELSE 'NULL'
              END
          FROM unnest(e.attributes || e.extra_attributes)
      )
      , ', '
    )
    , entity
  );
END
$body$;

-- vi: expandtab ts=2 sw=2
