provider "google" {
  project = var.project_id
  region  = var.region
}
resource "google_container_cluster" "primary" {
  name     = "${var.env}-gke-cluster"
  location = var.region
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  initial_node_count = 1
  min_master_version = "1.29.6-gke.1038001" 
  deletion_protection = false
  # Disable legacy ABAC (ensuring the read-only port is disabled)
  enable_legacy_abac = false
  release_channel {
    channel = "REGULAR"
  }


  node_config {
    machine_type = "e2-medium"
    
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
    remove_default_node_pool = true

}

resource "google_container_node_pool" "primary_nodes" {
  name     = "${var.env}-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1

  node_config {
    labels = {
      env = var.project_id
    }
    machine_type = "e2-medium"
    metadata = {
      disable-legacy-endpoints = "true"
    }
    disk_size_gb = 30
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

/*
### Commented below

# Create DNS Record
resource "google_dns_record_set" "dns_record" {
  name         = "${var.dns_record_name}.${var.domain_name}."
  managed_zone = var.managed_zone
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.load_balancer_ip.address]
}



resource "google_compute_address" "static_ip" {
  name = "${var.env}-kr-apps"
  region = var.region
}

data "google_compute_address" "static_ip" {
  name = google_compute_address.static_ip.name
}

resource "google_dns_managed_zone" "dns_zone" {
  name        = "my-dns-zone"
  dns_name    = "${var.env}-kr-apps.com."
  description = "My DNS zone"
}

resource "google_dns_record_set" "a_record" {
  name         = "${var.env}-kr-apps.com."
  managed_zone = google_dns_managed_zone.dns_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [data.google_compute_address.static_ip.address]
}








# IAM Role for GKE Cluster
resource "google_project_iam_member" "gke_cluster_admin" {
  project = var.project
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${var.notification_email}" #service_account_email
}

# IAM Role for GKE Node Pool
resource "google_project_iam_member" "gke_node_admin" {
  project = var.project
  role    = "roles/container.nodeAdmin"
  member  = "serviceAccount:${var.notification_email}" #service_account_email
}


#communication between pods and external IPs
resource "kubernetes_network_policy" "allow_incoming_traffic" {
  metadata {
    name      = "allow-incoming-traffic"
    namespace = "default"
  }

  spec {
    pod_selector {}

    ingress {
      from {
        pod_selector {}
      }

      ports {
        protocol = "TCP"
        port     = 80
      }
    }
  }
}

*/