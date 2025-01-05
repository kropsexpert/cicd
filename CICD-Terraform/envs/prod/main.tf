module "gke" {
  source = "../../modules/gke"
  region = var.region
  env    = var.env
  project_id=var.project_id
}

module "subnet" {
  source = "../../modules/subnet"
  region = var.region
  env    = var.env
  project_id=var.project_id
}

module "psql" {
  source = "../../modules/psql"
  region = var.region
  env    = var.env
  project_id=var.project_id
  db_password=var.db_password
}

module "monitoring" {
  source             = "../../modules/monitoring"
  env                = var.env
  notification_email = var.notification_email
  project_id=var.project_id
}
/*
module "ingress" {
  source             = "../../modules/ingress"
  env                = var.env
  region      = var.region
  project_id         = var.project_id
}
*/