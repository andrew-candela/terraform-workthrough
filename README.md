# Terraform-Workthrough
This repo is a backup of a personal project using terraform to set manage some AWS infrastructure.

I'd like to set up a kafka cluster and the supporting things. Eventually I might even have elasticsearch and postgres and a fake application.

# Node Configuration Notes
#### Update apt-get  
Don't forget to run `sudo apt-get update` on the Amazon AMIs!

## Configuring Kafka
These [digital ocean directions](https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-ubuntu-18-04) are the best I've found. [These directions](https://www.howtoforge.com/tutorial/ubuntu-apache-kafka-installation/) from howtoforge are OK.

I used this [berkeley kafka binary mirror](http://mirrors.ocf.berkeley.edu/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz) to download the kafka binary.

### Node configuration
Kafka is installed in the kafka users home directory `/home/kafka/kafka/`. I've created an AMI with the raw config files and 
Kafka binaries installed and unpacked. Terraform launches the node, but I have to configure it manually with Python (Paramiko) 
after it comes up. I have to update the config `/home/kafka/kafka/config/server.properties` file to have unique broker ID 
and point to the correct zookeeper IP and port (change `zookeeper.connect=<yourhost>:<yourport>`)

I have a python script copy the raw config files from this project, replace the variables with the private IPs and 
ports of the new Zookeeper and Kafka nodes brought up by TF, and then copy them to the nodes themselves.

## Configuring Zookeeper
See [this medium article](https://medium.com/@ryannel/installing-zookeeper-on-ubuntu-9f1f70f22e25) for a decent walkthrough of installing
Zookeeper on an ubuntu 18.04 machine.  
Zookeeper configuration is similar to Kafka node configuration. I've made an AMI with the base Zookeeper installation - it is installed in `/opt/zookeeper-*` and is owned by the ubuntu user (default user given by amazon AMIs).  
I have a python script that runs after the EC2 nodes are up that finds all of the public and private IPs of the Kafka and zookeeper nodes. Once it has those IPs, it can build the conf files for the zk nodes.

## Connect Configuration
Kafka Connect workers need to have whatever plugin Jars needed placed in the directories configured in `plugin.path` in the config file `connect-distributed.properties`. 

Connect notes:

    echo '{
      "name":"attribute_sink",
      "config":{
        "connector.class":"JdbcSinkConnector",
        "connection.url":"jdbc:postgresql://{hostname}:{port}/{database_name}?user={un}&password={pw}",
        "insert.mode":"insert",
        "table.name.format": "kafka_${topic}",
        "auto.create":true,
        "auto.evolve":true,
        "topics":"{topic_list}"
      }
    }' | curl -X POST -d @- $IP_OF_CONNECT_WORKER:8083/connectors --header "content-Type:application/json"
        "pk.mode":"record_value",
        "pk.fields":"am_id"
    curl -X DELETE $IP_OF_CONNECT_WORKER:8083/connectors/attribute_sink
    ~/kafka/bin/kafka-topics.sh --create --zookeeper $BROKER_IP:2181 --replication-factor 1 --partitions 1 --topic attributes
    curl -X PUT -d {$var} $IP_OF_CONNECT_WORKER:8083/connector-plugins/JdbcSinkConnector/config/validate --header "content-Type:application/json"
