terraform {
    required_version = ">=0.13"
    
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.26"
        }
    }
}

provider "azurerm" {
    skip_provider_registration = true
    features {

    }
}


resource "azurerm_resource_group" "atividade1" {
    name = "atividade1terraform"
    location = "australiaeast"    
}

resource "azurerm_virtual_network" "vnet-atividade1" {
  name                = "vnet-ativ"
  location            = azurerm_resource_group.atividade1.location
  resource_group_name = azurerm_resource_group.atividade1.name
  address_space       = ["10.0.0.0/16"]

    tags = {
        environment = "Production"
        faculdade =  "Impacta"
        categoria = "Atividade"
    }
}  

resource "azurerm_subnet" "sub-atividade1" {
  name                 = "sub-ativ"
  resource_group_name  = azurerm_resource_group.atividade1.name
  virtual_network_name = azurerm_virtual_network.vnet-atividade1.name
  address_prefixes     = ["10.0.1.0/24"]
} 

resource "azurerm_public_ip" "ip-atividade1" {
  name                = "ip-ativ"
  resource_group_name = azurerm_resource_group.atividade1.name
  location            = azurerm_resource_group.atividade1.location
  allocation_method   = "Static"

    tags = {
        environment = "Production"
    }
}

resource "azurerm_network_security_group" "nsg-atividade1" {
  name                = "nsg-ativ"
  location            = azurerm_resource_group.atividade1.location
  resource_group_name = azurerm_resource_group.atividade1.name

  security_rule {
    name                       = "ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "web"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    tags = {
        environment = "Production"
    }
}

resource "azurerm_network_interface" "nic-atividade1" {
    name = "nic-ativ"
    location = azurerm_resource_group.atividade1.location
    resource_group_name = azurerm_resource_group.atividade1.name  



 ip_configuration {
    name                          = "ip-ativ-nic"
    subnet_id                     = azurerm_subnet.sub-atividade1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.ip-atividade1.id
  }
} 

resource "azurerm_virtual_machine" "vm-atividade1" {
  name                  = "vm-ativ"
  location              = azurerm_resource_group.atividade1.location
  resource_group_name   = azurerm_resource_group.atividade1.name
  network_interface_ids = [azurerm_network_interface.nic-atividade1.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminUsername"
    admin_password = "admin@123"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_subnet_network_security_group_association" "nic-nsg-atividade1" {
  subnet_id                 = azurerm_subnet.sub-atividade1.id
  network_security_group_id = azurerm_network_security_group.nsg-atividade1.id
}

data "azurerm_public_ip" "ipc-atividade1"{
  name = azurerm_public_ip.ip-atividade1.name
  resource_group_name = azurerm_resource_group.atividade1.name
}

resource "null_resource" "install-apache2" {
  connection {
    type = "ssh"
    host = data.azurerm_public_ip.ipc-atividade1.ip_address
    user = "adminUsername"
    password = "admin@123"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y apache2",
    ]
  }
  depends_on = [
    azurerm_virtual_machine.vm-atividade1
  ]
}
# montar estrutura de rede
# montar VM e ligar com estrutura de rede
# criar variavel para o IP
# criar null_resource para realziar a conex??o e instala????o do apache
# criar depends on para realizar os comandos ap??s a subida da vm
# utilizar o terraform init para baixar o plugin do resource null
# ip 20.224.104.158


# comandos
# terraform validate
# terraform plan 
# terraform apply
