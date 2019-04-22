module "zookeeper" {
  source        = "../modules/zookeeper"
  node_count    = 1
  instance_type = "r4.large"
  env           = "dev"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
  zookeeper_ami = "ami-0616e48fc6849fb5f" # Has kafka and zookeeper and java but not configured
}
