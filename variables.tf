variable "resource_name" {
  # default     = "rg-terraform-test-001"
  type        = string
  description = "name of resource group"
}

variable "location" {
  default = "centralindia"
  type    = string
}

variable "app_service_plan_name" {
  default = "custom-plan-tf"
  type    = string
}

variable "webapp_name" {
  default = "custom-webapp-tf"
  type    = string 
}