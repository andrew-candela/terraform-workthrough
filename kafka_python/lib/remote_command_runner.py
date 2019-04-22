import paramiko
from scp import SCPClient
import os
from io import StringIO

class RemoteCommandRunner():
  def __init__(self, remote_ip, username = 'ubuntu'):
    self.username = username
    self.ssh_key_file = os.getenv('KAFKA_SSH_KEY_FILE')
    self.client = paramiko.SSHClient()
    self.client.set_missing_host_key_policy(paramiko.WarningPolicy)
    self.client.connect(remote_ip, key_filename = self.ssh_key_file, username = self.username)
    self.scp_client = SCPClient(self.client.get_transport())

  def file_copier(self, input_file, output_file):
    # local_file = StringIO(input_string)
    return self.scp_client.put(input_file, output_file)


  def run_remote_command(self, remote_command):
    """paramiko returns a triple stdin, stdout, stderr after running commands
    I will return this in a dictionary for ease of retrieval"""
    stdin, stdout, stderr = self.client.exec_command(remote_command)
    # print(">>>> \tremote_command: {}\n>>>> \tstdout: {}\n>>>> \tstderr:{}\n".format(remote_command, stdout, stderr))
    return {'stdin':stdin, 'stdout': stdout, 'stderr':stderr}


# example usage ####################################################################
# rcr = RemoteCommandRunner(some_ip)
# stdin, stdout, stderr = rcr.run_remote_command('touch some file')
####################################################################################