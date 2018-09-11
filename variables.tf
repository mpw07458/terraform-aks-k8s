variable "client_id" {
  default = "6484bac5-b63d-4385-bf53-44ee8144ea83"
}

variable "client_secret" {
  default = "a030758c-ca55-44f8-9585-412fddbf0196"
}

variable "agent_count" {
  default = 3
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "tfk8stest"
}

variable cluster_name {
  default = "tfk8stest"
}

variable resource_group_name {
  default = "tfs-rg"
}

variable location {
  default = "East US"
}
