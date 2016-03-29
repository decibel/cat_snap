#!/bin/sh

cat << _EOF_
CREATE TABLE _cat_snap.catalog(
	version			numeric			NOT NULL
	, entity		text			NOT NULL
	, CONSTRAINT catalog__pk_version__entity PRIMARY KEY( version, entity )
	, attributes	attribute[]		NOT NULL
);
_EOF_

psql -qt -v ON_ERROR_STOP=1 -f meta/catalog.sql catalog || exit 1


# vi: noexpandtab
