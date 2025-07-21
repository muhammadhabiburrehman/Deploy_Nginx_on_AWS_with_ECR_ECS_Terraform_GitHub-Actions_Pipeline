variable "app_name" {
  description = "Name of the application and ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS service will run"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "container_image" {
  description = "Docker container image URI to deploy"
  type        = string
}

variable "container_port" {
  description = "Container port to expose"
  type        = number
  default     = 80
}

variable "cpu" {
  description = "CPU units for ECS task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MB) for ECS task"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "assign_public_ip" {
  description = "Assign public IP to ECS tasks"
  type        = bool
  default     = true
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "listener_dependency" {
  description = "Resource to depend on for ALB listener (use a resource or module output)"
  type        = any
}
