resource "aws_launch_template" "ec2" {
  name_prefix   = "microservices-"
  image_id      = "ami-0c55b159cbfafe1d0"  # Pre-built Linux server image
  instance_type = var.instance_type
  key_name      = var.key_name  # For SSH access

  # Cost optimization: Use spot instances (cheaper, but can stop)
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.01"  # Max bid price (adjust for your instance)
    }
  }

  vpc_security_group_ids = [aws_security_group.ec2.id]
}

resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.ec2.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.public_subnets
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

  tag {
    key                 = "Name"
    value               = "Microservices-EC2"
    propagate_at_launch = true
  }
}

# Scalability: Auto-scale based on CPU
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1  # Add 1 server
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300  # Wait 5 mins
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"  # If CPU > 70%, scale up
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
}

# Similar for scale down (CPU < 30%)
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "low_cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
}

resource "aws_security_group" "ec2" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22  # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all (restrict later)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound
  }
}