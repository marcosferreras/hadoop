#!/bin/bash
export PATH="$PATH:/usr/home/hadoop/bin"

echo "******************************************************"
echo "****           Compiling MVN Project              ****"
echo "******************************************************"
mvn compile
echo "******************************************************"
echo "****            Creating MVN Package              ****"
echo "******************************************************"
mvn package

echo "******************************************************"
echo "****            Creating input in HDFS            ****"
echo "******************************************************"
hadoop fs -rm -R /input
hadoop fs -mkdir /input

echo "******************************************************"
echo "****           Copy input data into HDFS          ****"
echo "******************************************************"
hadoop fs -copyFromLocal ./input/* /input

echo "******************************************************"
echo "****        Deleting output HDFS directory        ****"
echo "******************************************************"
hadoop fs -rm -R /output

echo "******************************************************"
echo "****          Running Hadoop in Cluster           ****"
echo "******************************************************"
hadoop jar hadoop-practice.jar -conf ./conf/hadoop-cluster.template.xml /input /output

echo "******************************************************"
echo "****     Execucion result of Hadoop in Cluster    ****"
echo "******************************************************"
hadoop fs -cat /output/*

