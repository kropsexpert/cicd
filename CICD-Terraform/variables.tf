variable "project_id" {
  description = "The project ID to deploy the resources in"
  type        = string
}

variable "region" {
  description = "The region to deploy the resources in"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The GCS bucket name for storing Terraform state"
  type        = string
}

variable "env" {
  description = "The environment (e.g., test, prod)"
  type        = string
}
