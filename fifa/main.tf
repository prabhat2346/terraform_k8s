resource "azurerm_resource_group" "example" {
 name     = "example-training"
 location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
 name                = var.vnet_name
 address_space       = var.address_space
 location            = azurerm_resource_group.example.location
 resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
name                 = var.subnet_name
resource_group_name = azurerm_resource_group.example.name
virtual_network_name = azurerm_virtual_network.example.name
address_prefixes     = var.address_prefixes
enforce_private_link_endpoint_network_policies = true
}
resource "azurerm_lb" "example" {
name                = var.lb_name
location            = azurerm_resource_group.example.location
resource_group_name = azurerm_resource_group.example.name

frontend_ip_configuration {
          name                 = "PrivateIPAddress.test"
          subnet_id            = azurerm_subnet.example.id
          private_ip_address   = var.private_ip_address
          private_ip_address_allocation = "Static"
      }
}

resource "azurerm_lb_probe" "example" {
 resource_group_name = azurerm_resource_group.example.name
 loadbalancer_id     = azurerm_lb.example.id
 name                = "http-probe"
 protocol            = "Http"
 request_path        = "/health"
 port                = 8080
}
resource "azurerm_virtual_machine_scale_set" "example" {
  name                = var.vmss_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = azurerm_lb_probe.example.id

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "myadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/myadmin/.ssh/authorized_keys"
      key_data = file("~/.ssh/demo_key.pub")
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = azurerm_subnet.example.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }

  tags = {
    environment = "staging"
  }
}