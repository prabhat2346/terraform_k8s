
# Payload
# ```
# "azurerm-ad-ns-rolebindings-tf12": {
#     "group_id": "group_object_ids,group_object_ids",
#     "apigroup": "extensions,apps,batch",
#     "resources": "pods,pod/logs",
#     "verbs": "create,list",        
#     "version": ""
# }
# ```


// Get the default config in vault
data "external" "default" {
  program = ["bob", "vault", "key", "get", "--subscription=${var.azure_subscription_alias}", "--workspace=${terraform.workspace}", "--run-type=${var.deployment_type}", "--module-name=${var.module_name}"]
}

// Dummy resource used for dependencies
resource "null_resource" "moduledep" {
  count = data.external.default.result["enabled"]

  provisioner "local-exec" {
    command = "echo ${var.module_depends_on}"
  }
}

// Setup local variables
locals {
  apigroup  = data.external.default.result["apigroup"]
  resources = data.external.default.result["resources"]
  verbs     = data.external.default.result["verbs"]
  groups = split(",", data.external.default.result["group_id"])
}


// Cluster Read-only access
resource "azurerm_role_assignment" "aksro" {
  count                = length(local.groups)
  scope                = "/subscriptions/${var.az_subscription_id}/resourceGroups/${var.aksRG}"
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = element(local.groups, count.index)

  depends_on = [null_resource.moduledep]
}


//Create role
resource "kubernetes_role" "ro" {
  count = data.external.default.result["enabled"]
  metadata {
    name = "${terraform.workspace}-role"
    namespace = terraform.workspace
  }
  rule {
    api_groups = split(",", local.apigroup)
    resources  = split(",", local.resources)
    verbs      = split(",", local.verbs)
  }
}



//Create rolebinding
resource "kubernetes_role_binding" "rb" {
  count = data.external.default.result["enabled"]
  metadata {
    name = "${terraform.workspace}-role-binding"
    namespace = terraform.workspace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "${terraform.workspace}-role"
  }
  dynamic "subject" {
    for_each = local.groups
    content {
      kind      = "Group"
      name      = subject.value
      api_group = "rbac.authorization.k8s.io"
      namespace = terraform.workspace
    }
  }
}
