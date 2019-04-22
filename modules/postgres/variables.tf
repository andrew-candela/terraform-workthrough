variable "identifier" {}

variable "instance_class" {
  description = "EC2 type of db"
  default     = "db.t2.micro"
}

variable "allocated_storage" {
  description = "size of allocated_storage"
  default     = 10
}

variable "name" {
  default = "admin"
}

variable "password" {}

variable "port" {}

variable "username" {}

variable "env" {}
