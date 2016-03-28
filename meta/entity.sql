SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
BEGIN;
CREATE EXTENSION IF NOT EXISTS cat_tools;

-- See also entity.sh if you change this
CREATE TYPE attribute AS( attribute_name text, attribute_type regtype );

SELECT format(
      $$INSERT INTO entity VALUES( %L, %L, %L, %L, %L, %L );$$
      , relname
      , entity_type
      , attributes
      , CASE WHEN entity_type = 'Stats File' THEN delta_keys END
      , CASE WHEN entity_type = 'Stats File' THEN delta_counters END
      , CASE WHEN entity_type = 'Stats File' THEN delta_fields END
    )
  FROM (
/*
 * Add details of how to delta
 */
SELECT
    *
    , array( SELECT (a).attribute_name FROM unnest(attributes) a WHERE attribute_type = 'oid'::regtype ) AS delta_keys
    , array(
        SELECT (a).attribute_name FROM unnest(attributes) a
        WHERE attribute_type IN ('bigint'::regtype, 'double precision')
      ) AS delta_counters
    , array(
        SELECT (a).attribute_name FROM unnest(attributes) a
        WHERE FALSE --attribute_type IN ('timestamptz'::regtype)
      ) AS delta_fields
  FROM (
/*
 * Get all catalog and stat entries, along with details of their attributes
 */
SELECT
    relname::text
    /*
     * The replication views have stats in them. pg_replication_origin is a
     * table and we don't want to treat it as stats, hence the check on
     * relkind.
     */
    , CASE WHEN relkind = 'v' THEN
        CASE WHEN relname ~ '^pg_(stat|replication)' THEN 'Stats File'
        ELSE 'Other Status'
        END
      ELSE 'Catalog'
      END AS entity_type
    , array(
      SELECT
          row(
            attname
            , CASE
              WHEN column_type IN ( 'name', 'anyarray' ) THEN 'text'
              ELSE column_type
            END
          )::attribute
        FROM _cat_tools.column cc
        WHERE cc.reloid = c.reloid
          AND ( attnum>0 OR attname IN( 'xmin', 'oid' ) )
          AND NOT attisdropped -- Be paranoid...
        ORDER BY attnum
      ) AS attributes
  FROM _cat_tools.pg_class_v c
  WHERE
    (
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
    )
) a
) a
  ORDER BY relname
;
ROLLBACK;

-- vi: expandtab ts=2 sw=2
