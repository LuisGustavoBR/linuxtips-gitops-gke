data "google_compute_network" "this" {
  name = "${var.name_prefix}-vpc"
}

data "google_compute_subnetwork" "hub" {
  name   = "${var.name_prefix}-hub"
  region = var.region
}
