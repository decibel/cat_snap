#!/bin/sh

cat << _EOF_
CREATE TYPE attribute AS( attribute_name text, attribute_type regtype );

CREATE TABLE entity(
	entity				text		NOT NULL PRIMARY KEY
	, is_stat			boolean		NOT NULL
	, attributes		attribute[]	NOT NULL
	, subtract_keys		text[]		
	, subtract_counters	text[]		
	, subtract_fields	text[]		
);

COMMENT ON COLUMN entity.is_stat IS 'True if this entity is a statistic entity.';
COMMENT ON COLUMN entity.subtract_keys IS 'Fields used to verify that two stat types that are being subtracted from each other refer to the same entity.';
COMMENT ON COLUMN entity.subtract_fields IS 'Fields that are counters. These can not be subtracted normally; they require special logic.';
COMMENT ON COLUMN entity.subtract_fields IS 'Fields to subtract when performing subtraction.';
_EOF_

psql -qt -v ON_ERROR_STOP=1 -f meta/entity.sql || exit 1

# vi: noexpandtab ts=4 sw=4
