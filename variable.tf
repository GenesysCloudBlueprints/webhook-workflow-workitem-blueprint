variable "environment_name" {
  type        = string
  description = "The affix that will be added to resources to determine its environment."
  default     = "Dev"
}

variable "genesys_division_name" {
  description = "The name of the Genesys Cloud division where you want to deploy the bot and flow."
  type        = string
  default     = "Default"
}

variable "client_id" {
  type        = string
  description = "Genesys Cloud OAuth Client ID"
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "Genesys Cloud OAuth Client Secret"
  sensitive   = true
}
