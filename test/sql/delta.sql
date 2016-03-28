\set ECHO none

\i test/pgxntool/setup.sql

SET search_path = tap, cat_snap;

\set a_t (1259,pg_catalog,pg_class,9340,2366327,11317,10088,550,41,5,40,325,0,35,,"2016-03-27 20:52:00-05",,,0,0,0,0)
\set bad_t (19,pg_catalog,pg_class,9340,2366327,11317,10088,550,41,5,40,325,0,35,,"2016-03-27 20:52:00-05",,,0,0,0,0)
\set b_t (1259,pg_catalog,pg_class,9341,2366329,11320,10092,555,47,12,48,334,10,46,,"2016-03-27 20:52:13.131313-05",,,014,015,016,17)
\set a :'a_t'::raw_stat_all_tables
\set bad :'bad_t'::raw_stat_all_tables
\set b :'b_t'::raw_stat_all_tables

SELECT plan(2);

SELECT is(
  cat_snap.delta( :b, :a )
  , '(1259,pg_catalog,pg_class,1,2,3,4,5,6,7,8,9,10,11,,"Sun Mar 27 18:52:13.131313 2016 PDT",,,14,15,16,17,,"@ 13.131313 secs",,)'::delta_stat_all_tables
  , 'Check delta results'
);

SELECT throws_ok(
  format( $$SELECT cat_snap.delta( %L::raw_stat_all_tables, %L::raw_stat_all_tables )$$, :'bad_t', :'a_t' )
  , 'relid must match'
  , 'Verify key equality check works'
);

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
