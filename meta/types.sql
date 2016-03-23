SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

BEGIN;
\i generated/entity.dmp

SELECT format(
        $$CREATE TYPE %s AS (%s);$$
        , replace( entity, 'pg_', 'raw_' )
        , array_to_string( array(
                SELECT attname || ' ' ||
                        CASE
                            WHEN column_type IN ( 'name', 'anyarray' ) THEN 'text'
                            ELSE column_type
                        END
                    FROM _cat_tools.column c
                    WHERE relschema = 'pg_catalog'
                        AND relname = entity
                        AND (attnum>0 OR attname = 'oid')
                    ORDER BY attnum), ', ')
    )
    FROM entity
    ORDER BY entity
;
