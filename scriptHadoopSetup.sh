#!/bin/bash

#INSTALACION DE JAVA 8
#sudo apt-get update
#sudo apt-get upgrade
#sudo apt install openjdk-8-jdk-headless
#javac -version

#RUTA DE JAVA PARA LA VARIABLE DE ENTORNO QUE REQUIERE HADOOP
#path=$(readlink -f /usr/bin/java | sed "s:bin/java::")
#echo "La ruta en la que se ha instalado java es:" $path
#export JAVA_HOME=$path

#DESCARGA Y DESCOMPRESION DE HADOOP
#wget https://apache.brunneis.com/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
#tar -xzvf hadoop-3.2.1.tar.gz
#sudo mv hadoop-3.2.1 /usr/local/hadoop

#ESTABLECIMIENTO DE LA RUTA
#cd /usr/local/hadoop
#sudo echo PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/hadoop/bin:/usr/local/hadoop/sbin" | sudo tee -a /etc/environment
#sudo echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre" | sudo tee -a /etc/environment

#COMPROBACION PARA EJECUTAR MAPREDUCE JOBS EN EL CLUSTER DE HADOOP
#cd /usr/local/hadoop
#bin/hadoop jar


#CONFIGURACION DE SSH
#sudo apt-get install openssh-server
#sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
#sudo /etc/init.d/ssh restart

#CONFIGURACION DE LA CLAVE PUBLICA PARA SSH
#echo Pulsa ENTER en cada uno de los campos que se te mostraran a continuacion
#ssh-keygen -t rsa
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod og-wx ~/.ssh/authorized_keys 

#MODIFICACIONES NECESARIAS EN FICHEROS DE HADOOP
#cd /usr/local/hadoop

#FICHERO ./etc/hadoop/hadoop-env.sh
#oldVar=$(echo "# export JAVA_HOME=")
#path2=$(readlink -f /usr/bin/java | sed "s:bin/java::")
#path3=$(echo "export JAVA_HOME="$path2)
#sudo sed -i "s,$oldVar,$path3,g" /usr/local/hadoop/etc/hadoop/hadoop-env.sh

#sudo sed -i "s,# export HADOOP_HOME=,export HADOOP_HOME=/usr/local/hadoop/,g" /usr/local/hadoop/etc/hadoop/hadoop-env.sh

#FICHERO ./etc/hadoop/core-site.xml
#NOpatron=$(echo -e "</configuration>")
#NOnuevoPatron="\t<property>\n\t\t<name>fs.defaultFS</name>\n\t\t<value>hdfs://localhost:9000</value>\n\t</property>\n</configuration>"

#NOsudo sed -i "s,$patron,$nuevoPatron,g" /usr/local/hadoop/etc/hadoop/core-site.xml

#sudo grep -v "<configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/mapred-site.xml
#sudo grep -v "</configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/mapred-site.xml

#sudo echo -e "<configuration>\t<property>\n\t\t<name>fs.defaultFS</name>\n\t\t<value>hdfs://localhost:9000</value>\n\t</property>\n</configuration>"


#FICHERO ./mapred-site.xml
#NOpatron=$(echo  ">*</configuration>")
#NOnuevoPatron="\t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.app.mapreduce.am.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.map.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.reduce.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.application.classpath</name>\n\t\t<value>\$HADOOP_CONF_DIR,\$HADOOP_COMMON_HOME/share/hadoop/common/*,\$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,\$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,\$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,\$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,\$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,\$HADOOP_YARN_HOME/share/hadoop/yarn/*,\$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*</value>\n\t</property>\n</configuration>"

#NOnuevoPatron="\t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.app.mapreduce.am.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.map.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.reduce.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.application.classpath</name>\n\t\t<value>$HADOOP_CONF_DIR,$HADOOP_COMMON_HOME/share/hadoop/common/*,$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,$HADOOP_YARN_HOME/share/hadoop/yarn/*,$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*</value>\n\t</property>\n</configuration>"
#NOecho $nuevoPatron
#NOsudo sed -i "s,$patron,$nuevoPatron,g" /usr/local/hadoop/etc/hadoop/mapred-site.xml

#NOsudo sed -i 's,"</configuration>","\t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.app.mapreduce.am.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.map.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.reduce.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.application.classpath</name>\n\t\t<value>,/share/hadoop/common/*,/share/hadoop/common/lib/*,/share/hadoop/hdfs/*,/share/hadoop/hdfs/lib/*,/share/hadoop/mapreduce/*,/share/hadoop/mapreduce/lib/*,/share/hadoop/yarn/*,/share/hadoop/yarn/lib/*</value>\n\t</property>\n</configuration>",g' /usr/local/hadoop/etc/hadoop/mapred-site.xml

#NOsudo sed -i 's,</configuration>, \t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.app.mapreduce.am.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.map.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.reduce.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.application.classpath</name>\n\t\t<value>$HADOOP_CONF_DIR,$HADOOP_COMMON_HOME/share/hadoop/common/*,$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,$HADOOP_YARN_HOME/share/hadoop/yarn/*,$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*</value>\n\t</property>\n</configuration>, g' /usr/local/hadoop/etc/hadoop/mapred-site.xml

#NOsudo sed -i 's,"<configuration>",,' /usr/local/hadoop/etc/hadoop/mapred-site.xml
#NOsudo sed -i 's,"</configuration>",,' /usr/local/hadoop/etc/hadoop/mapred-site.xml


sudo grep -v "<configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/mapred-site.xml
sudo grep -v "</configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/mapred-site.xml
sudo printf "<configuration>\n\t<property>\n\t\t<name>mapreduce.framework.name</name>\n\t\t<value>yarn</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.app.mapreduce.am.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.map.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>mapreduce.reduce.env</name>\n\t\t<value>HADOOP_MAPRED_HOME=/usr/local/hadoop/</value>\n\t</property>\n\t<property>\n\t\t<name>yarn.application.classpath</name>\n\t\t<value>$HADOOP_CONF_DIR,$HADOOP_COMMON_HOME/share/hadoop/common/*,$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,$HADOOP_YARN_HOME/share/hadoop/yarn/*,$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*</value>\n\t</property>\n</configuration>" |sudo tee -a /usr/local/hadoop/etc/hadoop/mapred-site.xml


#FICHERO ./yarn-site.xml
sudo grep -v "<configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/yarn-site.xml
sudo grep -v "</configuration>" /usr/local/hadoop/etc/hadoop/mapred-site.xml > tmpfile && mv tmpfile /usr/local/hadoop/etc/hadoop/yarn-site.xml
sudo printf "<configuration>\t<property>\n\t\t<name>yarn.nodemanager.aux-services</name>\n\t\t<value>mapreduce_shuffle</value>\n\t</property>\n</configuration>" | sudo tee -a /usr/local/hadoop/etc/hadoop/yarn-site.xml

