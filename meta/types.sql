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
