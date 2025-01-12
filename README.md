# DevOps Challenge

This repository contains a simple Flask application.
It uses PostgreSQL as the database of choice.

Application has two endpoints:
- `/users` that list users
- `/health` for healthcheck

Database schema is provided in file `source/init.sql`. You can use it to create a database schema.

Dockerize the application and push it to your choice public Docker Registry.
Deploy this application along with Postgres database to a provided Kubernetes cluster.
For deployment, choose Terraform, Ansible, or both.

# Task 1
## Dockerize the application
Docker image would be build automatically by GitHub Actions and pushed to ghcr.io 
once tag is pushed. Tag need to be in format `vYYYYMMDDVV` where `YYYYMMDD` is the 
date and `VV` is the version.

## Terraform configuration
Access to kubernetes cluster is granted with credentials set in `versions.tf` file.
```terraform
locals {
  config_file = "../../../k8s-credentials"
}
```

## Deploy the application
Application is deployed to Kubernetes cluster using Terraform.
```bash
terraform apply
```

# Task 2
## Terraform configuration
Cloudscale provider needs API key to access environment. It is set by `env` variable `CLOUDSCALE_API_TOKEN`.
```bash
export CLOUDSCALE_API_TOKEN=<redacted>
terraform init
terraform apply
```
Output from Terraform will contain IP address of the created instance that needs to be added to inventory file: `inventory/inventory.ini`

## Secrets
Grafana API key used to deploy dashboard is encrypted using pass stored in file `secret.pass`. In this case file is added to repo, 
but in real life example, sensitive value would be fetched on deploy time from encrypted secret storage. 

## Deploy grafana agent
Grafana agent is deployed to Kubernetes cluster using Ansible.
```bash
ansible-galaxy collection install grafana.grafana --force
ansible-playbook -i inventory/inventory.ini playbook.yaml --vault-pass-file secret.pass
```
