module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = ["us-east-1a", "us-east-1b"]  
}

module "ec2_asg" {
  source           = "./modules/ec2_asg"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnet_ids
  instance_type    = var.ec2_instance_type
  min_size         = 1  
  max_size         = 5  
  desired_capacity = 2  
  key_name         = "my-key"  
}

module "rds" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  instance_class  = var.rds_instance_class
  db_name         = var.db_name
  username        = var.db_username
  password        = var.db_password
}