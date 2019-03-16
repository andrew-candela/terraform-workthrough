variable "broker_count" {
  default = 3
}

variable "instance_type" {
  description = "EC2 type of Kafka broker"
  default     = "t2.micro"
}

variable "broker_root_volume_size" {
  description = "size of root volume of kafka brokers"
  default     = 8
}

variable "broker_key_name" {
  description = "describe your variable"
  default     = "admin"
}

variable "env" {}

variable "broker_ami" {
  description = "ami of kafka brokers"
}
