\set ECHO none

\i test/pgxntool/setup.sql

CREATE TEMP TABLE gather_code_expected(
  version numeric
  , expected text
);
INSERT INTO gather_code_expected VALUES
    ( 9.2, 'NULL, NULL, state, NULL, NULL, query, waiting' )
  , ( 9.3, 'NULL, NULL, state, NULL, NULL, query, waiting' )
  , ( 9.4, 'NULL, NULL, state, backend_xid, backend_xmin, query, waiting' )
  , ( 9.5, 'NULL, NULL, state, backend_xid, backend_xmin, query, waiting' )
  , ( 9.6, 'wait_event_type, wait_event, state, backend_xid, backend_xmin, query, NULL' )
;
UPDATE gather_code_expected SET expected =
  'SELECT datid, datname, pid, usesysid, usename, application_name, client_addr, client_hostname, client_port, backend_start, xact_start, query_start, state_change, '
    || expected
    || ' FROM pg_catalog.pg_stat_activity'
;

SELECT plan(
  1   -- entities
  +1  -- types
  +1  -- delta
  +1  -- extra_attributes
  +(SELECT count(*)::int FROM gather_code_expected)
  +1  -- snapshot_all
);

SELECT is(
  (SELECT count(*)::int FROM _cat_snap.entity)
  , 84
  , 'Number of entities'
);

SELECT types_are(
  'cat_snap'
  , array( SELECT replace( entity, 'pg_', 'raw_' )::name FROM _cat_snap.entity )
    || array( SELECT replace( entity, 'pg_', 'delta_' )::name FROM _cat_snap.entity WHERE entity_type = 'Stats File' )
    || '{snapshot_all,snapshot_catalog,snapshot_stats_file,snapshot_other_status}'::name[]
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

SELECT is(
      cat_snap.gather_code( version, 'pg_stat_activity' )
      , expected
      , 'Verify gather code for ' || version || ' pg_stat_activity'
    )
  FROM gather_code_expected
;

SELECT lives_ok(
  $$SELECT cat_snap.snapshot_code($$ || substring(version() from '[0-9]+\.[0-9]+') || $$, cluster_identifier = 'cluster id')$$
  , 'Verify we can call snapshot_code( our version # )'
);

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
