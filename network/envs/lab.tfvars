region      = "us-central1"
name_prefix = "gitops"

nodes_cidr    = "10.30.0.0/24"  # 256 node IPs
services_cidr = "10.30.16.0/20" # 4,096 Service IPs
pods_cidr     = "10.30.32.0/19" # 8,192 Pod IPs
