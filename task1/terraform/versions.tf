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

provider "kubernetes" {
  config_path    = "../../../k8s-credentials"
  config_context = "bartoszcisek"
}

provider "helm" {
  kubernetes {
    config_path    = "../../../k8s-credentials"
  }
}