variable "cluster" {
  description = "The name cluster"
}

variable "secret_name" {
  type        = string
  description = "The name of cluster secret"
}

variable "branch" {
  type        = string
  description = "The name of branch"
}

variable "secrets" {
  description = "A map of secrets"
}
