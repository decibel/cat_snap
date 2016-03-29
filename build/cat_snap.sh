#!/bin/sh

echo_cat() {
  echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!'
  echo "-- Generated from $1"
  cat $1
}

cat << _EOF_
-- THIS IS A GENERATED FILE. DO NOT EDIT!

SET client_min_messages = WARNING;

CREATE SCHEMA cat_snap;
CREATE SCHEMA _cat_snap;

SET search_path = _cat_snap, cat_snap;
_EOF_

echo_cat generated/entity.dmp

echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!'
echo '-- Generated from generated/types.sql'
echo 'SET search_path = cat_snap, _cat_snap;'
cat generated/types.sql

echo_cat generated/catalog.dmp

echo_cat build/functions.sql
echo_cat build/gather.sql
echo_cat build/delta.sql

# vi: expandtab ts=2 sw=2
