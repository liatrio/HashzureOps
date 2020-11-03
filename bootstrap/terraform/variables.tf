variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "resource_group" {
  type        = string
  description = "Resource group where terraform will be created."
}

variable "storage_account_name" {
  type = string
}

variable "keyvault_name" {
  type    = string
  default = "kvtfstate"
}

variable "location" {
  type    = string
  default = "centralus"
}

variable "reference_repo_url" {
  type    = string
  default = "https://github.com/liatrio/HashzureOps.git"
}
