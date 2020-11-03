variable "rg_name" {
  type        = string
  default     = "hashzureops"
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Location to deploy resources"
}

variable "app_service_name" {
  type        = string
  default     = "app"
  description = "Name of the app service"
}

variable "app_service_plan_tier" {
  default     = "Standard"
  type        = string
  description = "App Service Plan Tier"
}

variable "app_service_plan_size" {
  default     = "S1"
  type        = string
  description = "App Service Plan Size"

}

variable "docker_registry_url" {
  type        = string
  description = "Url to pull App image from"
}

variable "app_image" {
  type        = string
  default     = "liatrio/podinfo"
  description = "Image to deploy to App Service"
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "Version of Image to deploy to App Service"
}

variable "acr_user" {
  type        = string
  description = "Username for app service to auth with container registry"
}

variable "acr_password" {
  type        = string
  description = "Password for app service to auth with container registry"
}
