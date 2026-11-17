# The root Application: the only one created outside Git. It watches the applications/
# folder of the gitops repository: every Application file committed there is created by Argo CD.
#
# The argocd-apps chart is used (instead of a raw Kubernetes manifest) because the
# Application type only exists after Argo CD is installed, in the same apply.
resource "helm_release" "root" {
  name      = "argocd-root"
  namespace = helm_release.argocd.namespace

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = var.argocd_apps_chart_version

  values = [yamlencode({
    applications = {
      root = {
        namespace = helm_release.argocd.namespace
        project   = "default"
        source = {
          repoURL        = var.gitops_repo_url
          targetRevision = var.gitops_repo_revision
          path           = "applications"
        }
        destination = {
          server    = "https://kubernetes.default.svc"
          namespace = helm_release.argocd.namespace
        }
        syncPolicy = {
          automated = {
            prune    = true
            selfHeal = true
          }
        }
      }
    }
  })]
}
