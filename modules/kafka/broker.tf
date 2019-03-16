resource "aws_instance" "broker" {
  associate_public_ip_address = true
  count                       = "${var.broker_count}"
  instance_type               = "${var.instance_type}"

  root_block_device {
    volume_size = "${var.broker_root_volume_size}"
  }

  ami      = "${var.broker_ami}"
  key_name = "admin"

  tags {
    Name = "${var.env}-kafka_broker"
    Type = "Kafka_testing"
  }

  # provisioner "local-exec" {
  #   command = "echo hello > /my_ips.txt"
  # }

  vpc_security_group_ids = ["sg-561f3531"]
}
