output "chart_version" {
  description = "Installed argo-cd chart version."
  value       = helm_release.argocd.version
}
