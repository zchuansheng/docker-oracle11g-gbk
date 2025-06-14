-- rm -rf /u01/app/oracle/oradata/$DB_SID/*
shutdown immediate;
startup nomount;

CREATE DATABASE XE
   USER SYS IDENTIFIED BY oracle
   USER SYSTEM IDENTIFIED BY oracle
   LOGFILE GROUP 1 ('/u01/app/oracle/oradata/redo01.log') SIZE 50M,
           GROUP 2 ('/u01/app/oracle/oradata/redo02.log') SIZE 50M,
           GROUP 3 ('/u01/app/oracle/oradata/redo03.log') SIZE 50M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXDATAFILES 100
   MAXINSTANCES 1
   MAXLOGHISTORY 292
   CHARACTER SET ZHS16GBK
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE '/u01/app/oracle/oradata/system.dbf' SIZE 700M REUSE AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
   SYSAUX DATAFILE '/u01/app/oracle/oradata/sysaux.dbf' SIZE 550M REUSE AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
   DEFAULT TABLESPACE users
      DATAFILE '/u01/app/oracle/oradata/users.dbf'
      SIZE 500M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE temp
      TEMPFILE '/u01/app/oracle/oradata/temp.dbf'
      SIZE 20M REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
   UNDO TABLESPACE undotbs1
      DATAFILE '/u01/app/oracle/oradata/undotbs1.dbf'
      SIZE 200M REUSE AUTOEXTEND ON NEXT 5M MAXSIZE UNLIMITED;

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql


CREATE DATABASE XE
   USER SYS IDENTIFIED BY oracle
   USER SYSTEM IDENTIFIED BY oracle
   LOGFILE GROUP 1 ('/u01/app/oracle/oradata/XE/redo01.log') SIZE 50M,
           GROUP 2 ('/u01/app/oracle/oradata/XE/redo02.log') SIZE 50M,
           GROUP 3 ('/u01/app/oracle/oradata/XE/redo03.log') SIZE 50M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXDATAFILES 100
   MAXINSTANCES 1
   CHARACTER SET ZHS16GBK
   NATIONAL CHARACTER SET AL16UTF16
   DATAFILE '/u01/app/oracle/oradata/XE/system.dbf' SIZE 700M REUSE
   SYSAUX DATAFILE '/u01/app/oracle/oradata/XE/sysaux.dbf' SIZE 550M REUSE
   DEFAULT TEMPORARY TABLESPACE temp
       TEMPFILE '/u01/app/oracle/oradata/XE/temp.dbf'
       SIZE 20M REUSE
   UNDO TABLESPACE "UNDOTBS1"
       DATAFILE '/u01/app/oracle/oradata/XE/undotbs.dbf'
       SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
       