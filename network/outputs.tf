output "network" {
  description = "Name of the VPC."
  value       = google_compute_network.this.name
}

output "hub_subnet" {
  description = "Name of the hub subnet."
  value       = google_compute_subnetwork.hub.name
}

output "hub_secondary_ranges" {
  description = "Secondary range names the hub cluster uses for Pods and Services."
  value = {
    pods     = google_compute_subnetwork.hub.secondary_ip_range[0].range_name
    services = google_compute_subnetwork.hub.secondary_ip_range[1].range_name
  }
}
