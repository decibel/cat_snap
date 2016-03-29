SELECT format(
    $$INSERT INTO _cat_snap.catalog VALUES( %s, %L, %L );$$
    , version
    , entity_name
    , attributes
  )
  FROM catalog_relations
  WHERE version > 9.1 -- Currently don't support old procpid field in pg_stat_activity
;

-- vi: expandtab ts=2 sw=2
