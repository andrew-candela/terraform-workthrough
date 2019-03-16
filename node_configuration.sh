# this script installs zookeeper on an ubuntu node
# see https://medium.com/@ryannel/installing-zookeeper-on-ubuntu-9f1f70f22e25
# 

# see https://www.howtoforge.com/tutorial/ubuntu-apache-kafka-installation/
# for steps to install java and Kafka on an ubuntu 18.04 node.

# update apt-get
sudo apt-get update
# install java 
sudo apt-get --assume-yes install default-jre
# create data dirs
sudo mkdir -p /data/zookeeper
# download zookeeper
cd /opt
sudo wget http://apache.claz.org/zookeeper/stable/zookeeper-3.4.12.tar.gz
sudo tar -xvf zookeeper-3.4.12.tar.gz
# configure zookeeper # copy the contents of this file with the 
# file provisioner in TF
bash -c "cat > /opt/zookeeper-3.4.12/conf/zoo.cfg <<EOL
tickTime=2000
dataDir=/data/zookeeper
clientPort=2181
initLimit=5
syncLimit=2
server.1=master:2888:3888
server.2=slave1:2888:3888
server.3=slave2:2888:3888
EOL"


# add this to the /etc/hosts file
# replace with whatever the IPS are of the other machines in the ensamble
192.168.1.102 node1
192.168.1.103 node2
192.168.1.105 node3


# start the kafka service (run this as root)
systemctl start kafka
systemctl enable kafka

# Kafka is installed in /opt/kafka/
# have to update the config /opt/kafka/config/server.properties
# to have unique broker ID and point to the correct zookeeper IP and port
# change zookeeper.connect=<yourhost>:<yourport>

# another reference is https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-ubuntu-18-04

# Zookeeper might be installed in /opt/zookeeper-*
# need to 
