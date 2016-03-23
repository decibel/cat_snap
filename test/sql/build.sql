\set ECHO none

\i test/pgxntool/psql.sql

BEGIN;
\i sql/cat_snap.sql

\d cat_snap.entity
\d cat_snap.raw_type

\echo # TRANSACTION INTENTIONALLY LEFT OPEN!

-- vi: expandtab sw=2 ts=2
