provider "google" {
  project = var.project_id
  region  = var.region
}
resource "google_sql_database_instance" "postgres_instance" {
  name             = "${var.env}-app-db"
  database_version = "POSTGRES_11"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    

    backup_configuration {
      enabled = false
    }

    ip_configuration {
      authorized_networks {
        name = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }
}


# Create a PostgreSQL Database
resource "google_sql_database" "postgres_database" {
  name     = "${var.env}-app-db"
  instance = google_sql_database_instance.postgres_instance.name
  charset  = "utf8"
}
# Create a PostgreSQL User
resource "google_sql_user" "postgres_user" {
  name     = "${var.env}appdb-usr1"
  instance = google_sql_database_instance.postgres_instance.name
  password = var.db_password
}


# Output PostgreSQL Instance Public IP
data "google_sql_database_instance" "host_ip_address" {
  name = google_sql_database_instance.postgres_instance.name
}

#Create a Global Address for the Load Balancer
# Create the Backend Service

# Create a Health Check
# Create an Instance Group 
# Create the Load Balancer
