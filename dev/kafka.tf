module "kafka" {
  source = "../modules/kafka"

  broker_count  = 2
  instance_type = "r5.large"
  env           = "dev"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  broker_ami    = "ami-018678140a0bd668c" # Has kafka and java but not configured. also had given ubuntu user access to conf

  # broker_ami    = "ami-06397100adf427136" # Raw Ubuntu 18.04 LTS
}
