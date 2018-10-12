resource "azurerm_resource_group" "k8s" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource azurerm_network_security_group "k8s_advanced_network" {
  name                = "${var.nsg_name}"
  location            = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
}

resource "azurerm_virtual_network" "k8s_advanced_network" {
  name                = "${var.vnet_name}"
  location            = "${azurerm_resource_group.k8s.location}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "k8s_subnet" {
  name                      = "${var.subnet_name}"
  resource_group_name       = "${azurerm_resource_group.k8s.name}"
  network_security_group_id = "${azurerm_network_security_group.k8s_advanced_network.id}"
  address_prefix            = "10.1.0.0/24"
  virtual_network_name      = "${azurerm_virtual_network.k8s_advanced_network.name}"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name       = "${var.cluster_name}"
  location   = "${azurerm_resource_group.k8s.location}"
  dns_prefix = "${var.dns_prefix}"

  resource_group_name = "${azurerm_resource_group.k8s.name}"

  linux_profile {
    admin_username = "${var.admin_user_name}"

    ssh_key {
      key_data = "${file("${var.ssh_public_key}")}"
    }
  }

  agent_pool_profile {
    name    = "agentpool"
    count   = "${var.agent_count}"
    vm_size = "Standard_DS2_v2"
    os_type = "Linux"

    # Required for advanced networking
    vnet_subnet_id = "${azurerm_subnet.k8s_subnet.id}"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  network_profile {
    network_plugin = "azure"
  }
}