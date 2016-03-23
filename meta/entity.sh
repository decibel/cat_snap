#!/bin/sh

cat << _EOF_
CREATE TABLE entity(
	entity		text		NOT NULL PRIMARY KEY
	, stat		boolean		NOT NULL
);

_EOF_

psql -qt -v ON_ERROR_STOP=1 -f meta/entity.sql || exit 1

# vi: noexpandtab ts=4 sw=4
