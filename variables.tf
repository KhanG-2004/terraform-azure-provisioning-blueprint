variable "environment" {
  type        = string
  description = "Target deployment environment"
  default     = "production"
}

variable "location" {
  type        = string
  description = "Azure region for all provisioned resources"
  default     = "eastus"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "CIDR block for the enterprise virtual network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type        = map(string)
  description = "CIDR allocations for tier-isolated subnets"
  default = {
    web = "10.0.1.0/24"
    app = "10.0.2.0/24"
    db  = "10.0.3.0/24"
  }
}
