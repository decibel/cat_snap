\set ECHO none

\i test/pgxntool/setup.sql

CREATE TEMP VIEW versions AS
  SELECT * FROM unnest('{9.2,9.3,9.4,9.5,9.6}'::numeric[]) u(version)
;
CREATE TEMP VIEW entity_ver AS
  SELECT entity, version
    FROM versions, _cat_snap.entity
;
CREATE TEMP VIEW missing_entity AS
    SELECT * FROM entity_ver
  EXCEPT ALL
    SELECT entity, version
      FROM _cat_snap.catalog
  ORDER BY entity, version
;
CREATE TEMP TABLE missing_expected AS SELECT * FROM missing_entity WHERE false;
INSERT INTO missing_expected
  SELECT *
    FROM entity_ver
    WHERE version < 9.6
      AND entity = ANY('{pg_config,pg_init_privs,pg_stat_progress_vacuum,pg_stat_wal_receiver}'::text[])
;
INSERT INTO missing_expected
  SELECT *
    FROM entity_ver
    WHERE version < 9.5
      AND entity = ANY('{pg_file_settings,pg_policy,pg_replication_origin,pg_replication_origin_status,pg_stat_ssl,pg_transform}'::text[])
;
INSERT INTO missing_expected
  SELECT *
    FROM entity_ver
    WHERE version < 9.4
      AND entity = ANY('{pg_stat_archiver,pg_replication_slots}'::text[])
;
INSERT INTO missing_expected
  SELECT *
    FROM entity_ver
    WHERE version < 9.3
      AND entity = ANY('{pg_event_trigger}'::text[])
;

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
  'SELECT row(datid, datname, pid, usesysid, usename, application_name, client_addr, client_hostname, client_port, backend_start, xact_start, query_start, state_change, '
    || expected
    || ') FROM pg_catalog.pg_stat_activity'
;

SELECT plan(
  2   -- entities
  +1  -- types

  --+1  -- pg_stat_statements

  -- pg_stat_activity
  +1  -- waiting
  +(SELECT count(*)::int FROM gather_code_expected)

  -- snapshot_all
  +(SELECT count(*)::int FROM versions)
);

SELECT is(
  (SELECT count(*)::int FROM _cat_snap.entity)
  , 82
  , 'Number of entities'
);

SELECT bag_eq(
  $$SELECT * FROM missing_entity$$
  , $$SELECT * FROM missing_expected$$
  , 'Check expected missing entities'
);

SELECT types_are(
  'cat_snap'
  , array( SELECT replace( entity, 'pg_', 'raw_' )::name FROM _cat_snap.entity )
    || array( SELECT replace( entity, 'pg_', 'delta_' )::name FROM _cat_snap.entity WHERE entity_type = 'Stats File' )
    || '{snapshot_all,snapshot_catalog,snapshot_stats_file,snapshot_other_status}'::name[]
  , 'Verify types'
);

/*
SELECT ok(
  (SELECT delta_keys @> array['queryid'] FROM _cat_snap.entity WHERE entity = 'pg_stat_statements')
  , 'Verify queryid exists in pg_stat_statements delta_keys'
);
*/

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
  format( $$SELECT cat_snap.snapshot_code(%L, cluster_identifier := 'cluster id')$$, version )
  , format( $$SELECT cat_snap.snapshot_code(%L, cluster_identifier := 'cluster id')$$, version )
) FROM versions
;

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
