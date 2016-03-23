#!/bin/sh

cat << _EOF_
-- THIS IS A GENERATED FILE. DO NOT EDIT!
CREATE SCHEMA cat_snap;
SET search_path = cat_snap;

_EOF_

cat generated/entity.dmp
cat generated/types.sql
