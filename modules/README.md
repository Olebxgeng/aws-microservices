This project uses Terraform to create a simple, scalable, and cost-optimized AWS infrastructure for a microservices app. It sets up:

A Virtual Private Cloud (VPC) with public and private networks.
EC2 instances in an Auto Scaling Group (ASG) that automatically add/remove servers based on CPU usage.
An RDS database (PostgreSQL) for storing app data.

aws-microservices/
├── provider.tf             # Sets up AWS
├── variables.tf            # Settings you can change
├── terraform.tfvars        # Region & db password. (not shared in Github)
├── main.tf                 # Main plan
├── outputs.tf              # Results after deploy
├── modules/                # Reusable parts
│   ├── vpc/                # Network setup
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2_asg/            # Servers that scale
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── rds/                # Database
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md               # This file