variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "app_image_name" {
  description = "Name of app image"
  type        = string
}

variable "app_image_tag" {
  description = "Tag of app image"
  type        = string
}

variable "app" {
  description = "Name of app"
  type        = string
  default     = "az204lib"
}

variable "acr_name" {
  default = "az204lib"
}

variable "acr_sku" {
  default = "Basic"
}
