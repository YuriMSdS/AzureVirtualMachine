provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "main" {
  name = "main-project-resources"
  location = "Brazil South"
}

resource "azure_virtual_network" "project-network" {
  name = "local-network"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "subnet" {
  name = "subnet1"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pubIP" {
  name = "pubIP"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "NIC_1" {
  name = "nic-1"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_public_ip.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pubIP.id
  }
}

resource "azurerm_virtual_machine" "vms" {
  name = "vm1"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.NIC_1.id]
  vm_size = "Standart_DS1_v2"

  storage_os_disk {
    name = "os-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standart_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

  os_profile {
    computer_name = "mainVM"
    admin_username = "AdmUser" 
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path = "/home/AdmUser/ .ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")
    }
  }
}