# convenience function to log into nodes. 
# This saves me from having to go to the AWS console and copy the public hostnames
# when I want to poke around on these machines

ssh_kafka () {
  # takes a string and an integer
  # $1: passing broker will log you into one of the brokers
  #     passing zoo will log you into one of the zookeeper nodes
  #     passing worker will log into ... one of the worker nodes
  # $2: passing n will log you into the n'th node. Node nums start at 0
  
  # This function assumes you have your public key on all of the nodes already
  # It's also heavily dependent on which node type you use. The AWS CLI returns different 
  # payload types for different node types. 
  
  ip=`aws ec2 describe-instances | \
    jq "[.Reservations[].Instances[] | select( .Tags[].Value | contains(\"${1}\")) | .NetworkInterfaces[].Association.PublicIp][${2}]" | \
    sed s/\"//g`
  ssh ubuntu@$ip
}

# run the command and ssh into the box
ssh_kafka $1 $2