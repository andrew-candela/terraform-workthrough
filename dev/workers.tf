module "workers" {
  source       = "../modules/worker"
  worker_count = 0

  instance_type = "r4.xlarge"
  env           = "dev"

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  worker_ami = "ami-0ff7f191316dba328" # use the default AMI for ubuntu server 
}
