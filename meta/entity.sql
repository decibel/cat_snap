SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

SELECT format(
      $$INSERT INTO entity VALUES( %L, %L );$$
      ,relname::text
      , relname ~ '^pg_stat'
    )
  FROM _cat_tools.pg_class_v r
  WHERE
    relname = 'pg_stat_statements'
    OR (
      relschema='pg_catalog'
    AND (
        ( relkind = 'r' AND relname !~ '^pg_(authid|statistic)' )
        OR ( relkind = 'v' AND (
              relname = 'pg_stat_user_functions' 
              OR ( relname ~ '^pg_stat' AND relname !~ '_(user|sys)_' )
              OR relname !~ '^pg_(group|indexes|shadow|tables|user|views)'
          ) )
      )
    )
  ORDER BY relname
;


-- vi: expandtab ts=2 sw=2
