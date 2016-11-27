SET log_min_messages = WARNING;
SET client_min_messages = WARNING;
BEGIN;
CREATE EXTENSION IF NOT EXISTS cat_tools;
--CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

\i common/types.sql

CREATE TABLE extra(
  relname text NOT NULL PRIMARY KEY
  , extra_attributes attribute[] NOT NULL
);
INSERT INTO extra VALUES
  ( 'pg_stat_activity', array[ row('waiting', 'boolean')::attribute ] )
;

SELECT format(
      $$INSERT INTO entity VALUES( %L, %L, %L, %L, %L, %L, %L );$$
      , relname
      , entity_type
      , attributes
      , extra_attributes
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
    , array( SELECT (a).attribute_name FROM unnest(attributes) a WHERE attribute_type = 'oid' ) AS delta_keys
    , array(
        SELECT (a).attribute_name FROM unnest(attributes) a
        WHERE attribute_type IN ('bigint'::regtype::text, 'double precision'::regtype::text)
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
        CASE WHEN 
          relname ~ '^pg_(replication_slots|roles|rules)'
          OR (
            relname ~ '^pg_stat'
              AND relname !~ 'progress|replication|_ssl|_wal_'
              AND relname NOT IN( 'pg_stat_activity', 'pg_stats' )
          )
          THEN 'Stats File'
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
      FALSE --relname = 'pg_stat_statements'
      OR (
        relschema='pg_catalog'
        AND (
            ( relkind = 'r' AND relname !~ '^pg_(authid|largeobject|statistic)' )
            OR ( relkind = 'v' AND (
                  relname = 'pg_stat_user_functions' 
                  OR ( relname ~ '^pg_stat' AND relname !~ '_(user|sys|xact)_' AND relname != 'pg_stats' )
                  OR relname !~ '^pg_(group|indexes|matviews|policies|shadow|stat|tables|user|views)'
            ) )
        )
      )
    )
) a
) a
    LEFT JOIN extra USING( relname )
  ORDER BY relname
;
ROLLBACK;

-- vi: expandtab ts=2 sw=2
