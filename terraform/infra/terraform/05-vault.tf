resource "kubernetes_namespace" "secrets" {
  count      = var.enable_consul_and_vault ? 1 : 0
  depends_on = [time_sleep.wait_120_seconds]
  metadata {
    annotations = {
      name = "secrets"
    }

    labels = {
      purpose = "consul"
    }

    name = "secrets"
  }
}

resource "helm_release" "consul" {
  count      = var.enable_consul_and_vault ? 1 : 0
  depends_on = [kubernetes_namespace.secrets]
  name       = "${var.MAIN}-consul"
  chart      = "${path.module}/../helm/consul-helm"
  namespace  = "secrets"

  set {
    name  = "global.name"
    value = "consul"
  }

  # set {
  #   name  = "server.replicas"
  #   value = var.replicas
  # }

  # set {
  #   name  = "server.bootstrapExpect"
  #   value = var.replicas
  # }
}

resource "helm_release" "vault" {
  count      = var.enable_consul_and_vault ? 1 : 0
  depends_on = [helm_release.consul]
  name       = "${var.MAIN}-vault"
  chart      = "${path.module}/../helm/vault-helm"
  namespace  = "secrets"

  set {
    name  = "server.ha.enabled"
    value = "true"
  }
}