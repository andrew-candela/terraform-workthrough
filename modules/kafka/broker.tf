resource "aws_instance" "broker" {
  associate_public_ip_address = true
  count                       = "${var.broker_count}"
  instance_type               = "${var.instance_type}"

  root_block_device {
    volume_size = "${var.broker_root_volume_size}"
  }

  ami      = "${var.broker_ami}"
  key_name = "admin"

  # subnet_id              = "${element(var.kafka_subnet_ids, count.index)}"
  # iam_instance_profile   = "${aws_iam_instance_profile.kafka_profile.id}"
  # vpc_security_group_ids = ["${var.security_group}"]

  tags {
    Name = "${var.env}-kafka_broker"
    Type = "Kafka_testing"
  }
  vpc_security_group_ids = ["sg-561f3531"]

  # might wanna use this in the future
  # lifecycle {
  #   ignore_changes = [ "ami" ]
  # }
  # provisioner "chef" {
  #   attributes_json = <<CHEF
  #   {
  #     "hired_env": "${var.env}",
  #     "aws_region": "${var.region}",
  #     "redshift_s3_arn": "${var.redshift_s3_arn}",
  #     "luigi_hired": {
  #       "scheduler_host": "${var.central_scheduler_endpoint}"
  #     },
  #     "tags": ["${var.env}", "luigi", "worker"]
  #   }
  #   CHEF
  #   ohai_hints = ["${path.module}/ohai_hints/ec2.json"]
  #   run_list = ["role[${var.chef_role}]"]
  #   node_name = "${var.env}-luigi-${var.chef_role}-${self.id}"
  #   environment = "${var.env}"
  #   secret_key = "${var.encrypted_data_bag_secret}"
  #   server_url = "https://api.chef.io/organizations/hired"
  #   user_name = "hired-validator"
  #   user_key = "${var.chef_validation_key}"
  #   version = "${var.chef_version}"
  #   connection {
  #     user = "ubuntu"
  #     private_key = "${var.terraform_ssh_key}"
  #   }
  # }
}
