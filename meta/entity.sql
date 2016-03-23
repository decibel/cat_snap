SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

COPY (
SELECT relname::text AS entity
    , relname ~ '^pg_stat' AS stat
  FROM _cat_tools.pg_class_v r
  WHERE relschema='pg_catalog'
    AND (
        ( relkind = 'r' AND relname !~ '^pg_(authid|statistic)' )
        OR ( relkind = 'v' AND (
              relname = 'pg_stat_user_functions' 
              OR ( relname ~ '^pg_stat' AND relname !~ '_(user|sys)_' )
              OR relname !~ '^pg_(group|indexes|shadow|tables|user|views)'
          ) )
      )
) TO STDOUT
;


-- vi: expandtab ts=2 sw=2
