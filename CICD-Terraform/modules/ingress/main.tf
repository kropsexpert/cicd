provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  #load_config_file = true
  config_path      = "~/.kube/config"
}

resource "kubernetes_service" "my_service" {
  metadata {
    name      = "${var.env}-my-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "my-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "NodePort"
  }
}


resource "kubernetes_ingress" "my_ingress" {
  metadata {
    name      = "${var.env}-my-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class" = "gce"  # Specify GCE ingress controller
    }
  }

  spec {
    rule {
      host = "${var.env}-kr-app.com"

      http {
        path {
          path     = "/"
          #pathType = "Prefix"  # Ensure correct API version usage

          backend {
            service_name = kubernetes_service.my_service.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }
}


resource "google_compute_global_address" "default" {
  name    = "${var.env}-env-static-ip"
  project = var.project_id
 # region  = "global"
}

# Resource to create managed zone if it doesn't exist
resource "google_dns_managed_zone" "my_dns_zone" {
  count       = length(data.google_dns_managed_zone.existing.name) == 0 ? 1 : 0
  name        = "my-dns-zone"
  dns_name    = "${var.env}-kr-app.com."
  description = "Managed zone for env-kr.com"
  project     = var.project_id
}

# Data source to check if the managed zone exists
data "google_dns_managed_zone" "existing" {
  name = "my-dns-zone"
  project = var.project_id
}

resource "google_dns_record_set" "default" {
  name         = "${var.env}-kr-app.com."
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.default.address]
  managed_zone = google_dns_managed_zone.my_dns_zone[0].name
  project      = var.project_id
}
