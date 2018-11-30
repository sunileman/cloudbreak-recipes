#/bin/bash

echo "------------------------------------"
echo "-----starting get airline data------"
echo "------------------------------------"
echo ""
echo ""
echo ""
echo "***********removing leftovers*********"
rm -f /home/hive/*csv*
hdfs dfs -rm -skipTrash /user/hive/airline/*

echo ""
echo ""
echo ""
echo"********get airline data from end points*****"
wget https://s3-us-west-2.amazonaws.com/sunileman1/scripts/files.list -P /home/hive/
cat /home/hive/files.list | parallel --will-cite --max-procs=16 --group 'wget -nv "{}" -P /home/hive/'

echo ""
echo ""
echo ""
echo "**********unziping files***************"
ls *bz2 | parallel --will-cite --max-procs=16 --group 'bzip2 -d "{}"'

echo ""
echo ""
echo ""
echo "*******removing first line from all files********"
ls *csv | parallel --will-cite --max-procs=16 --group 'sed -i ''1d'' "{}"'

echo ""
echo ""
echo ""
echo "*********removing all leftover bz2 files********"
rm -f /home/hive/*bz*

##put files in hdfs
echo ""
echo ""
echo ""
echo "*********putting files in hdfs**********"
hdfs dfs -mkdir /user/hive/airline/
hdfs dfs -put *.csv /user/hive/airline/


echo ""
echo ""
echo ""
echo "**********remove airline files from local directory*******"
rm -f /home/hive/*airline*csv*

echo ""
echo ""
echo ""
echo "******fetching hql scipt**************"
wget -nv https://s3-us-west-2.amazonaws.com/sunileman1/scripts/create-druid-table.hql -P /home/hive/

echo ""
echo ""
echo ""
echo "***********executing hive hql*********"
beeline -u "jdbc:hive2://localhost:10501/default;transportMode=http;httpPath=cliservice" -f /home/hive/create-druid-table.hql

echo "-------finished with fetching airline data-----"
