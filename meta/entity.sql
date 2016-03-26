SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
BEGIN;
CREATE EXTENSION IF NOT EXISTS cat_tools;

-- See also entity.sh if you change this
CREATE TYPE attribute AS( attribute_name text, attribute_type regtype );

SELECT format(
      $$INSERT INTO entity VALUES( %L, %L, %L, %L, %L, %L );$$
      , relname
      , is_stat
      , attributes
      , CASE WHEN is_stat THEN subtract_keys END
      , CASE WHEN is_stat THEN subtract_counters END
      , CASE WHEN is_stat THEN subtract_fields END
    )
  FROM (
/*
 * Add details of how to subtract
 */
SELECT
    *
    , array( SELECT (a).attribute_name FROM unnest(attributes) a WHERE attribute_type = 'oid'::regtype ) AS subtract_keys
    , array(
        SELECT (a).attribute_name FROM unnest(attributes) a
        WHERE attribute_type IN ('bigint'::regtype, 'double precision')
      ) AS subtract_counters
    , array(
        SELECT (a).attribute_name FROM unnest(attributes) a
        WHERE attribute_type IN ('timestamptz'::regtype)
      ) AS subtract_fields
  FROM (
/*
 * Get all catalog and stat entries, along with details of their attributes
 */
SELECT
    relname::text
    , relname ~ '^pg_stat' AS is_stat
    , array_agg(
        row(
          attname
          , CASE
            WHEN column_type IN ( 'name', 'anyarray' ) THEN 'text'
            ELSE column_type
          END
        )::attribute
      ) AS attributes
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
) a
  ORDER BY relname
;
ROLLBACK;

-- vi: expandtab ts=2 sw=2
