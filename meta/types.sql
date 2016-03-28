SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

BEGIN;
\i generated/entity.dmp

CREATE TEMP VIEW entity_v AS
    SELECT *
        , array(
            SELECT attribute_name || ' ' || attribute_type
                FROM unnest(e.attributes)
            ) AS base
        , array(
            SELECT attribute_name
                    || CASE WHEN array[attribute_name] <@ (e.subtract_counters || e.subtract_fields) THEN '_d' ELSE '' END
                    || ' '
                    || attribute_type
                FROM unnest(e.attributes)
            ) AS delta
        , array(
            SELECT attribute_name || '_d interval'
                FROM unnest(e.attributes)
                WHERE attribute_type::text ~ '^timestamp with'
            ) AS intervals
    FROM entity e
    ORDER BY entity
;

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
