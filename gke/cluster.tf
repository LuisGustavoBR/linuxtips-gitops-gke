resource "google_container_cluster" "hub" {
  name     = "${var.name_prefix}-hub"
  location = var.zone

  # Lab cluster: destroyed and recreated often.
  deletion_protection = false

  network         = data.google_compute_network.this.self_link
  subnetwork      = data.google_compute_subnetwork.hub.self_link
  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "hub-pods"
    services_secondary_range_name = "hub-services"
  }

  datapath_provider = "ADVANCED_DATAPATH"

  private_cluster_config {
    enable_private_nodes = true
  }

  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = true
    }
    ip_endpoints_config {
      enabled = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  release_channel {
    channel = "REGULAR"
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = false
    }
  }

  resource_labels = {
    project    = var.name_prefix
    managed-by = "terraform"
  }
}
