This Terraform project provisions a scalable, cost-optimized AWS infrastructure tailored for deploying a microservices application. It leverages Infrastructure as Code (IaC) principles to create reusable, version-controlled resources that can be deployed across environments with minimal manual intervention.

Key Components

VPC (Virtual Private Cloud): Isolated network with public and private subnets across multiple Availability Zones (AZs) for high availability and security.
EC2 Auto Scaling Group (ASG): Manages a fleet of EC2 instances that automatically scale based on CPU utilization or custom metrics. Includes a load balancer for distributing traffic.
RDS Database: PostgreSQL instance in a private subnet, configured for backups and multi-AZ deployment to ensure data durability and availability.

Why This Project?

Scalability: The ASG dynamically adjusts instance count based on load, ensuring the app handles traffic spikes without over-provisioning.
Cost Optimization: Utilizes spot instances for EC2 (up to 90% savings) and reserved instances for RDS (long-term discounts). Includes monitoring via CloudWatch to track and control expenses.
Modularity: Built with Terraform modules for reusability, allowing easy extension (e.g., add Kubernetes or CI/CD pipelines).
Best Practices: Incorporates tagging, remote state, workspaces, and security groups to align with enterprise standards.


Architecture

The infrastructure follows a multi-tier architecture:

Public Layer: Internet Gateway, public subnets, Application Load Balancer (ALB), and EC2 ASG for handling external traffic.
Private Layer: Private subnets, NAT Gateways (for outbound internet access), and RDS for secure data storage.
Security: Security groups restrict access (e.g., SSH only from VPC, DB access only from EC2).
Monitoring: CloudWatch alarms trigger scaling; metrics are enabled for visibility.
Data Flow: Traffic enters via ALB, routes to EC2 instances, which connect to RDS for data.
Scalability Triggers: CPU > 50% scales up; custom metrics can be added.
Cost Controls: Spot instances for EC2; reserved RDS for savings.
