from node_discovery import NodeDiscovery
from remote_command_runner import RemoteCommandRunner
from node_configuration import configure_kafka_node, configure_zookeeper_node

def configure_nodes():
  nd = NodeDiscovery()
  nd.find_nodes()
  for node, data in nd.node_data.items():
    if data['name_group'] == 'kafka':
      print("provisioning node: {}".format(node))
      resp = configure_kafka_node(data, nd.node_summary)
    elif data['name_group'] == 'zookeeper':
      print("provisioning node: {}".format(node))
      configure_zookeeper_node(data, nd.node_summary)

if __name__ == '__main__':
  configure_nodes()