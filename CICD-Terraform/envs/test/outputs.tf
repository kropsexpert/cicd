output "cluster_name" {
  value = module.gke.cluster_name
}

output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.gke.cluster_ca_certificate
}

output "subnet_name" {
  value = module.subnet.subnet_name
}

output "subnet_self_link" {
  value = module.subnet.subnet_self_link
}

output "database_instance_name" {
  value = module.psql.database_instance_name
}

output "database_name" {
  value = module.psql.database_name
}


output "alert_policy_id" {
  value = module.monitoring.alert_policy_id
}

