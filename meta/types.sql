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
$$CREATE TYPE snapshot_%s AS (
    snapshot_version     int
    , %s
    , %s
);$$
    , replace( lower(entity_type::text), ' ', '_' )
    , CASE WHEN entity_type = 'Stats File' THEN 'snapshot_timestamp     timestamptz'
        ELSE 'transaction_start     timestamptz
    , clock_timestamp        timestamptz'
    END
    , array_to_string(
        array( SELECT entity || ' ' || replace(entity, 'pg_', 'raw_') || '[]' FROM entity WHERE entity_type = t.entity_type ORDER BY entity )
        , E'\n    , '
    )
)
    FROM (SELECT DISTINCT entity_type FROM entity) t
;

SELECT 
$$CREATE TYPE snapshot_all AS (
    snapshot_version     int
    , database_name         text
    , cluster_identifier    text
    , catalog               snapshot_catalog
    , stats_file            snapshot_stats_file
    , other_status          snapshot_other_status
);$$
;
