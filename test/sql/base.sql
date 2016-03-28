\set ECHO none

\i test/pgxntool/setup.sql

SELECT plan(2);

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

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
