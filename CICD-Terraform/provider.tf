provider "google" {
  project = var.project_id
  region  = var.region
}



resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}
resource "google_project_service" "storage" {
  service = "storage.googleapis.com"
}
resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}
resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}
resource "google_project_service" "logging" {
  service = "logging.googleapis.com"
}
resource "google_project_service" "monitoring" {
  service = "monitoring.googleapis.com"
}


terraform {
  backend "gcs" {
    bucket = var.bucket_name
    prefix = "terraform/state-${var.env}"
  }
}