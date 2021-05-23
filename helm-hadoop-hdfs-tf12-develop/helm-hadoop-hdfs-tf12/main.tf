/**
 * <img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
 * <img src="https://helm.sh/assets/images/helm-logo.svg" width="80" height="80" align="right" />
 *
 * # HDFS Terraform 12 module
 *
 * ## Overview
 *
 * This module installs aN HDFS service into a Kubernetes cluster. This forms part of the hadoop stack build.
 *
 * ## Pre-Requisites
 *
 * * A Kubernetes cluster
 *
 * ## Usage
 *
 * The full range of options are as follows. Check vault for default values.
 *
 * ```json
 * "helm-hadoop-hdfs-tf12": {
 *    "enabled": "1",
 *    "version": "0.0.27",
 *    "LogLevel": "INFO",
 *    "antiAffinity": "soft",
 *    "nameNode_limit_cpu": "2000m",
 *    "nameNode_limit_mem": "4096Mi",
 *    "nameNode_requests_cpu": "1000m",
 *    "nameNode_requests_mem": "2048Mi",
 *    "nameNode_heap_size": "12288",
 *    "pvc_nameNode_enabled": "1",
 *    "pvc_nameNode_size": "10Gi",
 *    "pvc_nameNode_storageclass": "default",
 *    "dataNode_replicas": "3",
 *    "dataNode_pdbMinAvailable": "2",
 *    "dataNode_requests_cpu": "1000m",
 *    "dataNode_requests_mem": "2048Mi",
 *    "dataNode_limit_cpu": "2000m",
 *    "dataNode_limit_mem": "4096Mi",
 *    "pvc_dataNode_enabled": "1",
 *    "pvc_dataNode_size": "10Gi",
 *    "pvc_dataNode_storageclass": "default",
 *    "httpFs_replicas": "2",
 *    "httpFs_limit_cpu": "2000m",
 *    "httpFs_limit_mem": "4096Mi",
 *    "httpFs_requests_cpu": "1000m",
 *    "httpFs_requests_mem": "2048Mi",
 *    "journalNode_limit_cpu": "1000m",
 *    "journalNode_limit_mem": "4096Mi",
 *    "journalNode_requests_cpu": "1000m",
 *    "journalNode_requests_mem": "2048Mi",
 *    "pvc_journalNode_enabled": "1",
 *    "pvc_journalNode_size": "10Gi",
 *    "pvc_journalNode_storageclass": "default",
 *    "ranger_audit_solr": "1",
 *    "ranger_audit_summary": "1",
 *    "ranger_enabled": "1",
 *    "ranger_repo": "HDFS",
 *    "enableDfsPermissions": "1",
 *    "enableHadoopAcls": "0",
 *    "webhdfs_enabled": "true",
 *    "jmx_enabled": "1",
 *    "jmx_image_tag":  "0.0.26",
 *    "dataNode_jmx_disable": "false",
 *    "dataNode_jmx_start_delay_seconds": "0",
 *    "dataNode_jmx_ssl": "false",
 *    "nameNode_jmx_disable": "false",
 *    "nameNode_jmx_start_delay_seconds": "0",
 *    "nameNode_jmx_ssl": "false",
 *    "journalNode_jmx_disable": "false",
 *    "journalNode_jmx_start_delay_seconds": "0",
 *    "journalNode_jmx_ssl": "false",
 *    "recovering_pvc": "0"
 *    }
 * ```
 *
**/

locals {
  chart_version = "0.0.49"
  kubeconfig    = "/tmp/${var.base_target}-aks-cluster-data"

  noRecoverCommand = <<COMMAND
      sleep 300
      kubectl --kubeconfig ${local.kubeconfig} cp -n ${var.namespace} ${path.module}/post-command.sh ${var.namespace}-fs-hdfs-datanode-0:/tmp
      kubectl --kubeconfig ${local.kubeconfig} exec -t ${var.namespace}-fs-hdfs-datanode-0 -n ${var.namespace} -- bash /tmp/post-command.sh
      COMMAND

  RecoverCommand = <<COMMAND
      sleep 300
      kubectl --kubeconfig ${local.kubeconfig} exec -t ${var.namespace}-fs-hdfs-namenode-0 -n ${var.namespace} -c namenode -- /bin/rm /usr/local/hadoop/hdfs/namenode/current/.hdfs-k8s-zkfc-formatted
      kubectl --kubeconfig ${local.kubeconfig} delete pod ${var.namespace}-fs-hdfs-namenode-0 -n ${var.namespace}
      kubectl --kubeconfig ${local.kubeconfig} delete pod ${var.namespace}-fs-hdfs-namenode-1 -n ${var.namespace}
      #if recovering the post-command steps have already been done
      #sleep 3600
      #kubectl --kubeconfig ${local.kubeconfig} cp -n ${var.namespace} ${path.module}/post-command.sh ${var.namespace}-fs-hdfs-datanode-0:/tmp
      #kubectl --kubeconfig ${local.kubeconfig} exec -t ${var.namespace}-fs-hdfs-datanode-0 -n ${var.namespace} -- bash /tmp/post-command.sh
      COMMAND

  command = data.external.default.result["recovering_pvc"] == "1" || data.external.default.result["recovering_pvc"] == "true" ? local.RecoverCommand : local.noRecoverCommand
}

data "external" "default" {
  program = ["bob", "vault", "key", "get", "--subscription=${var.azure_subscription_alias}", "--workspace=${terraform.workspace}", "--run-type=${var.deployment_type}", "--module-name=${var.module_name}"]
}


// Get kubeconfig for target cluster
// If zoned does not have -aks-cluster prefix
data "azurerm_kubernetes_cluster" "targetcluster" {
  name                = data.external.default.result["zoned_env"] == "0" ? "${var.base_target}-aks-cluster" : var.base_target
  resource_group_name = "${var.base_target}-aks-rg"
}

resource "local_file" "kube_config" {
  content  = data.azurerm_kubernetes_cluster.targetcluster.kube_admin_config_raw
  filename = local.kubeconfig
}

// Default module dependency declaration
resource "null_resource" "moduledep" {
  count = data.external.default.result["enabled"]

  provisioner "local-exec" {
    command = "echo ${var.module_depends_on}"
  }
}


// There is a dependency on zookeeper - require hostname
resource "helm_release" "hdfs" {
  count     = data.external.default.result["enabled"]
  name      = "${var.namespace}-fs"
  chart     = "helmci01-chartmuseum/docker-hdfs"
  namespace = var.namespace
  version   = local.chart_version
  timeout   = "2700"

  depends_on = [null_resource.moduledep]

  // If ranger is enabled will need to setup config
  // currently disabled in default values
  // requires
  // - zoopkeeper
  // - solr

  set {
    name  = "image"
    value = "globaldevopsreg11.azurecr.io/docker-hdfs:${local.chart_version}"
  }

  set {
    name  = "nameOverride"
    value = "hdfs"
  }

  set {
    name  = "dataNode.replicas"
    value = data.external.default.result["dataNode_replicas"]
  }

  set {
    name  = "httpFs.replicas"
    value = data.external.default.result["httpFs_replicas"]
  }

  set {
    name  = "dataNode.pdbMinAvailable"
    value = data.external.default.result["dataNode_pdbMinAvailable"]
  }

  set {
    name  = "antiAffinity"
    value = data.external.default.result["antiAffinity"]
  }

  set {
    name  = "nameNode.resources.requests.memory"
    value = data.external.default.result["nameNode_requests_mem"]
  }

  set {
    name  = "nameNode.resources.requests.cpu"
    value = data.external.default.result["nameNode_requests_cpu"]
  }

  set {
    name  = "nameNode.resources.limits.memory"
    value = data.external.default.result["nameNode_limit_mem"]
  }

  set {
    name  = "nameNode.resources.limits.cpu"
    value = data.external.default.result["nameNode_limit_cpu"]
  }

  set {
    name  = "nameNode.heapSize"
    value = data.external.default.result["nameNode_heap_size"] // Default: 12288
  }

  set {
    name  = "dataNode.resources.requests.memory"
    value = data.external.default.result["dataNode_requests_mem"]
  }

  set {
    name  = "dataNode.resources.requests.cpu"
    value = data.external.default.result["dataNode_requests_cpu"]
  }

  set {
    name  = "dataNode.resources.limits.memory"
    value = data.external.default.result["dataNode_limit_mem"]
  }

  set {
    name  = "dataNode.resources.limits.cpu"
    value = data.external.default.result["dataNode_limit_cpu"]
  }

  set {
    name  = "journalNode.resources.requests.memory"
    value = data.external.default.result["journalNode_requests_mem"]
  }

  set {
    name  = "journalNode.resources.requests.cpu"
    value = data.external.default.result["journalNode_requests_cpu"]
  }

  set {
    name  = "journalNode.resources.limits.memory"
    value = data.external.default.result["journalNode_limit_mem"]
  }

  set {
    name  = "journalNode.resources.limits.cpu"
    value = data.external.default.result["journalNode_limit_cpu"]
  }

  set {
    name  = "httpFs.resources.requests.memory"
    value = data.external.default.result["httpFs_requests_mem"]
  }

  set {
    name  = "httpFs.resources.requests.cpu"
    value = data.external.default.result["httpFs_requests_cpu"]
  }

  set {
    name  = "httpFs.resources.limits.memory"
    value = data.external.default.result["httpFs_limit_mem"]
  }

  set {
    name  = "httpFs.resources.limits.cpu"
    value = data.external.default.result["httpFs_limit_cpu"]
  }

  set {
    name  = "enableDfsPermissions"
    value = data.external.default.result["enableDfsPermissions"] == "0" || data.external.default.result["enableDfsPermissions"] == "false" ? "false" : "true"
  }

  set {
    name  = "enableHadoopAcls"
    value = data.external.default.result["enableHadoopAcls"] == "0" || data.external.default.result["enableHadoopAcls"] == "false" ? "false" : "true"
  }

  set {
    name  = "LogLevel"
    value = data.external.default.result["LogLevel"]
  }

  set {
    name  = "webhdfs.enabled"
    value = data.external.default.result["webhdfs_enabled"] == "0" || data.external.default.result["webhdfs_enabled"] == "false" ? "false" : "true"
  }

  set {
    name  = "persistence.nameNode.enabled"
    value = data.external.default.result["pvc_nameNode_enabled"] == "0" || data.external.default.result["pvc_nameNode_enabled"] == "false" ? "false" : "true"
  }

  set {
    name  = "persistence.nameNode.storageClass"
    value = data.external.default.result["pvc_nameNode_storageclass"]
  }

  set {
    name  = "persistence.nameNode.size"
    value = data.external.default.result["pvc_nameNode_size"]
  }

  set {
    name  = "persistence.dataNode.enabled"
    value = data.external.default.result["pvc_dataNode_enabled"] == "0" || data.external.default.result["pvc_dataNode_enabled"] == "false" ? "false" : "true"
  }

  set {
    name  = "persistence.dataNode.storageClass"
    value = data.external.default.result["pvc_dataNode_storageclass"]
  }
  set {
    name  = "persistence.dataNode.size"
    value = data.external.default.result["pvc_dataNode_size"]
  }

  set {
    name  = "persistence.journalNode.enabled"
    value = data.external.default.result["pvc_journalNode_enabled"] == "0" || data.external.default.result["pvc_journalNode_enabled"] == "false" ? "false" : "true"
  }

  set {
    name  = "persistence.journalNode.storageClass"
    value = data.external.default.result["pvc_journalNode_storageclass"]
  }

  set {
    name  = "persistence.journalNode.size"
    value = data.external.default.result["pvc_journalNode_size"]
  }

  //HA config - assume will always be required?
  set {
    name  = "highAvailability.Enabled"
    value = "true"
  }

  set {
    name  = "highAvailability.Zookeeper.Host"
    value = "${var.namespace}-zk-zookeeper-headless"
  }

  set {
    name  = "highAvailability.Zookeeper.Port"
    value = "2181"
  }

  set {
    name  = "Ranger.Enabled"
    value = data.external.default.result["ranger_enabled"] == "0" || data.external.default.result["ranger_enabled"] == "false" ? "false" : "true"
  }

  set {
    name  = "Ranger.RepositoryName"
    value = data.external.default.result["ranger_repo"]
  }

  set {
    name  = "Ranger.Host"
    value = "${var.namespace}-ra-ranger-admin"
  }

  set {
    name  = "Ranger.Auditing.Zookeeper.Host"
    value = "${var.namespace}-zk-zookeeper-headless"
  }

  set {
    name  = "Ranger.Auditing.SummaryEnabled"
    value = data.external.default.result["ranger_audit_summary"] == "0" || data.external.default.result["ranger_audit_summary"] == "false" ? "false" : "true"
  }

  set {
    name  = "Ranger.Auditing.Solr.Enabled"
    value = data.external.default.result["ranger_audit_solr"] == "0" || data.external.default.result["ranger_audit_solr"] == "false" ? "false" : "true"
  }

  set {
    name  = "Ranger.Auditing.Solr.Host"
    value = "${var.namespace}-sl-solr-svc"
  }

  set {
    name  = "jmxExporter.image.tag"
    value = data.external.default.result["jmx_image_tag"]
  }

  set {
    name  = "jmxExporter.dataNode.env.START_DELAY_SECONDS"
    value = data.external.default.result["dataNode_jmx_start_delay_seconds"]
  }

  set {
    name  = "jmxExporter.dataNode.env.SSL"
    value = data.external.default.result["dataNode_jmx_ssl"] == "0" || data.external.default.result["dataNode_jmx_ssl"] == "false" ? "false" : "true"
  }

  set {
    name  = "jmxExporter.dataNode.jmx_disable"
    value = data.external.default.result["dataNode_jmx_disable"] == "0" || data.external.default.result["dataNode_jmx_disable"] == "false" ? "false" : "true"
  }

  set {
    name  = "jmxExporter.nameNode.env.START_DELAY_SECONDS"
    value = data.external.default.result["nameNode_jmx_start_delay_seconds"]
  }

  set {
    name  = "jmxExporter.nameNode.env.SSL"
    value = data.external.default.result["nameNode_jmx_ssl"] == "0" || data.external.default.result["nameNode_jmx_ssl"] == "false" ? "false" : "true"
  }

  set {
    name  = "jmxExporter.nameNode.jmx_disable"
    value = data.external.default.result["nameNode_jmx_disable"] == "0" || data.external.default.result["nameNode_jmx_disable"] == "false" ? "false" : "true"
  }

  set {
    name  = "jmxExporter.journalNode.env.START_DELAY_SECONDS"
    value = data.external.default.result["journalNode_jmx_start_delay_seconds"]
  }

  set {
    name  = "jmxExporter.journalNode.env.SSL"
    value = data.external.default.result["journalNode_jmx_ssl"] == "0" || data.external.default.result["journalNode_jmx_ssl"] == "false" ? "false" : "true"
  }

  set {
    name  = "jmxExporter.journalNode.jmx_disable"
    value = data.external.default.result["journalNode_jmx_disable"] == "0" || data.external.default.result["journalNode_jmx_disable"] == "false" ? "false" : "true"
  }

  provisioner "local-exec" {
    command = local.command
  }

}
