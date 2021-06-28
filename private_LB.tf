resource "azurerm_resource_group" "vmss" {
name = var.resource_group_name
location = var.location
tags = var.tags
}

resource "random_string" "fqdn" {
length = 6
special = false
upper = false
number = false
}

resource "azurerm_virtual_network" "vmss" {
name = var.vnet_name
address_space = ["10.0.0.0/16"]
location = var.location
resource_group_name = azurerm_resource_group.vmss.name
tags = var.tags
}

resource "azurerm_subnet" "vmss" {
name = var.vmss_name
resource_group_name = azurerm_resource_group.vmss.name
virtual_network_name = azurerm_virtual_network.vmss.name
address_prefix = "10.0.2.0/24"
}

# resource "azurerm_public_ip" "vmss" {
#name = "vmss-public-ip"
#location = var.location
#resource_group_name = azurerm_resource_group.vmss.name
#allocation_method = "Static"
#domain_name_label = random_string.fqdn.result
#tags = var.tags
#}


resource "azurerm_lb" "vmss" {
name = "vmss-lb"
location = var.location
resource_group_name = azurerm_resource_group.vmss.name

frontend_ip_configuration {
name = "PrivateIPAddress.vmss-lb"
subnet_id = azurerm_subnet.vmss.id
private_ip_address = "10.0.2.250"
private_ip_address_allocation = "Static"
}
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
resource_group_name = azurerm_resource_group.vmss.name
loadbalancer_id = azurerm_lb.vmss.id
name = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss" {
resource_group_name = azurerm_resource_group.vmss.name
loadbalancer_id = azurerm_lb.vmss.id
name = "ssh-running-probe"
port = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
resource_group_name = azurerm_resource_group.vmss.name
loadbalancer_id = azurerm_lb.vmss.id
name = "http"
protocol = "Tcp"
frontend_port = var.application_port
backend_port = var.application_port
backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id
frontend_ip_configuration_name = "PrivateIPAddress.vmss-lb"
probe_id = azurerm_lb_probe.vmss.id
}
