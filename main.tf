terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tf-state-rg"
    storage_account_name = "devstacktfstate2026"
    container_name       = "tfstate"
    key                  = "production.infrastructure.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# Core Resource Group
resource "azurerm_resource_group" "infra_rg" {
  name     = "rg-devstack-${var.environment}"
  location = var.location
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "DevStackHub"
  }
}

# Enterprise Virtual Network
resource "azurerm_virtual_network" "core_vnet" {
  name                = "vnet-devstack-${var.environment}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.infra_rg.location
  resource_group_name = azurerm_resource_group.infra_rg.name

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Web Tier Subnet
resource "azurerm_subnet" "web_subnet" {
  name                 = "snet-web-${var.environment}"
  resource_group_name  = azurerm_resource_group.infra_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = [var.subnet_prefixes["web"]]
}

# Network Security Group (NSG) Hardening
resource "azurerm_network_security_group" "web_nsg" {
  name                = "nsg-web-${var.environment}"
  location            = azurerm_resource_group.infra_rg.location
  resource_group_name = azurerm_resource_group.infra_rg.name

  security_rule {
    name                       = "AllowHTTPSInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPInbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Subnet-to-NSG Association
resource "azurerm_subnet_network_security_group_association" "web_nsg_assoc" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}
