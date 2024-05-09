provider "google" {
  # Configuration options
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}

module "gke_cluster" {
  source         = "github.com/waild/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = var.GKE_NUM_NODES
}

terraform {
  backend "gcs" {
    bucket = "tf_temp_bucket"
    prefix = "terraform/state"
  }
}
  