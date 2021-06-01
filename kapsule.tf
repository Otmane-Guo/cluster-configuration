provider "scaleway" {
  zone            = "fr-par-1"
  region          = "fr-par"
}

resource "scaleway_k8s_cluster_beta" "griloKapsule" {
  name = "griloKapsule"
  version = "1.18.2"
  cni = "weave"
  enable_dashboard = true
  ingress = "nginx"
  default_pool {
    node_type = "GP1-XS"
    size = 1
    autoscaling = true
    autohealing = true
    min_size = 1
    max_size = 3
  }
}

resource "local_file" "kubeconfig" {
  content = scaleway_k8s_cluster_beta.griloKapsule.kubeconfig[0].config_file
  filename = "kubeconfig"
}

output "cluster_url" {
  value = scaleway_k8s_cluster_beta.griloKapsule.apiserver_url
}
