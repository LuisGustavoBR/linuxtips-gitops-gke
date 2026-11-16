variable "project_id" {
  description = "GCP project. Set by the pipeline as TF_VAR_project_id (GitHub variable GCP_PROJECT_ID)."
  type        = string
}

variable "region" {
  description = "Region of the network the cluster uses."
  type        = string
}

variable "zone" {
  description = "Zone of the cluster (zonal cluster: its fee is covered by the GKE free tier credit)."
  type        = string
}

variable "name_prefix" {
  description = "Prefix of every resource name. Must match the one used in network/."
  type        = string
}

variable "system_machine_type" {
  description = "Machine type of the on-demand system pool (runs Argo CD)."
  type        = string
}

variable "apps_machine_type" {
  description = "Machine type of the Spot apps pool."
  type        = string
}

variable "apps_min_nodes" {
  description = "Minimum number of nodes in the apps pool."
  type        = number
}

variable "apps_max_nodes" {
  description = "Maximum number of nodes in the apps pool."
  type        = number
}
