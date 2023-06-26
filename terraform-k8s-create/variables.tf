variable "aws_region" {
  description = "AWS region where the resources will be provisioned."
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance."
  type        = string
}

variable "ec2_os_disk_size" {
  description = "Size of the OS disk in gigabytes"
  type        = number
}


variable "ec2_security_groups" {
  description = "List of security group names for the EC2 instance."
  type        = list(string)
}

variable "ec2_user" {
  description = "Username for connecting to the EC2 instance"
  type        = string
}

variable "ec2_key_pair" {
  description = "Key pair name for SSH access to the EC2 instance."
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the SSH private key file"
  type        = string
}

variable "k3s_version" {
  description = "K3s version"
  type        = string
}

variable "kubeconfig_dir_path" {
  description = "Path to the directory where the kube config file will be stored"
  default     = "~/.kube"
}

variable "kubeconfig_file_path" {
  description = "Path to the local kube config file"
  default     = "~/.kube/config"
}
