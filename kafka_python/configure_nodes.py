from lib.node_discovery import NodeDiscovery
from lib.node_configuration import *

def configure_nodes():
  nd = NodeDiscovery()
  nd.find_nodes()
  # have to configure zookeeper first then kafka
  for node, data in nd.node_data.items():
    if data['name_group'] == 'zookeeper':
      print("provisioning node: {}".format(node))
      configure_zookeeper_node(data, nd.node_summary)
  for node, data in nd.node_data.items():
    if data['name_group'] == 'kafka':
      print("provisioning node: {}".format(node))
      resp = configure_kafka_node(data, nd.node_summary)

if __name__ == '__main__':
  configure_nodes()
