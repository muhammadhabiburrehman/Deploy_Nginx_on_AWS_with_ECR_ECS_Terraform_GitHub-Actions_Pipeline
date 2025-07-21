output "ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

# output "target_group_arn" {
#   value = aws_lb_target_group.this.arn
# }

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}
