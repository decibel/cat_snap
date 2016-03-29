SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

BEGIN;
\i generated/entity.dmp

SELECT format(
        $$CREATE TYPE %s AS (%s);$$
        , replace( entity, 'pg_', 'raw_' )
        , array_to_string(
            base
            , ', '
        )
    )
    FROM entity_v
;
SELECT format(
        $$CREATE TYPE %s AS (%s);$$
        , replace( entity, 'pg_', 'delta_' )
        , array_to_string(
            delta || intervals
            , ', '
        )
    )
    FROM entity_v
    WHERE entity_type = 'Stats File'
;

SELECT format(
$$CREATE TYPE snapshot_stats_file AS (
    version     int
    , snapshot_timestamp    timestamptz
    , %s
);$$
    , array_to_string(
        array( SELECT entity || ' ' || replace(entity, 'pg_', 'raw_') || '[]' FROM entity WHERE entity_type = 'Stats File' )
        , E'\n    , '
    )
);
SELECT format(
$$CREATE TYPE snapshot_other_status AS (
    version     int
    , transaction_start     timestamptz
    , clock_time            timestamptz
    , %s
);$$
    , array_to_string(
        array( SELECT entity || ' ' || replace(entity, 'pg_', 'raw_') || '[]' FROM entity WHERE entity_type = 'Other Status' )
        , E'\n    , '
    )
);
SELECT format(
$$CREATE TYPE snapshot_catalog AS (
    version     int
    , transaction_start     timestamptz
    , clock_time            timestamptz
    , %s
);$$
    , array_to_string(
        array( SELECT entity || ' ' || replace(entity, 'pg_', 'raw_') || '[]' FROM entity WHERE entity_type = 'Catalog' )
        , E'\n    , '
    )
);

SELECT 
$$CREATE TYPE snapshot_all AS (
    version     int
    , database_name         text
    , cluster_identifier    text
    , catalog               snapshot_catalog
    , stats_file            snapshot_stats_file
    , other_status          snapshot_other_status
);$$
;
