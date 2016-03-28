SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

BEGIN;
\i generated/entity.dmp

SELECT format(
        $$CREATE TYPE %s AS (%s);$$
        , replace( entity, 'pg_', 'raw_' )
        , array_to_string(
            array(
                SELECT attribute_name || ' ' || attribute_type
                    FROM unnest(e.attributes)
            )
            , ', '
        )
    )
    FROM entity e
    ORDER BY entity
;
