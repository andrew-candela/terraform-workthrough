module "kafka" {
  source = "../modules/kafka"

  broker_count  = 1
  instance_type = "r5.xlarge"
  env           = "dev"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  broker_ami    = "ami-0ec3ba8d548d5eb24" # Has kafka and java and some connect jars

  # broker_ami    = "ami-06397100adf427136" # Raw Ubuntu 18.04 LTS
}
