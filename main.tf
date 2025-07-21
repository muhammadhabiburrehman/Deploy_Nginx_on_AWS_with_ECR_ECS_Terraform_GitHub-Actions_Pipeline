provider "aws" {
  region = var.aws_region
}


# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get public subnets in default VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



# ECR Module
module "ecr" {
  source = "./modules/ecr"

  environment          = var.environment
  name                 = var.app_name
  repository_name      = var.repository_name
  enabled              = true
  image_names          = [var.app_name]
  use_fullname         = true
  max_image_count      = 100
  scan_images_on_push  = true
  image_tag_mutability = "MUTABLE"
  encryption_configuration = { encryption_type = "AES256"
    kms_key = null
  }
  min_image_count = 5
}

# Load Balancer Module
module "alb" {
  source = "./modules/load_balancer"

  name              = var.app_name
  vpc_id            = data.aws_vpc.default.id
  subnets           = data.aws_subnets.public.ids
  security_group_id = aws_security_group.alb.id
  target_port       = var.container_port
  health_check_path = "/"
  tags              = var.tags
}

# Security Group for ALB
resource "aws_security_group" "alb" {
  name   = "${var.app_name}-alb-sg"
  vpc_id = data.aws_vpc.default.id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# ECS Module
module "ecs" {
  source              = "./modules/ecs"
  app_name            = var.app_name
  vpc_id              = data.aws_vpc.default.id
  subnets             = data.aws_subnets.public.ids
  container_image     = "${module.ecr.repository_url}:latest"
  container_port      = var.container_port
  cpu                 = 256
  memory              = 512
  desired_count       = 1
  assign_public_ip    = true
  target_group_arn    = module.alb.target_group_arn
  listener_dependency = module.alb.listener_http
}
