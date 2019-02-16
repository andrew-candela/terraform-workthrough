variable "node_count" {
  default = 1
}

variable "instance_type" {
  description = "EC2 type of Zookeeper node"
  default     = "t2.micro"
}

variable "zookeeper_node_root_volume_size" {
  description = "size of root volume of zookeeper nodes"
  default     = 8
}

variable "security_group" {
  description = "something"
  default     = "something_else"
}

variable "env" {}

variable "zookeeper_ami" {
  description = "ami_of_zookeeper_nodes"
}
