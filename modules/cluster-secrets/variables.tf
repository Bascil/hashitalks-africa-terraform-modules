variable "cluster" {
  type        = string
  description = "The name cluster"
}

variable "secret_name" {
  type        = string
  description = "The name of cluster secret"
}

variable "secrets" {
  description = "A map of secrets"
}
