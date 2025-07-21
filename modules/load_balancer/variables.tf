variable "name" {
  description = "Name prefix for ALB resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "List of subnets for ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for ALB"
  type        = string
}

variable "target_port" {
  description = "Port to forward traffic to"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path for target group health check"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
