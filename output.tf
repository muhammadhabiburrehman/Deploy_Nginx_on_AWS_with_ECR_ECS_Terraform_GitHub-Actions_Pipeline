output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}
