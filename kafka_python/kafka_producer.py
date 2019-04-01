# I can publish messages this way from the kafka nodes themselves, but I cannot 
# do it from my local machine. I don't know why
# I can do it from another worker machine on this VPC. I think it's because of a networking issue
from kafka import KafkaProducer
import json
from time import sleep


# topic = 'TutorialTopic'
# broker_address = '172.31.4.252:9092'
# broker_address = '54.183.102.190:9092'

class MyKafkaProducer():
  def __init__(self, broker_address, configuration = {}):
    self.broker_address = broker_address
    self.config = configuration
  
  def set_up_producer(self):
    self.producer = KafkaProducer(
      bootstrap_servers=self.broker_address,
      value_serializer=lambda v: json.dumps(v).encode('utf-8'),
      acks=0,
      **self.config
    )

  def send(self, topic, messages, sleep_time):
    for i in range(messages):
      self.producer.send(topic, {'foo': 'bar', 'num': i})
      sleep(sleep_time)



# echo "Hello, World" | ~/kafka/bin/kafka-console-producer.sh --broker-list 172.31.2.162:9092 --topic TutorialTopic > /dev/null
# ~/kafka/bin/kafka-console-consumer.sh --bootstrap-server 172.31.2.162:9092 --topic TutorialTopic --from-beginning