variable "kubeconfig_dir_path" {
  description = "Path to the directory where the kube config file will be stored"
  default     = "~/.kube"
}

variable "kubeconfig_file_path" {
  description = "Path to the local kube config file"
  default     = "~/.kube/config"
}

variable "kube_web_namespace" {
  description = "Namespace for the web application deployment."
  type        = string
}

variable "kube_monitoring_namespace" {
  description = "Namespace for the monitoring services deployment."
  type        = string
}

variable "web_app_port" {
  description = "Port number on which the web application will run."
  type        = number
}

variable "web_app_container_image" {
  description = "Docker image for the web application."
  type        = string
}

variable "prometheus_container_image" {
  description = "Docker image for Prometheus."
  type        = string
}

variable "grafana_container_image" {
  description = "Docker image for Grafana."
  type        = string
}

variable "grafana_admin_username" {
  description = "Username for the Grafana admin user."
  type        = string
}

variable "grafana_admin_password" {
  description = "Password for the Grafana admin user."
  type        = string
}
