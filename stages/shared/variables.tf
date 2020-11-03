variable "rg_name" {
  type        = string
  default     = "hashzureops"
  description = "Name of Azure Resource Group"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Location to deploy resources"
}

variable "acr_instance_name" {
  type        = string
  description = "Name of Azure Container Registry Instance"
}

