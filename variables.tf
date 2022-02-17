variable "environment" {
  type = string
  validation {
    condition     = can(regex("^(prod|dev|test)$", var.environment))
    error_message = "Environment can only be prod, dev, or test."
  }
}

variable "resource_group_name" {
  type = string
}

variable "resource_groups" {
  type = map(any)
}

variable "vnet_name" {
    type = string
}

variable "vnet_cidr" {
    type = list(string)
}

variable "subnets" {
    type = list(any)
}

variable "tags" {
    type = map(string)
}