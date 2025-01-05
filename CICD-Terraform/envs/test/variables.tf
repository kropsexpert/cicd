variable "project_id" {
  description = "The project ID to deploy the resources in"
  type        = string
  default = "vibrant-waters-429918-r1"
}

variable "region" {
  description = "The region to deploy the resources in"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The GCS bucket name for storing Terraform state"
  type        = string
  default = "terra-101"
}

variable "env" {
  description = "The environment name"
  type        = string
  default     = "test"
}

variable "db_password" {
  description = "Postgress DB New User Password to set"
  type        = string
  default = "abcdef1"
}


variable "notification_email" {
  description = "Email address for alert notifications"
  type        = string
  default = "klsvreddy@gmail.com"
}


