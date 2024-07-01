terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

provider "kubernetes" {
    config_path = var.k8s-config_path
  }

provider "helm" {
 kubernetes {
    config_path =  var.k8s-config_path
  }
}

provider "kubectl" {
  config_path = var.k8s-config_path
}