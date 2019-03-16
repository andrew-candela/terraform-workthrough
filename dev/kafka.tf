module "kafka" {
  source = "../modules/kafka"

  broker_count  = 2
  instance_type = "r4.xlarge"
  env           = "dev"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  broker_ami    = "ami-0616e48fc6849fb5f" # Has kafka and zookeeper and java but not configured

  # broker_ami    = "ami-06397100adf427136" # Raw Ubuntu 18.04 LTS
}
