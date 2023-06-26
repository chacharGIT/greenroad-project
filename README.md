# Greenroad Project

This project deploys a web application on a Kubernetes cluster using Terraform. It consists of two Terraform projects that need to be executed sequentially. The first project creates the Kubernetes cluster, and the second project deploys the web application and Prometheus.

## Requirements

Before running the Terraform code, ensure that you have the following requirements installed:

- Terraform
- kubectl
- Go
- k3sup
- AWS configured with appropriate authentication for terraform

## Setup

To set up the project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/chacharGIT/greenroad-project.git
   ```

2. Configure the necessary variables for both Terraform projects.

- `terraform-k8s-create/variables.tfvars`
- `terraform-deploy/variables.tfvars`

The required variables and description are all in the respective variable decleration files:

- `terraform-k8s-create/variables.tf`
- `terraform-deploy/variables.tf`

3. Initialize and apply the Terraform configurations for each project:

   ```bash
   cd terraform-k8s-create
   terraform init
   terraform apply -var-file=variables.tfvars

   cd ../terraform-deploy
   terraform init
   terraform apply -var-file=variables.tfvars
   ```
## Project Structure

The project directory has the following structure:

- `web-app/`: Directory containing the web application source code and Dockerfile.
- `terraform-k8s-create/`: Directory containing the first Terraform project for creating the Kubernetes cluster.
- `terraform-deploy/`: Directory containing the second Terraform project for deploying the web application and Prometheus.

Feel free to explore the individual directories for more details on the Terraform configurations and application source code.
 
