from lib.node_discovery import NodeDiscovery
from lib.node_configuration import *

def configure_nodes():
  nd = NodeDiscovery()
  nd.find_nodes()

  topic = 'attributes_2'
  PRIVATE_BROKER_ADDRESSES = nd.
# PUBLIC_BROKER_ADDRESS = '54.183.102.190:9092'
# client_id = 1

class MyKafkaConsumer():
  def __init__(self, broker_address, configuration = {}):
    self.broker_address = broker_address
    self.config = configuration
  
  def set_up_consumer(self, topic):
    self.consumer = KafkaConsumer(
      topic, 
      bootstrap_servers=self.broker_address, 
      **self.config
    )
  
  def listen(self):
    for msg in self.consumer:
      print(msg)

  def consume_messages(self, msg_count):
    i = 0
    msgs = []
    for msg in self.consumer:
      if i > msg_count:
        break
      msgs.append(msg)
      i+=1
    return msgs

  def count_messages(self):
    i=0
    for msg in self.consumer:
      i+=1
      print(i)


# def listener():
#   nd = NodeDiscovery()
#   nd.find_nodes()
#   cons = MyKafkaConsumer()
# if __name__ == '__main__':
