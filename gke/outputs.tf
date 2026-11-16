output "cluster_name" {
  description = "Name of the hub cluster."
  value       = google_container_cluster.hub.name
}

output "cluster_location" {
  description = "Zone of the hub cluster."
  value       = google_container_cluster.hub.location
}

output "get_credentials" {
  description = "Command to configure kubectl for this cluster."
  value       = "gcloud container clusters get-credentials ${google_container_cluster.hub.name} --location ${google_container_cluster.hub.location} --project ${var.project_id} --dns-endpoint"
}
