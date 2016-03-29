#!/bin/sh

# attribute type is needed by types.sql, which loads entity.dmp
cat common/types.sql

cat << _EOF_
CREATE TYPE entity_type AS ENUM(
	'Catalog'
	, 'Stats File'
	, 'Other Status'
);

CREATE TABLE entity(
	entity				text		NOT NULL PRIMARY KEY
	, entity_type		entity_type	NOT NULL
	, attributes		attribute[]	NOT NULL
	, extra_attributes	attribute[]
	, delta_keys		text[]		
	, delta_counters	text[]		
	, delta_fields	text[]		
);

COMMENT ON COLUMN entity.delta_keys IS 'Fields used to verify that two stat types that are being deltaed from each other refer to the same entity.';
COMMENT ON COLUMN entity.delta_fields IS 'Fields that are counters. These can not be deltaed normally; they require special logic.';
COMMENT ON COLUMN entity.delta_fields IS 'Fields to delta when performing deltaion.';
_EOF_

psql -qt -v ON_ERROR_STOP=1 -f meta/entity.sql || exit 1

cat << _EOF_
UPDATE entity SET delta_keys = delta_keys || array['queryid'] WHERE entity = 'pg_stat_statements' AND NOT delta_keys @> array['queryid'];
_EOF_

# vi: noexpandtab ts=4 sw=4
