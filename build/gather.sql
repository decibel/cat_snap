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
  c := _cat_snap.catalog__get(version, entity, missing_ok := TRUE);

  RETURN format(
    $$SELECT row(%s) FROM pg_catalog.%s$$
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

CREATE FUNCTION cat_snap.snapshot_code(
  version numeric
  , cluster_identifier text DEFAULT NULL
  , snapshot_type text DEFAULT 'all'
  , indent text DEFAULT ''
) RETURNS text LANGUAGE plpgsql STABLE AS $body$
DECLARE
  c_snapshot_type CONSTANT text := replace( lower(snapshot_type), ' ', '_' );
  c_entity_type CONSTANT text := initcap( replace( c_snapshot_type, '_', ' ' ) );
BEGIN
  IF c_snapshot_type NOT IN ( 'all', 'catalog', 'stats_file', 'other_status' ) THEN
    RAISE EXCEPTION 'Unknown snapshot type "%"', snapshot_type;
  END IF;

  IF c_snapshot_type = 'all' THEN
    IF coalesce(indent,'') != '' THEN
      RAISE EXCEPTION 'indent may not be specified for an "all" snapshot';
    END IF;
    RETURN format(
      $$SELECT row(
  1::int -- snapshot_version
  , current_database() -- database_name
  , %L::text -- cluster_identifier
  , (%s) -- catalog
  , (%s) -- stats_file
  , (%s) -- other_status
);$$
      , cluster_identifier
      , cat_snap.snapshot_code(version, NULL, 'catalog', '    ')
      , cat_snap.snapshot_code(version, NULL, 'stats_file', '    ')
      , cat_snap.snapshot_code(version, NULL, 'other_status', '    ')
    );
  ELSE
    IF cluster_identifier IS NOT NULL THEN
      RAISE EXCEPTION 'cluster_identifier may only be specified for snapshot type "all"';
    END IF;

    RETURN format(
      $$
%1$sSELECT row(
%1$s  1::int -- snapshot_version
%1$s  , %2$s
%1$s  , array(%3$s)
%1$s)
%1$s$$
      , indent
      , CASE WHEN c_snapshot_type = 'stats_file' THEN 'pg_stat_get_snapshot_timestamp()'
          ELSE $$now() -- transaction_start
$$ || indent || $$  , clock_timestamp()$$
        END
      , array_to_string(
          array(
            SELECT cat_snap.gather_code(version, entity)
              FROM _cat_snap.entity
              WHERE entity_type = c_entity_type::_cat_snap.entity_type
              ORDER BY entity
          )
          , E')\n' || indent || '  , array('
        )
      )
      -- If we don't have an indent assume we're being called for a single-shot and append a ;
      || CASE WHEN coalesce(indent,'') = '' THEN ';' ELSE '' END
    ;
  END IF;
END
$body$;

-- vi: expandtab ts=2 sw=2
