#!/bin/bash
#https://blog.csdn.net/wzy0623/article/details/71711430

sqoop job --delete myjob_incremental_import
sqoop job --create myjob__incremental_import \
--import \
--connect "jdbc:mysql://172.16.1.127:3306/source?usess1=false&user=dwtest&password=123456" \
--table sales_order \
--target-dir /data/ext/sales_order \
--compress \
--where "entry_date < current_date()" \
--incrementtal append \
--check-column order_number \
--last-value 0


# 全量抽取客户表
sqoop import --connect jdbc:mysql://172.16.1.127:3306/source --username dwtest --password 123456 --table customer --target-dir /data/ext/customer --delete-target-dir --compress


# 全量抽取产品表

sqoop import --connect jdbc:mysql://172.16.1.127:3306/source --username dwtest --password 123456 --table product --target
-dir /data/ext/product --delete-target-dir --compress


#首次全量抽取销售订单表
sqoop job --exec myjob_incremental_import
====================================================
#scp --help 查看帮助命令
hadoop fs -ls /
等价于
hdfs dfs -ls /
-----------hive文件导入用Load命令--------------------
 hive> LOAD DATA LOCAL INPATH './examples/files/kv2.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2008-08-15');
-----------hive从mysql导入用sqoop命令--------------------
sqoop import 
--connect jdbc:mysql://xxx:3306/db 
--username user 
--password pwd 
--table tablename 
--hive-import 
--hive-table tablename -m 1
--------------------- 
 $ $HADOOP_HOME/bin/hadoop fs -mkdir       /tmp
  $ $HADOOP_HOME/bin/hadoop fs -mkdir       /user/hive/warehouse
  $ $HADOOP_HOME/bin/hadoop fs -chmod g+w   /tmp
  $ $HADOOP_HOME/bin/hadoop fs -chmod g+w   /user/hive/warehouse
-----------hawq-------------------
HAWQ数据导入导出
#导入
set search_path=tmp;
#默认是追加方式导入
COPY test_imp_exp_CDR_VOLTE_PREPAID  from '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816.csv' WITH CSV  HEADER;

#导出
COPY (select * from.test_imp_exp_CDR_VOLTE_PREPAID) to '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816_tmp.csv' with csv header; 

#shell中执行pg sql
psql -h 地址 -p 端口 -U 用户 --command CREATE DATABASE test

#方法二：
psql -h 地址 -p 端口 -U 用户  -f ./test_imp_exp.sql

#test_imp_exp.sql
COPY tmp.test_imp_exp_CDR_VOLTE_PREPAID  from '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816.csv' WITH CSV  HEADER;

###############我的所有操作
COPY test_imp_exp_cdr_VOLTE_POSTPAID  from '/home/gpadmin/maxico_am/test_imp_exp_cdr_VOLTE_POSTPAID.csv' WITH CSV  HEADER;

COPY (select * from test_imp_exp_cdr_VOLTE_POSTPAID) to '/home/gpadmin/maxico_am/test_imp_exp_cdr_VOLTE_POSTPAID.csv' with csv header; 

#!/bash/bin
start_time=$(date +%s)

psql -d maxico_am  -f /home/gpadmin/maxico_am/test_imp_exp.sql

end_time=$(date +%s)
cost=$((end_time - start_time))
echo $cost

#test_imp_exp.sql
COPY tmp.test_imp_exp_cdr_VOLTE_POSTPAID  from '/home/gpadmin/maxico_am/test_imp_exp_cdr_VOLTE_POSTPAID.csv' WITH CSV  HEADER;