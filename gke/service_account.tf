# Dedicated identity for the nodes. Without it, GKE would use the Compute Engine
# default service account, which has the Editor role on the whole project.
resource "google_service_account" "nodes" {
  account_id   = "${var.name_prefix}-hub-nodes"
  display_name = "GKE nodes of ${var.name_prefix}-hub"
}

resource "google_project_iam_member" "nodes" {
  for_each = toset([
    "roles/container.defaultNodeServiceAccount",
    "roles/artifactregistry.reader",
  ])

  project = var.project_id
  role    = each.value
  member  = google_service_account.nodes.member
}
