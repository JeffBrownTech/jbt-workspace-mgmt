environment         = "prod"
resource_group_name = "network"
resource_groups = {
  "rg_network" = "network"
  "rg_mgmt"    = "mgmt"
}
vnet_name = "mgmt"
vnet_cidr = ["10.10.0.0/16"]
subnets = [
  {
    subnet_name = "identity"
    prefix      = "10.10.5.0/24"
  },
  {
    subnet_name = "app"
    prefix      = "10.10.8.0/24"
  },
  {
    subnet_name = "servers"
    prefix      = "10.10.12.0/24"
  }
]
tags = {
  "location" = "westus2"
  "org"      = "jbt"
  "env"      = "prod"
}
