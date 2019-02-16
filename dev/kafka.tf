module "kafka" {
  source        = "../modules/kafka"
  broker_count  = 2
  instance_type = "r4.xlarge"
  env           = "dev"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  broker_ami    = "ami-05a51d772f0a82f30"

  # security_groups = ["sg-561f3531"]
}
