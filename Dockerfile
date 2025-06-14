FROM wnameless/oracle-xe-11g-r2:latest
USER root
# 拷贝自定义初始化脚本
COPY scripts/rebuild_gbk_db.sh /opt/rebuild_gbk_db.sh
RUN chmod +x /opt/rebuild_gbk_db.sh
USER oracle
RUN /opt/rebuild_gbk_db.sh



  
#docker build -t oracle11g-gbk .
  