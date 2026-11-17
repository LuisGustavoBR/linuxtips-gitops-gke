region      = "us-central1"
zone        = "us-central1-a"
name_prefix = "gitops"

argocd_chart_version      = "10.18.0" # Argo CD v3.6.1
argocd_apps_chart_version = "2.0.8"

gitops_repo_url      = "https://github.com/LuisGustavoBR/linuxtips-gitops-argocd.git"
gitops_repo_revision = "main"
