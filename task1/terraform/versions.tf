terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.17"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

locals {
  config_file = "../../../k8s-credentials"
}

provider "kubernetes" {
  config_path    = local.config_file
  config_context = "bartoszcisek"
}

provider "helm" {
  kubernetes {
    config_path    = local.config_file
  }
}