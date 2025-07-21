variable "name" {}
variable "enabled" {default = true}
variable "image_names" {}
variable "use_fullname" {default = false} 
variable "max_image_count" {default = 5}
variable "scan_images_on_push" {default = true}
variable "image_tag_mutability" {default = "MUTABLE"}

variable "encryption_configuration" {
    type = object({
        encryption_type = string
        kms_key = any
    }) 
    description = "ECR encryption configuration"
    default = {
        encryption_type = "KMS"
        kms_key = null
    }
}

variable "environment" {}
variable "repository_name" {}
variable "min_image_count" { default = 2 }