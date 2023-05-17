variable "project" {
  type        = string
  description = "The name of the project"
}

variable "region" {
  type        = string
  description = "The name of the region"
}

variable "branch" {
  type        = string
  description = "The name of the branch"
}

variable "keyring_name" {
  description = "Name of the KMS Keyring"
  type        = string
  default     = "cloud-keyring"
}

variable "key_name" {
  description = "Name of the KMS key"
  type        = string
  default     = "cloud-key"
}

variable "algorithm" {
  description = "Algorithm for the KMS key"
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "rotation_period" {
  description = "Time in seconds to rotate key"
  type        = string
  default     = "2592000s" #30 days by default
}

