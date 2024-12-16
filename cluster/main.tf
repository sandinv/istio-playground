resource "kind_cluster" "default" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # Control plane node configuration
    node {
      role = "control-plane"

      # Patching kubeadm configuration for control-plane node
      kubeadm_config_patches = [
        <<EOT
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    node-labels: "ingress-ready=true"
EOT
      ]

      # Dynamic block for port mappings
      dynamic "extra_port_mappings" {
        for_each = var.extra_port_mapping
        content {
          container_port = extra_port_mappings.value.container_port
          host_port      = extra_port_mappings.value.host_port
          protocol       = extra_port_mappings.value.protocol
        }
      }
    }

    # Worker node configuration
    node {
      role = "worker"
    }
  }
}