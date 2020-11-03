include {
  path = find_in_parent_folders()
}

remote_state {
  backend = "azurerm"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "hashzureopstfstate"
    storage_account_name = "hashzureopstfstatesa"
    container_name       = "tfstate"
    key                  = "hashzureops/app-prod.tfstate"
  }
}


inputs = {
  rg_name = "hashzureops-prod"
  app_service_name = "hashzureops-podinfo"
  acr_user = get_env("ARM_CLIENT_ID", "foo")
  acr_password = get_env("ARM_CLIENT_SECRET", "bar")
}
