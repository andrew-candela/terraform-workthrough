variable "worker_count" {
  default = 1
}

variable "instance_type" {
  description = "EC2 type"
  default     = "t2.micro"
}

variable "worker_root_volume_size" {
  description = "size of root volume of workers"
  default     = 8
}

variable "worker_key_name" {
  description = "describe your variable"
  default     = "admin"
}

variable "env" {}

variable "worker_ami" {
  description = "ami of workers"
}
