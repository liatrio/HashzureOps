include {
  path = find_in_parent_folders()
}

remote_state {
  backend = "local"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = { 
    path = "${get_terragrunt_dir()}/bootstrap-local.tfstate"
  }
}
