SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
CREATE EXTENSION IF NOT EXISTS cat_tools;

SELECT format(
      $$INSERT INTO entity VALUES( %L, %L, %L, %L, %L, %L );$$
      , relname
      , is_stat
      , attributes
      , attribute_types
      , CASE WHEN is_stat THEN
          CASE WHEN relname = 'pg_stat_statements' THEN subtract_keys || array['queryid'] ELSE subtract_keys END
        END
      , CASE WHEN is_stat THEN subtract_counters END
      , CASE WHEN is_stat THEN subtract_fields END
    )
  FROM (
/*
 * Get all catalog and stat entries, along with details of their attributes and
 * how to subtract
 */
SELECT
    relname::text
    , relname ~ '^pg_stat' AS is_stat
    , array_agg(attname) AS attributes
    , array_agg(
        CASE
          WHEN column_type IN ( 'name', 'anyarray' ) THEN 'text'
          ELSE column_type
        END
      ) AS attribute_types
    , array_agg( CASE WHEN attname = 'oid' THEN attname::text END ) AS subtract_keys
    , array_agg( CASE WHEN column_type IN ( 'double precision', 'bigint' ) THEN attname::text END ) AS subtract_counters
    , array_agg( CASE WHEN column_type IN ( 'timestamp with timezone' ) THEN attname::text END ) AS subtract_fields
  FROM _cat_tools.column c
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
  GROUP BY relname
) a
  ORDER BY relname
;

-- vi: expandtab ts=2 sw=2
