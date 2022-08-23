variable "component" {
  type = string
  description = "The name of the component being deployed"
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
