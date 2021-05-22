// Add locals to compute our parameters and variables.
locals {
  vaultPathDocker    = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "secret/${var.deployment_type}/${terraform.workspace}/azure/docker" : "secret/${var.deployment_type}/${var.azure_subscription_alias}/${terraform.workspace}/azure/docker"
  IdentifierUri      = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "https://${terraform.workspace}rootSp" : "https://${terraform.workspace}${var.azure_subscription_alias}rootSp"
  windowsInterpreter = "PowerShell"
  linuxInterpreter   = "/bin/bash"
  linuxOpts          = "-c"

  windowsOpts = "-NoProfile"

  commandOpts   = var.os_type == "windows" ? local.windowsOpts : local.linuxOpts
  linuxTemplate = <<COMMAND
#!/bin/bash
az vm list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -o json --query '[].name' | jq '. | reduce ( tostream | select(length==2) | .[0] |= [join(".")] ) as [$p,$v] ({}; setpath($p; $v))'
  
COMMAND

  vmlinuxTemplate = <<COMMAND
    #!/bin/bash
    az vmss list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -o json --query '[].name' | jq '. | reduce ( tostream | select(length==2) | .[0] |= [join(".")] ) as [$p,$v] ({}; setpath($p; $v))'
    COMMAND

  vmsslinuxTemplate = <<COMMAND
    #!/bin/bash
    az vmss list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -o json --query '[].name' | jq '. | reduce ( tostream | select(length==2) | .[0] |= [join(".")] ) as [$p,$v] ({}; setpath($p; $v))'
    COMMAND

  vmsswindowsTemplate = <<COMMAND
    az vmss list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -o json --query '[].name' | jq '.|to_entries|map({"key": .key| tostring, "value":.value})| from_entries'
    COMMAND


  vmwindowsTemplate = <<COMMAND
az vm list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -o json --query '[].name' | jq '.|to_entries|map({"key": .key| tostring, "value":.value})| from_entries'
  
COMMAND


  windowsAaadcommand = <<COMMAND
  $cmdOutput = az ad app list --filter "displayName eq '${terraform.workspace}AKSAAdClient'" --query "[?displayName=='${terraform.workspace}AKSAAdClient'].displayName"
  if ( $cmdOutput -eq '[]' ) {
      az ad app create --display-name ""${terraform.workspace}AKSAAdClient"" --native-app | jq -r .appId ;
  } else {
      az ad app list --filter "displayName eq '${terraform.workspace}AKSAAdClient'" --display-name ""${terraform.workspace}AKSAAdClient"" | jq -r .[-1].appId ; 
  }
  
COMMAND


  linuxAaadcommand = <<COMMAND
  if [[ $(az ad app list | grep  -wq "${terraform.workspace}AKSAAdClient")$? -eq 0 ]] ; then 
    az ad app list --display-name"${terraform.workspace}AKSAAdClient" | jq -r .[-1].appId ; 
  else 
    az ad app create --display-name "${terraform.workspace}AKSAAdClient" --native-app | jq -r .appId ;
  fi
  
COMMAND

  templatePath      = var.os_type == "windows" ? replace("${path.module}/get_vms.ps1", "/", "\\") : "${path.module}/get_vms.ps1"
  shellInterpereter = var.os_type == "windows" ? local.windowsInterpreter : local.linuxInterpreter
  templatecommand   = var.os_type == "windows" ? "echo ok" : "chmod 750 ${path.module}/get_vms.ps1"
  vmltemplatefile   = local.auto_scaling_vm_type == "VirtualMachineScaleSets" ? local.vmsslinuxTemplate : local.vmlinuxTemplate
  vmwtemplatefile   = local.auto_scaling_vm_type == "VirtualMachineScaleSets" ? local.vmsswindowsTemplate : local.vmwindowsTemplate
  templatefile      = var.os_type == "windows" ? local.vmwtemplatefile : local.vmltemplatefile
}
