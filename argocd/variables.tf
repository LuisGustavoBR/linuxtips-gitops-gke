variable "project_id" {
  description = "GCP project. Set by the pipeline as TF_VAR_project_id (GitHub variable GCP_PROJECT_ID)."
  type        = string
}

variable "region" {
  description = "Default region of the Google provider."
  type        = string
}

variable "zone" {
  description = "Zone of the hub cluster."
  type        = string
}

variable "name_prefix" {
  description = "Prefix of every resource name. Must match the one used in network/ and gke/."
  type        = string
}

variable "argocd_chart_version" {
  description = "Version of the argo-cd Helm chart (argo-helm). Per environment, so an upgrade can be tested in one environment before the others."
  type        = string
}

variable "argocd_apps_chart_version" {
  description = "Version of the argocd-apps Helm chart (argo-helm), which creates the root Application."
  type        = string
}

variable "gitops_repo_url" {
  description = "HTTPS URL of the gitops repository Argo CD watches."
  type        = string
}

variable "gitops_repo_revision" {
  description = "Branch (or tag) of the gitops repository Argo CD follows."
  type        = string
}
