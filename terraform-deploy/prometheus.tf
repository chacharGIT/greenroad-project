# Kubernetes Namespace
resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    name = var.kube_monitoring_namespace
  }
}

data "local_file" "instance_public_ip" {
  filename = "instance_public_ip.txt"
}

# Prometheus ConfigMap
resource "kubernetes_config_map" "prometheus_config" {
  depends_on = [data.local_file.instance_public_ip]

  metadata {
    name      = "prometheus-config"
    namespace = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }

  data = {
    "prometheus.yml" = <<-EOF
      global:
        scrape_interval: 15s
        evaluation_interval: 15s

      scrape_configs:
        - job_name: "web-service"
          static_configs:
            - targets: ["${data.local_file.instance_public_ip.content}:${kubernetes_service.web_service.spec.0.port.0.node_port}"]
    EOF
  }
}

# Prometheus Deployment
resource "kubernetes_deployment" "prometheus_deployment" {
  depends_on = [kubernetes_config_map.prometheus_config]

  metadata {
    name      = "prometheus"
    namespace = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "prometheus"
      }
    }

    template {
      metadata {
        labels = {
          app = "prometheus"
        }
      }

      spec {
        container {
          name  = "prometheus-container"
          image = var.prometheus_container_image

          args = [
            "--config.file=/etc/prometheus/prometheus.yml",
            "--storage.tsdb.path=/prometheus",
            "--web.console.libraries=/usr/share/prometheus/console_libraries",
            "--web.console.templates=/usr/share/prometheus/consoles"
          ]

          volume_mount {
            mount_path = "/etc/prometheus"
            name       = "prometheus-config"
          }

          volume_mount {
            mount_path = "/prometheus"
            name       = "prometheus-data"
          }

          readiness_probe {
            http_get {
              path = "/-/ready"
              port = 9090
            }
            initial_delay_seconds = 20
            timeout_seconds       = 3
            period_seconds        = 10
            success_threshold     = 1
            failure_threshold     = 3
          }
        }

        volume {
          name = "prometheus-config"
          config_map {
            name = "prometheus-config"
          }
        }

        volume {
          name = "prometheus-data"
          empty_dir {}
        }
      }
    }
  }

}

# Prometheus Service
resource "kubernetes_service" "prometheus_service" {
  metadata {
    name      = "prometheus-service"
    namespace = kubernetes_namespace.monitoring_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "prometheus"
    }

    port {
      name       = "http"
      protocol   = "TCP"
      port       = 9090
      target_port = 9090
      node_port   = 30090
    }

    type = "NodePort"
  }
}
