# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   name = "production"
#   cidr = "172.19.0.0/16"
#   private_subnets = [ "172.19.1.0/24", "172.19.2.0/24", "172.19.3.0/24", "172.19.4.0/24" ]
#   public_subnets  = [ "172.19.101.0/24", "172.19.102.0/24", "172.19.103.0/24", "172.19.104.0/24" ]
#   azs      = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1e" ]
# # ecs fargate uses the nat gateway to pull its docker images
#   enable_nat_gateway = true
#   enable_dns_support = true
#   enable_dns_hostnames = true
# }
# module "security_groups" {
#   source = "../modules/aws_security_groups"
#   vpc_id = "${module.vpc.vpc_id}"
#   vpc_name = "production"
# }

