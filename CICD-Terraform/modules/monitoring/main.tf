provider "google" {
  project = var.project_id
}

resource "google_monitoring_dashboard" "default" {
  dashboard_json = jsonencode({
    displayName = "${var.env} Monitoring Dashboard",
    gridLayout = {
      columns = 3,
      widgets = [
        {
          title = "Pod CPU Utilization",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"k8s_container\" AND metric.type=\"kubernetes.io/container/usage_cpu\"",
                  },
                },
              },
            ],
          },
        },
        {
          title = "Pod Memory Utilization",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"k8s_container\" AND metric.type=\"kubernetes.io/container/usage_memory\"",
                  },
                },
              },
            ],
          },
        },
        {
          title = "Disk I/O Utilization",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"gce_instance\" AND metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\"",
                  },
                },
              },
            ],
          },
        },
        {
          title = "HTTP Requests",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"k8s_container\" AND metric.type=\"kubernetes.io/http_requests_total\"",
                  },
                },
              },
            ],
          },
        },
        {
          title = "HTTP Status Codes",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"k8s_container\" AND metric.type=\"kubernetes.io/http_status_codes\"",
                  },
                },
              },
            ],
          },
        },
        {
          title = "Request/Response Times",
          xyChart = {
            dataSets = [
              {
                minAlignmentPeriod = "60s",
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "resource.type=\"k8s_container\" AND metric.type=\"kubernetes.io/http_request_duration_seconds\"",
                  },
                },
              },
            ],
          },
        },
      ],
    },
  })
}

resource "google_monitoring_alert_policy" "high_cpu" {
  display_name = "High CPU Usage Alert"

  conditions {
    display_name = "High CPU Usage Condition"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0.8

      aggregations {
        alignment_period  = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  combiner = "OR"
  notification_channels = [google_monitoring_notification_channel.email.id]

   
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type         = "email"
 labels = {
    email_address = var.notification_email
  }
}
