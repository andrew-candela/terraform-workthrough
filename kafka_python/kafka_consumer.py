from kafka import KafkaConsumer

topic = 'TutorialTopic'
private_broker_address = '172.31.2.162:9092'
broker_address = '54.183.102.190:9092'
client_id = 1

consumer = KafkaConsumer(topic, bootstrap_servers=private_broker_address,)
for msg in consumer:
  print (msg)