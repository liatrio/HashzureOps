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
    source = "..//terraform"
    extra_arguments "shared_vars" {
        commands = get_terraform_commands_that_need_vars()
    }

    extra_arguments "retry_lock" {
        commands  = get_terraform_commands_that_need_locking()
        arguments = ["-lock-timeout=20m"]
    }

}

inputs = {
    resource_group = local.common_vars.resource_group_name
    storage_account_name = local.common_vars.storage_account_name
    keyvault_name = local.common_vars.keyvault_name
}
