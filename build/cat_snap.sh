#!/bin/sh

cat << _EOF_
-- THIS IS A GENERATED FILE. DO NOT EDIT!
CREATE SCHEMA cat_snap;
CREATE SCHEMA _cat_snap;
SET search_path = cat_snap, _cat_snap;

_EOF_

echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!'
cat generated/entity.dmp
echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!'
cat generated/types.sql
echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!'
cat build/delta.sql
