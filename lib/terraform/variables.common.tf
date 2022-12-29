variable "component" {
  type = string
  description = "The name of the component being deployed"
  sensitive = false
  nullable = false
}

variable "image_tag" {
  type = string
  description = "The deployer immutable image tag holding the changes"
  sensitive = false
  nullable = false
}

variable "project" {
  type = string
  description = "The repository holding the terraform for this component"
  sensitive = false
  nullable = false
}

variable "user" {
  type = string
  description = "The user performing the change (approximately, derives from whoami and hostname on endpoint)"
  sensitive = false
  nullable = false
}

variable "repository" {
  type = string
  description = "The source code repository where the component code can be found"
  sensitive = false
  nullable = false
}

variable "product" {
  type = string
  description = "The product supported by the component"
  sensitive = false
  nullable = false
}
