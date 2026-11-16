resource "google_compute_network" "this" {
  name                    = "${var.name_prefix}-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "hub" {
  name    = "${var.name_prefix}-hub"
  region  = var.region
  network = google_compute_network.this.id

  ip_cidr_range = var.nodes_cidr

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "hub-pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "hub-services"
    ip_cidr_range = var.services_cidr
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.1
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
