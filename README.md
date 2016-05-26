# DSESpark_day2

## Predicate Pushdown

1) Create three 'sensor' tables. These tables have the same columns but slightly different primary key structures.

https://github.com/MurphyRP/DSESpark_day2/blob/master/createSensorTables.cql

2) Insert data into 'sensor_a'

https://github.com/MurphyRP/DSESpark_day2/blob/master/sensorData.cql

### Auditing DSE

3) On each node, edit each dse.yaml file 

Edit auditing section
dse.yaml
```
<installDir>/resources/dse/conf/dse.yaml
```
Enable auditing
```
# Audit logging options
audit_logging_options:
  enabled: true
```
and
```
  included_categories: QUERY
```
### Logging Executors in Spark

4) Review/Change Executor logging options. On each node, edit each logback-spark-executor.xml file
In the \<configuration\> section, add
```
<logger name="com.datastax.driver.core.RequestHandler" level="TRACE"/>
```
To
```
<installDir>/resources/spark/conf/logback-spark-executor.xml
```

5) Open the Spark Master UI
```
http://<master ip>:7080
```

6) Using our 'write to Cassandra approach from day 1, populate sensor_b and sensor_c

7) Using the Spark Master UI, Navigate to the Executor page and review the stdout

    A) What is logged?
    B) What is happening with each request to C*?
  
8) Review the audting log on each node for DSE.
```
/var/log/cassandra/audit/audit.log
```

    A) What CQL is logged?
    B) What if any predicates are being pushed down? (where clause)
  
9) Query by non-key columns, partition key columns and combinations of columns.

    A) What is in the log?
    B) What query is being run ON the node?
    C) Why?

### Ready for some QA? 


10) Open Spark-sql UI
```
sudo <installdir>/bin/dse spark-sql
```
11) Query by non-key columns, partition key columns and combinations of columns.

    A) What is in the log?
    B) What query is being run ON the node?
    C) Why?



## Spark Streaming

Prerequisites

Do the following on a load generation node, these instructions

are for ubuntu or debian based Linux. For CentOS or MacOS,

google the equivalents and keep the versions matched.

// Install Zookeeper

```
sudo apt-get install zookeeperd
```

// Test Zookeeper

```
telnet localhost 2181 //Type ruok in telnet, should say imok
```

// Download Kafka 0.9.0.1 for Scala 2.10

```
"http://mirror.reverse.net/pub/apache/kafka/0.9.0.1/kafka_2.10-0.9.0.1.tgz" -O kafka.tgz
```


// Make Kafka dir and cd to it
```
mkdir ­p ~/kafka && cd ~/kafka
```

```
tar ­xvzf ../kafka.tgz ­­strip 1
```

// Edit properties

```
vi ~/kafka/config/server.properties
```

// Add the following to the end of the file
```
delete.topic.enable = true
```
// Start Kafka
```
nohup ~/kafka/bin/kafka-server-start.sh ~/kafka/config/server.properties > ~/kafka/kafka.log 2>&1 &

```

// Install newest SBT
```
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
```

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
```

```
sudo apt-get update
```
```
sudo apt-get install sbt
```
//Install scala 2.10.6
```
sudo apt-get remove scala-library scala

wget http://www.scala-lang.org/files/archive/scala-2.10.6.deb

sudo dpkg -i scala-2.10.6.deb

sudo apt-get update

sudo apt-get install scala
```
//Install git

```
sudo apt-get install git
```
