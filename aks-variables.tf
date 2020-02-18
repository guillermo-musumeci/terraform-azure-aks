##########################################
## Azure Kubernetes Service - Variables ##
##########################################

variable "default_node_count" {
  type        = string
  description = "The number of nodes of the default node pool"
  default     = 1
}

variable "default_node_size" {
  type        = string
  description = "The size of the virtual machine of the default node pool"
  default     = "Standard_DS1_v2"
}

variable "default_node_disk_size" {
  type        = string
  description = "The size of the disk of the default node pool"
  default     = "20"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "k8stest"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
  default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
  default = "PerGB2018"
}