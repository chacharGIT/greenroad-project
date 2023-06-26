resource "kubernetes_namespace" "web_namespace" {
  metadata {
    name = var.kube_web_namespace
  }
}

# Kubernetes Deployment for Web Application
resource "kubernetes_deployment" "web_deployment" {
  metadata {
    name      = "web-deployment"
    namespace = kubernetes_namespace.web_namespace.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "web"
      }
    }

    template {
      metadata {
        labels = {
          app = "web"
        }
      }

      spec {
        container {
          name  = "web-container"
          image = var.web_app_container_image
          port {
            container_port = var.web_app_port
          }
        }
      }
    }
  }
}

# Kubernetes Service for Web Application
resource "kubernetes_service" "web_service" {
  metadata {
    name      = "web-service"
    namespace = kubernetes_namespace.web_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "web"
    }

    port {
      name        = "http"
      protocol    = "TCP"
      node_port   = 30080
      port        = var.web_app_port
      target_port = var.web_app_port
    }

    type = "NodePort"
  }
}
