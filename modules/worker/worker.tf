resource "aws_instance" "worker" {
  associate_public_ip_address = true
  count                       = "${var.worker_count}"
  instance_type               = "${var.instance_type}"

  root_block_device {
    volume_size = "${var.worker_root_volume_size}"
  }

  ami      = "${var.worker_ami}"
  key_name = "admin"

  tags {
    # Name = "${var.env}-worker-${self.id}"
    Name = "${var.env}-worker"
    Type = "Kafka_testing"
  }

  vpc_security_group_ids = ["sg-561f3531"]
}
