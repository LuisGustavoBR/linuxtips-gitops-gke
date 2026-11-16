resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  values = [file("${path.module}/values/argocd.yaml")]

  # Wait until every Argo CD Pod is ready; if the install fails, roll it back.
  wait            = true
  timeout         = 600
  atomic          = true
  cleanup_on_fail = true
}
