provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "${var.env}-vpc-network1"
  auto_create_subnetworks = "false"
}


resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.env}-subnet1"
  ip_cidr_range            = "10.10.0.0/16"
  region                   = var.region
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.env}-vpc-network-k8s-pod-range"
    ip_cidr_range = "10.20.0.0/14"
  }
  secondary_ip_range {
    range_name    = "${var.env}-vpc-network-k8s-service-range"
    ip_cidr_range = "10.50.0.0/28"
  }
}

# Create Firewall Rules
resource "google_compute_firewall" "allow-access" {
  name    = "access-rules1"
  network = google_compute_network.vpc_network.self_link
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["443", "80", "22","5432","8080"]
  }
    # chnage as per the right ips
  source_ranges = ["0.0.0.0/0"]
  # chnage as per the right ips
  #target_tags = [""] 
}


