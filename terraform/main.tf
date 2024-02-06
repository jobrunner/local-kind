module "kind_cluster" {
  source = "git@github.com:jobrunner/terraform-kind-cluster.git?ref=fixes-and-nginx-ingress"
  # source = "../../terraform-kind-cluster"
  cluster_name          = "local"
  enable_metrics_server = false
  enable_loadbalancer   = false
  enable_registry       = false
  enable_ingress        = true
  ingress_controller    = "Nginx"
  kubernetes_version    = "1.28.6"
  node_image            = "kindest/node"
  nodes = [
    {
      role                   = "control-plan"
      kubeadm_config_patches = []
      extra_port_mappings = [
        {
          container_port = 80
          host_port      = 80
          listen_address = "0.0.0.0"
          protocol       = "TCP"
        },
        {
          container_port = 443
          host_port      = 443
          listen_address = "0.0.0.0"
          protocol       = "TCP"
        }
      ]
    },
    {
      role                   = "worker"
      kubeadm_config_patches = []
      extra_port_mappings    = null
    }
  ]
}
