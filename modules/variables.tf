variable "aws_region" {
  description = "AWS region (e.g., us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "IP range for your virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public IP ranges (accessible from internet)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private IP ranges (secure, for databases)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ec2_instance_type" {
  description = "EC2 server size (t3.micro is free-tier)"
  type        = string
  default     = "t3.micro"
}

variable "rds_instance_class" {
  description = "RDS database size"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "microservices_db"
}

variable "db_username" {
  description = "Database login username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password (keep secret!)"
  type        = string
  sensitive   = true
}