provider "google" {
  project = var.project_id
  region  = var.region
}

# Short-lived access token of whoever runs Terraform (in the pipeline: the terraform
# service account, logged in through Workload Identity Federation).
data "google_client_config" "this" {}

data "google_container_cluster" "hub" {
  name     = "${var.name_prefix}-hub"
  location = var.zone
}

# Helm talks to the cluster through its DNS endpoint. The endpoint uses a publicly
# trusted certificate, so no CA is needed, and IAM authorises the token.
provider "helm" {
  kubernetes = {
    host  = "https://${data.google_container_cluster.hub.control_plane_endpoints_config[0].dns_endpoint_config[0].endpoint}"
    token = data.google_client_config.this.access_token
  }
}
