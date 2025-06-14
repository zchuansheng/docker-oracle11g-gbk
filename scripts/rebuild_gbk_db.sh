#!/bin/bash

# 切换到 oracle 环境
export ORACLE_SID=XE
source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

echo "➡️ Step 1: 停止原数据库..."
sqlplus -S / as sysdba <<EOF
shutdown immediate;
exit;
EOF

echo "➡️ Step 2: 清空原数据文件..."
rm -rf /u01/app/oracle/oradata/${ORACLE_SID}/*
SQL_SCRIPT_PATH="$HOME/create_gbk_db.sql"

echo "➡️ Step 3: 生成 GBK 建库 SQL..."
cat >  "$SQL_SCRIPT_PATH" <<'EOSQL'
startup nomount;
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
   DATAFILE '/u01/app/oracle/oradata/XE/system.dbf' SIZE 700M REUSE AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
   SYSAUX DATAFILE '/u01/app/oracle/oradata/XE/sysaux.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE temp
       TEMPFILE '/u01/app/oracle/oradata/XE/temp.dbf'
       SIZE 20M REUSE AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED
   UNDO TABLESPACE "UNDOTBS1"
       DATAFILE '/u01/app/oracle/oradata/XE/undotbs.dbf'
       SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
EOSQL
echo "➡️ Step 4: 执行建库脚本..."
sqlplus -S / as sysdba <<EOF
@${SQL_SCRIPT_PATH}
ALTER DATABASE OPEN;
exit;
EOF
echo "➡️ Step 5: 初始化数据字典（catalog.sql + catproc.sql）..."
sqlplus -S / as sysdba <<EOF
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
exit;
EOF
echo "➡️ Step 6: 重启数据库..."
sqlplus -S / as sysdba <<EOF
shutdown immediate;
startup;
exit;
EOF

echo "✅ ✅ ✅ GBK 编码数据库初始化完成（以 oracle 用户执行）"