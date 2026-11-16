variable "project_id" {
  description = "GCP project. Set by the pipeline as TF_VAR_project_id (GitHub variable GCP_PROJECT_ID)."
  type        = string
}

variable "region" {
  description = "Region of the subnet, router and NAT."
  type        = string
}

variable "name_prefix" {
  description = "Prefix of every resource name."
  type        = string
}

variable "nodes_cidr" {
  description = "Primary range of the subnet: one IP per node."
  type        = string
}

variable "services_cidr" {
  description = "Secondary range for Kubernetes Services (ClusterIPs)."
  type        = string
}

variable "pods_cidr" {
  description = "Secondary range for Pods: every Pod gets a real VPC IP from here."
  type        = string
}
