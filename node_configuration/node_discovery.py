import boto3

ZOOKEEPER_PORT = 2181
ZOOKEEPER_PEER_PORT = 2888
ZOOKEEPER_LEADER_PORT = 3888

def categorize_node(node_name):
  for name_group in ['zookeeper', 'kafka', 'worker']:
    if name_group in node_name:
      return name_group

def find_name_from_aws_dict(ec2_dict):
  for tag in ec2_dict['Tags']:
    if tag['Key'] == 'Name':
      return tag['Value']


class NodeDiscovery():
  def __init__(self):
    self.ec2 = boto3.client('ec2')
    
  @staticmethod
  def grab_node_details(ec2_dict):
    # print(ec2_dict)
    return {
      'private_ip': ec2_dict['PrivateIpAddress'],
      'public_ip': ec2_dict['PublicIpAddress'],
      'name_group': categorize_node(find_name_from_aws_dict(ec2_dict)),
    }
  
  def find_nodes(self):
    """returns a dictionary where a key is the node name
    {node_name: {private_ip:54.202.222.92, public_ip: 55.202.222.92}}"""
    nodes = self.ec2.describe_instances()
    self.node_counts = {'kafka':0, 'zookeeper':0, 'worker': 0}
    self.node_data = {}
    if 'Reservations' in nodes:
      for res in nodes['Reservations']:
        # print(res)
        for node in res['Instances']:
          if node['State']['Name'] != 'running':
            print('skipping node: {}'.format(node['InstanceId']))
            continue  
          node_dict = self.grab_node_details(node)
          name_grp = node_dict['name_group']
          if name_grp:
            self.node_counts[name_grp] += 1
            node_dict['node_number'] = self.node_counts[name_grp]
            self.node_data["{}_{}".format(name_grp,self.node_counts[name_grp])] = node_dict
    print("I've found data for {} nodes".format(len(self.node_data)))

    self.node_summary = {'zookeeper_nodes':[], 'broker_nodes':[]}
    for node_name, description in self.node_data.items():
      if 'kafka' in node_name:
        self.node_summary['broker_nodes'].append(description['private_ip'])
      elif 'zookeeper' in node_name:
        self.node_summary['zookeeper_nodes'].append(description['private_ip'])
    
    zk_servers = [ "server.{}={}:{}:{}".format(
      zk['node_number'],zk['private_ip'],ZOOKEEPER_PEER_PORT,ZOOKEEPER_LEADER_PORT
    ) 
    for zk in self.node_data.values() 
    if zk['name_group'] == 'zookeeper' 
    ]
    self.node_summary['zookeeper_node_list'] = zk_servers