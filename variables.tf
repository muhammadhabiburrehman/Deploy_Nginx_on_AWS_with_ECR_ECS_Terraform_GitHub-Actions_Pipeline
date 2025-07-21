variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "nginx-app"
}

variable "environment" {
  default = "dev"
}

variable "repository_name" {
  default = "nginx-repo"

}

# variable "vpc_id" {
#   description = "VPC ID to deploy resources in"
#   type        = string
# }

# variable "public_subnets" {
#   description = "List of public subnets in VPC"
#   type        = list(string)
# }

variable "container_port" {
  default = 80
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
