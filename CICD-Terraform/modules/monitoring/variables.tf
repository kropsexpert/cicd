variable "env" {
  description = "The environment name"
  type        = string
}

variable "notification_email" {
  description = "Email address for alert notifications"
  type        = string
}


variable "project_id" {
  description = "The project ID to deploy the resources in"
  type        = string
}