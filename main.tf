
module "github_repository" {
  source                   = "./modules/github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "gke_cluster" {
  source         = "./modules/google-gke-cluster"
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GOOGLE_REGION  = var.GOOGLE_REGION
  GKE_NUM_NODES  = 1
}

module "flux_bootstrap" {
  source            = "./modules/fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_host       = module.gke_cluster.config_host
  config_client_key = module.gke_cluster.name
  config_ca         = module.gke_cluster.config_ca
  config_crt        = module.gke_cluster.config_token
}
module "tls_private_key" {
  source    = "./modules/hashicorp-tls-keys"
  algorithm = "RSA"
}