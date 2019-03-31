## format the kafka and zookeeper nodes
## this script will identify the public/private IP of the nodes
## and then will SSH into each node and edit the kafka and zookeeper config files
## this is a hack so that I don't need something like chef or ansible

from remote_command_runner import RemoteCommandRunner

KAFKA_SERVER_CONFIG_FILE = 'kafka_configs/server.properties'
ZOOKEEPER_SERVER_CONFIG_FILE = 'zookeeper_configs/zoo.cfg'
REMOTE_KAFKA_SERVER_CONFIG = '/home/kafka/kafka/config/server.properties'
REMOTE_ZOOKEEPER_CONFIG_FILE = '/opt/zookeeper-3.4.13/conf/zoo.cfg'
REMOTE_ZOOKEEPER_ID_FILE = '/data/zookeeper/myid'

def configure_kafka_node(node_details, node_summary):
  # read in the local config file and replace the variables with
  # the discovered values 

  replacements = [
    ('BROKER_ID_NUMBER',str(node_details['node_number'])),
    ('ZOOKEEPER_IP',','.join([node + ':2181' for node in node_summary['zookeeper_nodes']]))
  ]

  with open(KAFKA_SERVER_CONFIG_FILE, 'r') as server_config:
    config = server_config.read()

  for replacement in replacements:
    config = config.replace(replacement[0],replacement[1])
  # now execute the commands on the remote server
  rcr = RemoteCommandRunner(node_details['public_ip'])
  resp = rcr.run_remote_command("sudo echo -e '{config_contents}' > {config_file}".format(
    config_contents = config,
    config_file = REMOTE_KAFKA_SERVER_CONFIG
    )
  )
  resp = rcr.run_remote_command("sudo systemctl start kafka")

def configure_zookeeper_node(node_details, node_summary):
  # read in the local zookeeper config, replace vars and replace remote template
  # I also have to construct the server.i=ip:peer_port:leader_port

  zk_servers = node_summary['zookeeper_node_list']
  with open(ZOOKEEPER_SERVER_CONFIG_FILE, 'r') as server_config:
    config = server_config.read()
  # add the server list
  for serv in zk_servers:
    config = config + "\n" + serv
  remote_command = "echo -e '{config_contents}' > {config_file}".format(
    config_contents = config,
    config_file = REMOTE_ZOOKEEPER_CONFIG_FILE
    )
  # now execute the commands on the remote server
  rcr = RemoteCommandRunner(node_details['public_ip'])
  print("provisioning zookeeper node: {}".format(node_details['node_number']))
  resp = rcr.run_remote_command(remote_command)
  print(resp['stderr'].read().decode())
  resp = rcr.run_remote_command("echo {node_num} > {id_file}".format(
    node_num = node_details['node_number'],
    id_file = REMOTE_ZOOKEEPER_ID_FILE)
  )
  print(resp['stderr'].read().decode())
  START_ZK_COMMAND = """sudo service zookeeper stop; bash /opt/zookeeper-3.4.13/bin/zkServer.sh start"""
  resp = rcr.run_remote_command(START_ZK_COMMAND)
  print(resp['stderr'].read().decode())
