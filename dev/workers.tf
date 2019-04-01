module "workers" {
  source       = "../modules/worker"
  worker_count = 2

  instance_type = "r4.large"
  env           = "dev"

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  worker_ami = "ami-069faaeafbd94044e" # use the default AMI for ubuntu server with python installed
}
