locals {
  prefix    = "jbt-${var.environment}-${var.tags["location"]}"
  sa_prefix = "jbt${var.environment}${var.tags["location"]}"
  location  = var.tags["location"]
  tags      = merge(var.tags)
}

data "azurerm_client_config" "config" {}

resource "azurerm_resource_group" "rg_network" {
  name     = "rg-${local.prefix}-${var.resource_groups["rg_network"]}"
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "rg_mgmt" {
  name     = "rg-${local.prefix}-${var.resource_groups["rg_mgmt"]}"
  location = local.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.prefix}-${var.vnet_name}"
  resource_group_name = azurerm_resource_group.rg_network.name
  location            = azurerm_resource_group.rg_network.location
  tags                = local.tags
  address_space       = var.vnet_cidr

  dynamic "subnet" {
    for_each = var.subnets

    content {
      name           = subnet.value.subnet_name
      address_prefix = subnet.value.prefix
    }
  }
}

resource "azurerm_storage_account" "sa_logs" {
  name                      = "sa${local.sa_prefix}logs"
  resource_group_name       = azurerm_resource_group.rg_mgmt.name
  location                  = azurerm_resource_group.rg_mgmt.location
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  enable_https_traffic_only = true
  allow_blob_public_access  = false
  min_tls_version           = "TLS1_2"
  tags                      = local.tags
}

resource "azurerm_key_vault" "kv_mgmt" {
  name                = "kv-${local.prefix}"
  resource_group_name = azurerm_resource_group.rg_mgmt.name
  location            = azurerm_resource_group.rg_mgmt.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.config.tenant_id
  tags                = local.tags
}
