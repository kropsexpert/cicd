variable "region" {
  description = "The region to deploy the database in"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
}

variable "db_password" {
   description = "Postgress DB New User Password to set"
  type        = string
}

variable "project_id" {
  description = "The project ID to deploy the resources in"
  type        = string
}