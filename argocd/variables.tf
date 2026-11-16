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
