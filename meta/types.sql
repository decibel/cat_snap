SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;
SELECT format(
        $$CREATE TYPE %s AS (%s);$$
        , replace( relname, 'pg_', 'raw_' )
        , array_to_string( array(
                SELECT attname || ' ' ||
                        CASE
                            WHEN column_type IN ( 'name', 'anyarray' ) THEN 'text'
                            ELSE column_type
                        END
                    FROM _cat_tools.column c
                    WHERE attrelid = r.reloid
                        AND (attnum>0 OR attname = 'oid')
                    ORDER BY attnum), ', ')
    )
    FROM _cat_tools.pg_class_v r
    WHERE relschema='pg_catalog'
        AND (
            ( relkind = 'r' AND relname !~ '^pg_(authid|statistic)' )
            OR ( relkind = 'v' AND (
                    relname = 'pg_stat_user_functions' 
                    OR ( relname ~ '^pg_stat' AND relname !~ '_(user|sys)_' )
                    OR relname !~ '^pg_(group|indexes|shadow|tables|user|views)'
                )
            )
        )
;
