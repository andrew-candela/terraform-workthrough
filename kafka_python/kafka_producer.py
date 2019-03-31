# I can publish messages this way from the kafka nodes themselves, but I cannot 
# do it from my local machine. I don't know why
# I can do it from another worker machine on this VPC. I think it's because of a networking issue


from kafka import KafkaProducer
import json

topic = 'TutorialTopic'
private_broker_address = '172.31.2.162:9092'
broker_address = '54.183.102.190:9092'
producer = KafkaProducer(
  bootstrap_servers=private_broker_address,
  value_serializer=lambda v: json.dumps(v).encode('utf-8'),
  acks='all'
)
for i in range(10):
  producer.send(topic, {'foo': 'bar', 'num': i})


echo "Hello, World" | ~/kafka/bin/kafka-console-producer.sh --broker-list 172.31.2.162:9092 --topic TutorialTopic > /dev/null

~/kafka/bin/kafka-console-consumer.sh --bootstrap-server 172.31.2.162:9092 --topic TutorialTopic --from-beginning