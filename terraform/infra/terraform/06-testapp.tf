variable "testapp-ecr" {}
variable "testapp-route53-hosts" {}
variable "testapp-route53-hostnames" {}
variable "testapp-crt-path" {}
variable "testapp-key-path" {}

data "vault_generic_secret" "testapp-tls-cert" {
    count = "${length(var.testapp-crt-path)}"
    path = "${var.testapp-crt-path[count.index]}"
}
data "vault_generic_secret" "testapp-tls-key" {
    count = "${length(var.testapp-key-path)}"
    path = "${var.testapp-key-path[count.index]}"
}

data "aws_route53_zone" "main" {
  name         = "${var.route53-zone}"
  private_zone = false
}

resource "aws_ecr_repository" "testapp-repo" {
  name                 = var.testapp-ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "kubernetes_secret" "testapp-war-ssl" {
  depends_on = [helm_release.ingress-nginx-controller]
  count = length(var.testapp-key-path)
  metadata {
    name      = var.testapp-route53-hosts[count.index]
    namespace = "default"
  }

  data = {
    "tls.crt" = "${data.vault_generic_secret.testapp-tls-cert[count.index].data["-value"]}"
    "tls.key" = "${data.vault_generic_secret.testapp-tls-key[count.index].data["-value"]}"
  }
  type = "kubernetes.io/tls"
}

resource "helm_release" "testapp-helm" {
  depends_on = [kubernetes_secret.testapp-war-ssl]
  name       = "testapp"
  chart      = "../helm/testapp-helm"
  values = [
    "${file("../helm/testapp-helm/values.yaml")}"
  ]
  set {
    name  = "ingress.hosts"
    value = "{${join(",", var.testapp-route53-hostnames)}}"
  }
  set {
    name  = "ingress.tls_secret"
    value = "{${join(",", var.testapp-route53-hosts)}}"
  }
}

resource "aws_route53_record" "testapp-domain-map" {
  count = length(var.testapp-route53-hosts)
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.testapp-route53-hosts[count.index]
  type    = "CNAME"
  ttl     = "60"
  records = ["${data.kubernetes_service.get-nginx-ingress-controller-svc.load_balancer_ingress.0.hostname}"]
}