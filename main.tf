provider "google" {
  project = var.project_name
  region  = var.region
}

module "amarok" {
  source              = "./modules/amarok"
  network_name        = var.network_name
  cloudnat_name       = var.cloudnat_name
  region              = var.region
  source_ranges       = var.source_ranges
  router_instance     = var.router_instance
  redis               = var.redis
  sharezone_instance  = var.sharezone_instance
  web3signer_instance = var.web3signer_instance
  ssh_keys            = var.ssh_keys
}
