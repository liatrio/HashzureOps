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
    source = "../..//stages/app"
    extra_arguments "shared_vars" {
        commands = get_terraform_commands_that_need_vars()
    }

    extra_arguments "retry_lock" {
        commands  = get_terraform_commands_that_need_locking()
        arguments = ["-lock-timeout=20m"]
    }

}

inputs = {
    location = "centralus"
    resource_group = "hashzureops"
    app_service_name = "app"
    app_service_plan_tier =  "Standard"
    app_service_plan_size =  "S1"
    docker_registry_url = "hashzureopsacr.azurecr.io"
    image_version = "0.0.3"
}
