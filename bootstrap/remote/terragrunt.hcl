include {
  path = find_in_parent_folders()
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals.common_vars
}

remote_state {
  backend = "azurerm"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = local.common_vars.resource_group_name
    storage_account_name = local.common_vars.storage_account_name
    container_name       = "tfstate"
    key                  = "bootstrap/bootstrap-terraform.tfstate"
  }
}

