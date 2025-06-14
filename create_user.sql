-- create user for testing
CREATE USER hmfmsfdtest IDENTIFIED BY hmfmsfdtest;
grant connect, resource, dba to hmfmsfdtest;
grant create session, alter any procedure to hmfmsfdtest;

-- to enable xa recovery, see: https://community.oracle.com/thread/378954
grant select on sys.dba_pending_transactions to hmfmsfdtest;

grant select on sys.pending_trans$ to hmfmsfdtest;
grant select on sys.dba_2pc_pending to hmfmsfdtest;
grant execute on sys.dbms_system to hmfmsfdtest;

-- http://www.dba-oracle.com/t_ora_01950_no+priviledges_on_tablespace_string.htm
GRANT UNLIMITED TABLESPACE TO hmfmsfdtest;