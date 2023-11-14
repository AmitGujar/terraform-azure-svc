variable "resource_name" {
  # default     = "rg-terraform-test-001"
  type        = string
  description = "name of resource group"
}

variable "location" {
  default = "centralindia"
  type    = string
}