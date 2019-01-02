# cloudbreak-recipes

<b>install-druid-metadb-postgres</b><br>
Installs postgres db for druid.  Generally used during pre ambari install

<b>get-airline-data</b><br>
Fetches approx 113 million airline data records and stores in hive table. Post ambari install script.


<b>Setup NiFi user on HDP for Hive Streaming/b><br>
Scripts sets up nifi user, creates appropriates directories in hdfs, and sets ACL for hive warehouse directory.  This this the nifi user will fail to stream data into hive.  this is for unsecured poc cluster.
