\set ECHO none

\i test/pgxntool/setup.sql

SELECT plan(4);

SELECT is(
  (SELECT count(*)::int FROM _cat_snap.entity)
  , 101
  , 'Number of entities'
);

SELECT types_are(
  'cat_snap'
  , array( SELECT replace( entity, 'pg_', 'raw_' )::name FROM _cat_snap.entity )
    || array( SELECT replace( entity, 'pg_', 'delta_' )::name FROM _cat_snap.entity WHERE entity_type = 'Stats File' )
  , 'Verify types'
);

SELECT ok(
  (SELECT delta_keys @> array['queryid'] FROM _cat_snap.entity WHERE entity = 'pg_stat_statements')
  , 'Verify queryid exists in pg_stat_statements delta_keys'
);

SELECT is(
  (SELECT extra_attributes FROM _cat_snap.entity WHERE entity = 'pg_stat_activity')
  , array[row('waiting','boolean')::_cat_snap.attribute] 
  , 'Verify waiting exists in pg_stat_activity attributes'
);

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
