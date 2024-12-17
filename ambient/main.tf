provider "helm" {
  kubernetes {
    config_path = "istio-config"
  }
}
provider "kubernetes" {
  config_path = "istio-config"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.18.0"
    }
  }
}
provider "kubectl" {
  config_path = "istio-config"
}

module "cluster" {
  source = "../cluster"

  cluster_name = "istio"
  extra_port_mapping = [
    {
      container_port = 31883
      host_port      = 8000
      protocol       = "tcp"
    },
    {
      container_port = 443
      host_port      = 8443
      protocol       = "tcp"
    }
  ]
}

resource "helm_release" "istio-base" {
  depends_on = [
    module.cluster
  ]
  name             = "istio-base"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  version          = "1.24.1"
  chart            = "base"
}