# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

locals {
    common_vars = {
        storage_account_name = "hashzureopstfstatesa"
        resource_group_name = "hashzureopstfstate"
        keyvault_name = "hashzureopskv"
    }
}

terraform {
    source = "../..//stages/shared"
    extra_arguments "shared_vars" {
        commands = get_terraform_commands_that_need_vars()
    }

    extra_arguments "retry_lock" {
        commands  = get_terraform_commands_that_need_locking()
        arguments = ["-lock-timeout=20m"]
    }

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
    key                  = "hashzureops/shared.tfstate"
  }
}

inputs = {
  resource_group = "hashzureopsacr"
  acr_instance_name = "hashzureopsacr"
}
