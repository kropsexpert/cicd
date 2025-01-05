output "database_instance_name" {
  value = google_sql_database_instance.postgres_instance.name
}

output "database_name" {
  value = google_sql_database.postgres_database.name
}


