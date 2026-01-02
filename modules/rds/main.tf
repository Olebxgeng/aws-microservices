resource "aws_db_subnet_group" "rds" {
  name       = "microservices-db-subnet"
  subnet_ids = var.private_subnets  
}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc_id
  ingress {
    from_port       = 5432  # PostgreSQL port
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]  
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 20  # GB of storage
  engine               = "postgres"
  engine_version       = "13.7"
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot  = true  
}