-- THIS IS A GENERATED FILE. DO NOT EDIT!

CREATE TYPE raw_aggregate AS (xmin xid, aggfnoid regproc, aggkind "char", aggnumdirectargs smallint, aggtransfn regproc, aggfinalfn regproc, aggcombinefn regproc, aggmtransfn regproc, aggminvtransfn regproc, aggmfinalfn regproc, aggfinalextra boolean, aggmfinalextra boolean, aggsortop oid, aggtranstype oid, aggtransspace integer, aggmtranstype oid, aggmtransspace integer, agginitval text, aggminitval text);
CREATE TYPE raw_am AS (xmin xid, oid oid, amname text, amhandler regproc, amtype "char");
CREATE TYPE raw_amop AS (xmin xid, oid oid, amopfamily oid, amoplefttype oid, amoprighttype oid, amopstrategy smallint, amoppurpose "char", amopopr oid, amopmethod oid, amopsortfamily oid);
CREATE TYPE raw_amproc AS (xmin xid, oid oid, amprocfamily oid, amproclefttype oid, amprocrighttype oid, amprocnum smallint, amproc regproc);
CREATE TYPE raw_attrdef AS (xmin xid, oid oid, adrelid oid, adnum smallint, adbin pg_node_tree, adsrc text);
CREATE TYPE raw_attribute AS (xmin xid, attrelid oid, attname text, atttypid oid, attstattarget integer, attlen smallint, attnum smallint, attndims integer, attcacheoff integer, atttypmod integer, attbyval boolean, attstorage "char", attalign "char", attnotnull boolean, atthasdef boolean, attisdropped boolean, attislocal boolean, attinhcount integer, attcollation oid, attacl aclitem[], attoptions text[], attfdwoptions text[]);
CREATE TYPE raw_auth_members AS (xmin xid, roleid oid, member oid, grantor oid, admin_option boolean);
CREATE TYPE raw_available_extension_versions AS (name text, version text, installed boolean, superuser boolean, relocatable boolean, schema text, requires name[], comment text);
CREATE TYPE raw_available_extensions AS (name text, default_version text, installed_version text, comment text);
CREATE TYPE raw_cast AS (xmin xid, oid oid, castsource oid, casttarget oid, castfunc oid, castcontext "char", castmethod "char");
CREATE TYPE raw_class AS (xmin xid, oid oid, relname text, relnamespace oid, reltype oid, reloftype oid, relowner oid, relam oid, relfilenode oid, reltablespace oid, relpages integer, reltuples real, relallvisible integer, reltoastrelid oid, relhasindex boolean, relisshared boolean, relpersistence "char", relkind "char", relnatts smallint, relchecks smallint, relhasoids boolean, relhaspkey boolean, relhasrules boolean, relhastriggers boolean, relhassubclass boolean, relrowsecurity boolean, relforcerowsecurity boolean, relispopulated boolean, relreplident "char", relfrozenxid xid, relminmxid xid, relacl aclitem[], reloptions text[]);
CREATE TYPE raw_collation AS (xmin xid, oid oid, collname text, collnamespace oid, collowner oid, collencoding integer, collcollate text, collctype text);
CREATE TYPE raw_config AS (name text, setting text);
CREATE TYPE raw_constraint AS (xmin xid, oid oid, conname text, connamespace oid, contype "char", condeferrable boolean, condeferred boolean, convalidated boolean, conrelid oid, contypid oid, conindid oid, confrelid oid, confupdtype "char", confdeltype "char", confmatchtype "char", conislocal boolean, coninhcount integer, connoinherit boolean, conkey smallint[], confkey smallint[], conpfeqop oid[], conppeqop oid[], conffeqop oid[], conexclop oid[], conbin pg_node_tree, consrc text);
CREATE TYPE raw_conversion AS (xmin xid, oid oid, conname text, connamespace oid, conowner oid, conforencoding integer, contoencoding integer, conproc regproc, condefault boolean);
CREATE TYPE raw_cursors AS (name text, statement text, is_holdable boolean, is_binary boolean, is_scrollable boolean, creation_time timestamp with time zone);
CREATE TYPE raw_database AS (xmin xid, oid oid, datname text, datdba oid, encoding integer, datcollate text, datctype text, datistemplate boolean, datallowconn boolean, datconnlimit integer, datlastsysoid oid, datfrozenxid xid, datminmxid xid, dattablespace oid, datacl aclitem[]);
CREATE TYPE raw_db_role_setting AS (xmin xid, setdatabase oid, setrole oid, setconfig text[]);
CREATE TYPE raw_default_acl AS (xmin xid, oid oid, defaclrole oid, defaclnamespace oid, defaclobjtype "char", defaclacl aclitem[]);
CREATE TYPE raw_depend AS (xmin xid, classid oid, objid oid, objsubid integer, refclassid oid, refobjid oid, refobjsubid integer, deptype "char");
CREATE TYPE raw_description AS (xmin xid, objoid oid, classoid oid, objsubid integer, description text);
CREATE TYPE raw_enum AS (xmin xid, oid oid, enumtypid oid, enumsortorder real, enumlabel text);
CREATE TYPE raw_event_trigger AS (xmin xid, oid oid, evtname text, evtevent text, evtowner oid, evtfoid oid, evtenabled "char", evttags text[]);
CREATE TYPE raw_extension AS (xmin xid, oid oid, extname text, extowner oid, extnamespace oid, extrelocatable boolean, extversion text, extconfig oid[], extcondition text[]);
CREATE TYPE raw_file_settings AS (sourcefile text, sourceline integer, seqno integer, name text, setting text, applied boolean, error text);
CREATE TYPE raw_foreign_data_wrapper AS (xmin xid, oid oid, fdwname text, fdwowner oid, fdwhandler oid, fdwvalidator oid, fdwacl aclitem[], fdwoptions text[]);
CREATE TYPE raw_foreign_server AS (xmin xid, oid oid, srvname text, srvowner oid, srvfdw oid, srvtype text, srvversion text, srvacl aclitem[], srvoptions text[]);
CREATE TYPE raw_foreign_table AS (xmin xid, ftrelid oid, ftserver oid, ftoptions text[]);
CREATE TYPE raw_index AS (xmin xid, indexrelid oid, indrelid oid, indnatts smallint, indisunique boolean, indisprimary boolean, indisexclusion boolean, indimmediate boolean, indisclustered boolean, indisvalid boolean, indcheckxmin boolean, indisready boolean, indislive boolean, indisreplident boolean, indkey int2vector, indcollation oidvector, indclass oidvector, indoption int2vector, indexprs pg_node_tree, indpred pg_node_tree);
CREATE TYPE raw_inherits AS (xmin xid, inhrelid oid, inhparent oid, inhseqno integer);
CREATE TYPE raw_language AS (xmin xid, oid oid, lanname text, lanowner oid, lanispl boolean, lanpltrusted boolean, lanplcallfoid oid, laninline oid, lanvalidator oid, lanacl aclitem[]);
CREATE TYPE raw_largeobject AS (xmin xid, loid oid, pageno integer, data bytea);
CREATE TYPE raw_largeobject_metadata AS (xmin xid, oid oid, lomowner oid, lomacl aclitem[]);
CREATE TYPE raw_locks AS (locktype text, database oid, relation oid, page integer, tuple smallint, virtualxid text, transactionid xid, classid oid, objid oid, objsubid smallint, virtualtransaction text, pid integer, mode text, granted boolean, fastpath boolean);
CREATE TYPE raw_namespace AS (xmin xid, oid oid, nspname text, nspowner oid, nspacl aclitem[]);
CREATE TYPE raw_opclass AS (xmin xid, oid oid, opcmethod oid, opcname text, opcnamespace oid, opcowner oid, opcfamily oid, opcintype oid, opcdefault boolean, opckeytype oid);
CREATE TYPE raw_operator AS (xmin xid, oid oid, oprname text, oprnamespace oid, oprowner oid, oprkind "char", oprcanmerge boolean, oprcanhash boolean, oprleft oid, oprright oid, oprresult oid, oprcom oid, oprnegate oid, oprcode regproc, oprrest regproc, oprjoin regproc);
CREATE TYPE raw_opfamily AS (xmin xid, oid oid, opfmethod oid, opfname text, opfnamespace oid, opfowner oid);
CREATE TYPE raw_pltemplate AS (xmin xid, tmplname text, tmpltrusted boolean, tmpldbacreate boolean, tmplhandler text, tmplinline text, tmplvalidator text, tmpllibrary text, tmplacl aclitem[]);
CREATE TYPE raw_policy AS (xmin xid, oid oid, polname text, polrelid oid, polcmd "char", polroles oid[], polqual pg_node_tree, polwithcheck pg_node_tree);
CREATE TYPE raw_prepared_statements AS (name text, statement text, prepare_time timestamp with time zone, parameter_types regtype[], from_sql boolean);
CREATE TYPE raw_prepared_xacts AS (transaction xid, gid text, prepared timestamp with time zone, owner text, database text);
CREATE TYPE raw_proc AS (xmin xid, oid oid, proname text, pronamespace oid, proowner oid, prolang oid, procost real, prorows real, provariadic oid, protransform regproc, proisagg boolean, proiswindow boolean, prosecdef boolean, proleakproof boolean, proisstrict boolean, proretset boolean, provolatile "char", proparallel "char", pronargs smallint, pronargdefaults smallint, prorettype oid, proargtypes oidvector, proallargtypes oid[], proargmodes "char"[], proargnames text[], proargdefaults pg_node_tree, protrftypes oid[], prosrc text, probin text, proconfig text[], proacl aclitem[]);
CREATE TYPE raw_range AS (xmin xid, rngtypid oid, rngsubtype oid, rngcollation oid, rngsubopc oid, rngcanonical regproc, rngsubdiff regproc);
CREATE TYPE raw_replication_origin AS (xmin xid, roident oid, roname text);
CREATE TYPE raw_replication_origin_status AS (local_id oid, external_id text, remote_lsn pg_lsn, local_lsn pg_lsn);
CREATE TYPE raw_replication_slots AS (slot_name text, plugin text, slot_type text, datoid oid, database text, active boolean, active_pid integer, xmin xid, catalog_xmin xid, restart_lsn pg_lsn, confirmed_flush_lsn pg_lsn);
CREATE TYPE raw_rewrite AS (xmin xid, oid oid, rulename text, ev_class oid, ev_type "char", ev_enabled "char", is_instead boolean, ev_qual pg_node_tree, ev_action pg_node_tree);
CREATE TYPE raw_roles AS (rolname text, rolsuper boolean, rolinherit boolean, rolcreaterole boolean, rolcreatedb boolean, rolcanlogin boolean, rolreplication boolean, rolconnlimit integer, rolpassword text, rolvaliduntil timestamp with time zone, rolbypassrls boolean, rolconfig text[], oid oid);
CREATE TYPE raw_rules AS (schemaname text, tablename text, rulename text, definition text);
CREATE TYPE raw_seclabel AS (xmin xid, objoid oid, classoid oid, objsubid integer, provider text, label text);
CREATE TYPE raw_seclabels AS (objoid oid, classoid oid, objsubid integer, objtype text, objnamespace oid, objname text, provider text, label text);
CREATE TYPE raw_settings AS (name text, setting text, unit text, category text, short_desc text, extra_desc text, context text, vartype text, source text, min_val text, max_val text, enumvals text[], boot_val text, reset_val text, sourcefile text, sourceline integer, pending_restart boolean);
CREATE TYPE raw_shdepend AS (xmin xid, dbid oid, classid oid, objid oid, objsubid integer, refclassid oid, refobjid oid, deptype "char");
CREATE TYPE raw_shdescription AS (xmin xid, objoid oid, classoid oid, description text);
CREATE TYPE raw_shseclabel AS (xmin xid, objoid oid, classoid oid, provider text, label text);
CREATE TYPE raw_stat_activity AS (datid oid, datname text, pid integer, usesysid oid, usename text, application_name text, client_addr inet, client_hostname text, client_port integer, backend_start timestamp with time zone, xact_start timestamp with time zone, query_start timestamp with time zone, state_change timestamp with time zone, wait_event_type text, wait_event text, state text, backend_xid xid, backend_xmin xid, query text, waiting boolean);
CREATE TYPE raw_stat_all_indexes AS (relid oid, indexrelid oid, schemaname text, relname text, indexrelname text, idx_scan bigint, idx_tup_read bigint, idx_tup_fetch bigint);
CREATE TYPE raw_stat_all_tables AS (relid oid, schemaname text, relname text, seq_scan bigint, seq_tup_read bigint, idx_scan bigint, idx_tup_fetch bigint, n_tup_ins bigint, n_tup_upd bigint, n_tup_del bigint, n_tup_hot_upd bigint, n_live_tup bigint, n_dead_tup bigint, n_mod_since_analyze bigint, last_vacuum timestamp with time zone, last_autovacuum timestamp with time zone, last_analyze timestamp with time zone, last_autoanalyze timestamp with time zone, vacuum_count bigint, autovacuum_count bigint, analyze_count bigint, autoanalyze_count bigint);
CREATE TYPE raw_stat_archiver AS (archived_count bigint, last_archived_wal text, last_archived_time timestamp with time zone, failed_count bigint, last_failed_wal text, last_failed_time timestamp with time zone, stats_reset timestamp with time zone);
CREATE TYPE raw_stat_bgwriter AS (checkpoints_timed bigint, checkpoints_req bigint, checkpoint_write_time double precision, checkpoint_sync_time double precision, buffers_checkpoint bigint, buffers_clean bigint, maxwritten_clean bigint, buffers_backend bigint, buffers_backend_fsync bigint, buffers_alloc bigint, stats_reset timestamp with time zone);
CREATE TYPE raw_stat_database AS (datid oid, datname text, numbackends integer, xact_commit bigint, xact_rollback bigint, blks_read bigint, blks_hit bigint, tup_returned bigint, tup_fetched bigint, tup_inserted bigint, tup_updated bigint, tup_deleted bigint, conflicts bigint, temp_files bigint, temp_bytes bigint, deadlocks bigint, blk_read_time double precision, blk_write_time double precision, stats_reset timestamp with time zone);
CREATE TYPE raw_stat_database_conflicts AS (datid oid, datname text, confl_tablespace bigint, confl_lock bigint, confl_snapshot bigint, confl_bufferpin bigint, confl_deadlock bigint);
CREATE TYPE raw_stat_progress_vacuum AS (pid integer, datid oid, datname text, relid oid, phase text, heap_blks_total bigint, heap_blks_scanned bigint, heap_blks_vacuumed bigint, index_vacuum_count bigint, max_dead_tuples bigint, num_dead_tuples bigint);
CREATE TYPE raw_stat_replication AS (pid integer, usesysid oid, usename text, application_name text, client_addr inet, client_hostname text, client_port integer, backend_start timestamp with time zone, backend_xmin xid, state text, sent_location pg_lsn, write_location pg_lsn, flush_location pg_lsn, replay_location pg_lsn, sync_priority integer, sync_state text);
CREATE TYPE raw_stat_ssl AS (pid integer, ssl boolean, version text, cipher text, bits integer, compression boolean, clientdn text);
CREATE TYPE raw_stat_statements AS (userid oid, dbid oid, queryid bigint, query text, calls bigint, total_time double precision, min_time double precision, max_time double precision, mean_time double precision, stddev_time double precision, rows bigint, shared_blks_hit bigint, shared_blks_read bigint, shared_blks_dirtied bigint, shared_blks_written bigint, local_blks_hit bigint, local_blks_read bigint, local_blks_dirtied bigint, local_blks_written bigint, temp_blks_read bigint, temp_blks_written bigint, blk_read_time double precision, blk_write_time double precision);
CREATE TYPE raw_stat_user_functions AS (funcid oid, schemaname text, funcname text, calls bigint, total_time double precision, self_time double precision);
CREATE TYPE raw_stat_wal_receiver AS (pid integer, status text, receive_start_lsn pg_lsn, receive_start_tli integer, received_lsn pg_lsn, received_tli integer, last_msg_send_time timestamp with time zone, last_msg_receipt_time timestamp with time zone, latest_end_lsn pg_lsn, latest_end_time timestamp with time zone, slot_name text);
CREATE TYPE raw_statio_all_indexes AS (relid oid, indexrelid oid, schemaname text, relname text, indexrelname text, idx_blks_read bigint, idx_blks_hit bigint);
CREATE TYPE raw_statio_all_sequences AS (relid oid, schemaname text, relname text, blks_read bigint, blks_hit bigint);
CREATE TYPE raw_statio_all_tables AS (relid oid, schemaname text, relname text, heap_blks_read bigint, heap_blks_hit bigint, idx_blks_read bigint, idx_blks_hit bigint, toast_blks_read bigint, toast_blks_hit bigint, tidx_blks_read bigint, tidx_blks_hit bigint);
CREATE TYPE raw_tablespace AS (xmin xid, oid oid, spcname text, spcowner oid, spcacl aclitem[], spcoptions text[]);
CREATE TYPE raw_timezone_abbrevs AS (abbrev text, utc_offset interval, is_dst boolean);
CREATE TYPE raw_timezone_names AS (name text, abbrev text, utc_offset interval, is_dst boolean);
CREATE TYPE raw_transform AS (xmin xid, oid oid, trftype oid, trflang oid, trffromsql regproc, trftosql regproc);
CREATE TYPE raw_trigger AS (xmin xid, oid oid, tgrelid oid, tgname text, tgfoid oid, tgtype smallint, tgenabled "char", tgisinternal boolean, tgconstrrelid oid, tgconstrindid oid, tgconstraint oid, tgdeferrable boolean, tginitdeferred boolean, tgnargs smallint, tgattr int2vector, tgargs bytea, tgqual pg_node_tree);
CREATE TYPE raw_ts_config AS (xmin xid, oid oid, cfgname text, cfgnamespace oid, cfgowner oid, cfgparser oid);
CREATE TYPE raw_ts_config_map AS (xmin xid, mapcfg oid, maptokentype integer, mapseqno integer, mapdict oid);
CREATE TYPE raw_ts_dict AS (xmin xid, oid oid, dictname text, dictnamespace oid, dictowner oid, dicttemplate oid, dictinitoption text);
CREATE TYPE raw_ts_parser AS (xmin xid, oid oid, prsname text, prsnamespace oid, prsstart regproc, prstoken regproc, prsend regproc, prsheadline regproc, prslextype regproc);
CREATE TYPE raw_ts_template AS (xmin xid, oid oid, tmplname text, tmplnamespace oid, tmplinit regproc, tmpllexize regproc);
CREATE TYPE raw_type AS (xmin xid, oid oid, typname text, typnamespace oid, typowner oid, typlen smallint, typbyval boolean, typtype "char", typcategory "char", typispreferred boolean, typisdefined boolean, typdelim "char", typrelid oid, typelem oid, typarray oid, typinput regproc, typoutput regproc, typreceive regproc, typsend regproc, typmodin regproc, typmodout regproc, typanalyze regproc, typalign "char", typstorage "char", typnotnull boolean, typbasetype oid, typtypmod integer, typndims integer, typcollation oid, typdefaultbin pg_node_tree, typdefault text, typacl aclitem[]);
CREATE TYPE raw_user_mapping AS (xmin xid, oid oid, umuser oid, umserver oid, umoptions text[]);
CREATE TYPE delta_stat_all_indexes AS (relid oid, indexrelid oid, schemaname text, relname text, indexrelname text, idx_scan_d bigint, idx_tup_read_d bigint, idx_tup_fetch_d bigint);
CREATE TYPE delta_stat_all_tables AS (relid oid, schemaname text, relname text, seq_scan_d bigint, seq_tup_read_d bigint, idx_scan_d bigint, idx_tup_fetch_d bigint, n_tup_ins_d bigint, n_tup_upd_d bigint, n_tup_del_d bigint, n_tup_hot_upd_d bigint, n_live_tup_d bigint, n_dead_tup_d bigint, n_mod_since_analyze_d bigint, last_vacuum timestamp with time zone, last_autovacuum timestamp with time zone, last_analyze timestamp with time zone, last_autoanalyze timestamp with time zone, vacuum_count_d bigint, autovacuum_count_d bigint, analyze_count_d bigint, autoanalyze_count_d bigint, last_vacuum_d interval, last_autovacuum_d interval, last_analyze_d interval, last_autoanalyze_d interval);
CREATE TYPE delta_stat_archiver AS (archived_count_d bigint, last_archived_wal text, last_archived_time timestamp with time zone, failed_count_d bigint, last_failed_wal text, last_failed_time timestamp with time zone, stats_reset timestamp with time zone, last_archived_time_d interval, last_failed_time_d interval, stats_reset_d interval);
CREATE TYPE delta_stat_bgwriter AS (checkpoints_timed_d bigint, checkpoints_req_d bigint, checkpoint_write_time_d double precision, checkpoint_sync_time_d double precision, buffers_checkpoint_d bigint, buffers_clean_d bigint, maxwritten_clean_d bigint, buffers_backend_d bigint, buffers_backend_fsync_d bigint, buffers_alloc_d bigint, stats_reset timestamp with time zone, stats_reset_d interval);
CREATE TYPE delta_stat_database AS (datid oid, datname text, numbackends integer, xact_commit_d bigint, xact_rollback_d bigint, blks_read_d bigint, blks_hit_d bigint, tup_returned_d bigint, tup_fetched_d bigint, tup_inserted_d bigint, tup_updated_d bigint, tup_deleted_d bigint, conflicts_d bigint, temp_files_d bigint, temp_bytes_d bigint, deadlocks_d bigint, blk_read_time_d double precision, blk_write_time_d double precision, stats_reset timestamp with time zone, stats_reset_d interval);
CREATE TYPE delta_stat_database_conflicts AS (datid oid, datname text, confl_tablespace_d bigint, confl_lock_d bigint, confl_snapshot_d bigint, confl_bufferpin_d bigint, confl_deadlock_d bigint);
CREATE TYPE delta_stat_user_functions AS (funcid oid, schemaname text, funcname text, calls_d bigint, total_time_d double precision, self_time_d double precision);
CREATE TYPE delta_statio_all_indexes AS (relid oid, indexrelid oid, schemaname text, relname text, indexrelname text, idx_blks_read_d bigint, idx_blks_hit_d bigint);
CREATE TYPE delta_statio_all_sequences AS (relid oid, schemaname text, relname text, blks_read_d bigint, blks_hit_d bigint);
CREATE TYPE delta_statio_all_tables AS (relid oid, schemaname text, relname text, heap_blks_read_d bigint, heap_blks_hit_d bigint, idx_blks_read_d bigint, idx_blks_hit_d bigint, toast_blks_read_d bigint, toast_blks_hit_d bigint, tidx_blks_read_d bigint, tidx_blks_hit_d bigint);
CREATE TYPE snapshot_other_status AS (
    snapshot_version     int
    , transaction_start     timestamptz
    , clock_timestamp        timestamptz
    , pg_available_extension_versions raw_available_extension_versions[]
    , pg_available_extensions raw_available_extensions[]
    , pg_config raw_config[]
    , pg_cursors raw_cursors[]
    , pg_file_settings raw_file_settings[]
    , pg_locks raw_locks[]
    , pg_prepared_statements raw_prepared_statements[]
    , pg_prepared_xacts raw_prepared_xacts[]
    , pg_replication_origin_status raw_replication_origin_status[]
    , pg_replication_slots raw_replication_slots[]
    , pg_roles raw_roles[]
    , pg_rules raw_rules[]
    , pg_seclabels raw_seclabels[]
    , pg_settings raw_settings[]
    , pg_stat_activity raw_stat_activity[]
    , pg_stat_progress_vacuum raw_stat_progress_vacuum[]
    , pg_stat_replication raw_stat_replication[]
    , pg_stat_ssl raw_stat_ssl[]
    , pg_stat_statements raw_stat_statements[]
    , pg_stat_wal_receiver raw_stat_wal_receiver[]
    , pg_timezone_abbrevs raw_timezone_abbrevs[]
    , pg_timezone_names raw_timezone_names[]
);
CREATE TYPE snapshot_catalog AS (
    snapshot_version     int
    , transaction_start     timestamptz
    , clock_timestamp        timestamptz
    , pg_aggregate raw_aggregate[]
    , pg_am raw_am[]
    , pg_amop raw_amop[]
    , pg_amproc raw_amproc[]
    , pg_attrdef raw_attrdef[]
    , pg_attribute raw_attribute[]
    , pg_auth_members raw_auth_members[]
    , pg_cast raw_cast[]
    , pg_class raw_class[]
    , pg_collation raw_collation[]
    , pg_constraint raw_constraint[]
    , pg_conversion raw_conversion[]
    , pg_database raw_database[]
    , pg_db_role_setting raw_db_role_setting[]
    , pg_default_acl raw_default_acl[]
    , pg_depend raw_depend[]
    , pg_description raw_description[]
    , pg_enum raw_enum[]
    , pg_event_trigger raw_event_trigger[]
    , pg_extension raw_extension[]
    , pg_foreign_data_wrapper raw_foreign_data_wrapper[]
    , pg_foreign_server raw_foreign_server[]
    , pg_foreign_table raw_foreign_table[]
    , pg_index raw_index[]
    , pg_inherits raw_inherits[]
    , pg_language raw_language[]
    , pg_largeobject raw_largeobject[]
    , pg_largeobject_metadata raw_largeobject_metadata[]
    , pg_namespace raw_namespace[]
    , pg_opclass raw_opclass[]
    , pg_operator raw_operator[]
    , pg_opfamily raw_opfamily[]
    , pg_pltemplate raw_pltemplate[]
    , pg_policy raw_policy[]
    , pg_proc raw_proc[]
    , pg_range raw_range[]
    , pg_replication_origin raw_replication_origin[]
    , pg_rewrite raw_rewrite[]
    , pg_seclabel raw_seclabel[]
    , pg_shdepend raw_shdepend[]
    , pg_shdescription raw_shdescription[]
    , pg_shseclabel raw_shseclabel[]
    , pg_tablespace raw_tablespace[]
    , pg_transform raw_transform[]
    , pg_trigger raw_trigger[]
    , pg_ts_config raw_ts_config[]
    , pg_ts_config_map raw_ts_config_map[]
    , pg_ts_dict raw_ts_dict[]
    , pg_ts_parser raw_ts_parser[]
    , pg_ts_template raw_ts_template[]
    , pg_type raw_type[]
    , pg_user_mapping raw_user_mapping[]
);
CREATE TYPE snapshot_stats_file AS (
    snapshot_version     int
    , snapshot_timestamp     timestamptz
    , pg_stat_all_indexes raw_stat_all_indexes[]
    , pg_stat_all_tables raw_stat_all_tables[]
    , pg_stat_archiver raw_stat_archiver[]
    , pg_stat_bgwriter raw_stat_bgwriter[]
    , pg_stat_database raw_stat_database[]
    , pg_stat_database_conflicts raw_stat_database_conflicts[]
    , pg_stat_user_functions raw_stat_user_functions[]
    , pg_statio_all_indexes raw_statio_all_indexes[]
    , pg_statio_all_sequences raw_statio_all_sequences[]
    , pg_statio_all_tables raw_statio_all_tables[]
);
CREATE TYPE snapshot_all AS (
    snapshot_version     int
    , database_name         text
    , cluster_identifier    text
    , catalog               snapshot_catalog
    , stats_file            snapshot_stats_file
    , other_status          snapshot_other_status
);
