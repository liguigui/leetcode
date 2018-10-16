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


# ȫ����ȡ�ͻ���
sqoop import --connect jdbc:mysql://172.16.1.127:3306/source --username dwtest --password 123456 --table customer --target-dir /data/ext/customer --delete-target-dir --compress


# ȫ����ȡ��Ʒ��

sqoop import --connect jdbc:mysql://172.16.1.127:3306/source --username dwtest --password 123456 --table product --target
-dir /data/ext/product --delete-target-dir --compress


#�״�ȫ����ȡ���۶�����
sqoop job --exec myjob_incremental_import
====================================================
#scp --help �鿴��������
hadoop fs -ls /
�ȼ���
hdfs dfs -ls /
-----------hive�ļ�������Load����--------------------
 hive> LOAD DATA LOCAL INPATH './examples/files/kv2.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2008-08-15');
-----------hive��mysql������sqoop����--------------------
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
HAWQ���ݵ��뵼��
#����
set search_path=tmp;
#Ĭ����׷�ӷ�ʽ����
COPY test_imp_exp_CDR_VOLTE_PREPAID  from '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816.csv' WITH CSV  HEADER;

#����
COPY (select * from.test_imp_exp_CDR_VOLTE_PREPAID) to '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816_tmp.csv' with csv header; 

#shell��ִ��pg sql
psql -h ��ַ -p �˿� -U �û� --command CREATE DATABASE test

#��������
psql -h ��ַ -p �˿� -U �û�  -f ./test_imp_exp.sql

#test_imp_exp.sql
COPY tmp.test_imp_exp_CDR_VOLTE_PREPAID  from '/home/gpadmin/maxico_am/CDR_VOLTE_PREPAID_20180816.csv' WITH CSV  HEADER;

###############�ҵ����в���
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