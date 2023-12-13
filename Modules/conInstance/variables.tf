variable "resource_name" {
  type = string
}

variable "location" {
  type = string
}

variable "group_name" {
  default = "elastic-container"
}

variable "elastic_container_name" {
  default = "elastic-container"
}

variable "elastic_image_name" {
  default = "amitgujar/elastic:latest"
}

variable "elastic_cpu_cores" {
  default = 4
}

variable "elastic_ram_in_gb" {
  default = 12
}

variable "elastic_port" {
  default = 9200
}

variable "neo_container_name" {
  default = "neo-container"
}

variable "neo_image_name" {
  default = "amitgujar/neo4j:latest"
}

variable "neo_cpu_cores" {
  default = 3
}

variable "neo_ram_in_gb" {
  default = 7
}

variable "share_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_key" {
  type      = string
  sensitive = true
}
