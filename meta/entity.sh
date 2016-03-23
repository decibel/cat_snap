#!/bin/sh

cat << _EOF_
CREATE TABLE entity(
	entity		text		NOT NULL PRIMARY KEY
	, stat		boolean		NOT NULL
);

COPY entity FROM STDIN;
_EOF_

psql -qt -v ON_ERROR_STOP=1 -f meta/entity.sql || exit 1

echo '\.'

# vi: noexpandtab ts=4 sw=4
