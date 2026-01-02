output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_asg_id" {
  value = module.ec2_asg.asg_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}