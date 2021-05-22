resource "time_sleep" "wait_120_seconds" {
  depends_on      = [module.eks]
  create_duration = "120s"
}

resource "helm_release" "cluster_autoscaler" {
  depends_on = [time_sleep.wait_120_seconds]
  name       = "cluster-autoscaler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = "${var.MAIN}-${var.EKS_CLUSTER_NAME}"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }
  set {
    name  = "rbac.create"
    value = "true"
  }
}

resource "helm_release" "metrics-server" {
  depends_on = [helm_release.cluster_autoscaler]
  name       = "metrics-server"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart      = "metrics-server"
  namespace  = "kube-system"
}
