#############################
## Application - Variables ##
#############################

# company name 
variable "company" {
  type        = string
  description = "The company name used to build resources"
}

# application name 
variable "app_name" {
  type        = string
  description = "The application name used to build resources"
}

# application or company environment
variable "environment" {
  type        = string
  description = "Defines the environment to be built"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "north europe"
}