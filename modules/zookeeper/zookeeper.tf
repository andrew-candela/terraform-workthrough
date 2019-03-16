resource "aws_instance" "zookeeper_node" {
  associate_public_ip_address = true
  count                       = "${var.node_count}"
  instance_type               = "${var.instance_type}"

  root_block_device {
    volume_size = "${var.zookeeper_node_root_volume_size}"
  }

  ami      = "${var.zookeeper_ami}"
  key_name = "admin"

  # subnet_id              = "${element(var.kafka_subnet_ids, count.index)}"
  # iam_instance_profile   = "${aws_iam_instance_profile.kafka_profile.id}"
  # vpc_security_group_ids = ["${var.security_group}"]

  tags {
    # Name = "${var.env}-zookeeper_node-${self.id}"
    Name = "${var.env}-zookeeper_node"
    Type = "Kafka_testing"
  }
  vpc_security_group_ids = ["sg-561f3531"]

  # might wanna use this in the future
  # lifecycle {
  #   ignore_changes = [ "ami" ]
  # }
  # provisioner "local-exec" {
  #   command = "apt-get update"
  # }

  # provisioner "local-exec" {
  #   command = "sudo apt-get --assume-yes install default-jre"
  # }
  # provisioner "local-exec" {
  #   command = "sudo apt-get update && sudo apt-get --assume-yes install default-jre"
  # }
  # provisioner "local-exec" {
  #   command = "sudo mkdir -p /data/zookeeper"
  # }
  # provisioner "local-exec" {
  #   command = "cd /opt && sudo wget http://apache.claz.org/zookeeper/stable/zookeeper-3.4.12.tar.gz && sudo tar -xvf zookeeper-3.4.12.tar.gz"
  # }
  # provisioner "file" {
  #   source      = "zookeeper_configs.cfg"
  #   destination = "/opt/zookeeper-3.4.12/conf/zoo.cfg"
  # }
}
