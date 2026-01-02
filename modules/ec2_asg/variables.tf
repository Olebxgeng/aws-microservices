variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "instance_type" { type = string }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "desired_capacity" { type = number }
variable "key_name" { type = string }