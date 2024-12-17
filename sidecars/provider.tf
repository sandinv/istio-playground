terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.0"
    }
	kind = {
      source  = "tehcyx/kind"
      version = "0.7.0"
    }
  }
}