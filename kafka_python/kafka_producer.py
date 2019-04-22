# I can publish messages this way from the kafka nodes themselves, but I cannot 
# do it from my local machine. I don't know why
# I can do it from another worker machine on this VPC. I think it's because of a networking issue
from lib.node_discovery import NodeDiscovery
from lib.node_configuration import *
from kafka import KafkaProducer
import json
from time import sleep

topic = 'TutorialTopic'

class MyKafkaProducer():
  def __init__(self, brokers, configuration = {}):
    self.broker_address = brokers
    self.config = configuration
  
  def set_up_producer(self):
    self.producer = KafkaProducer(
      bootstrap_servers=self.broker_address,
      value_serializer=lambda v: json.dumps(v).encode('utf-8'),
      acks=0,
      **self.config
    )

  def send(self, topic, messages, sleep_time = 0):
    for i in range(messages):
      self.producer.send(topic, {'foo': 'bar', 'num': i})
      sleep(sleep_time)

  def write(self, topic, message):
    self.producer.send(topic, message)
    
message = {
  'am_id':1,
  'attributes':{'skills':['python','java']}
}

nd = NodeDiscovery()
nd.find_nodes()
brokers = [v['private_ip']+ ':9092' for k,v in nd.node_data.items() if 'kafka' in k]
mkp = MyKafkaProducer(brokers)
mkp.set_up_producer()
mkp.write('attributes_2', message)


# echo "Hello, World" | ~/kafka/bin/kafka-console-producer.sh --broker-list 172.31.2.162:9092 --topic TutorialTopic > /dev/null
# ~/kafka/bin/kafka-console-consumer.sh --bootstrap-server 172.31.2.162:9092 --topic TutorialTopic --from-beginning