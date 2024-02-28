resource "azurerm_network_security_group" "sg" {
  name                = "${local.hostname}_sg"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
}

resource "azurerm_network_security_rule" "http" {
  priority                    = 101
  name                        = "http-in"
  source_address_prefix       = "*"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  destination_address_prefix  = azurerm_network_interface.nic.private_ip_address
  resource_group_name         = azurerm_resource_group.vm.name
  network_security_group_name = azurerm_network_security_group.sg.name
}

resource "azurerm_network_security_rule" "https" {
  priority                    = 102
  name                        = "https-in"
  source_address_prefix       = "*"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  destination_address_prefix  = azurerm_network_interface.nic.private_ip_address
  resource_group_name         = azurerm_resource_group.vm.name
  network_security_group_name = azurerm_network_security_group.sg.name
}

resource "azurerm_network_security_rule" "ssh_src1" {
  priority                    = 201
  name                        = "ssh_from_${var.ssh_src1name}"
  source_address_prefix       = var.ssh_src1
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  destination_address_prefix  = azurerm_network_interface.nic.private_ip_address
  resource_group_name         = azurerm_resource_group.vm.name
  network_security_group_name = azurerm_network_security_group.sg.name
}

resource "azurerm_network_interface_security_group_association" "nic_sg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.sg.id
}