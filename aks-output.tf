#######################################
## Azure Kubernetes Service - Output ##
#######################################

output "aks_client_key" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.client_key
}

output "aks_client_certificate" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.client_certificate
}

output "aks_cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.cluster_ca_certificate
}

output "aks_cluster_username" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.username
}

output "aks_cluster_password" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.password
}

output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config_raw
}

output "aks_host" {
  value = azurerm_kubernetes_cluster.k8s-cluster.kube_config.0.host
}