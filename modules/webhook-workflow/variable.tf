variable "name" {
  type        = string
  description = "Webhook Integration Name"
}

variable "division" {
  type        = string
  description = "Name of the Division where the flow will be associated"
}

variable "data_action_category" {
  type        = string
  description = "Name of the Category where the Data Action is associated"
}

variable "workitem_data_action_name" {
  type        = string
  description = "Name of the Data Action that will create the workitem"
}

variable "worktype_id" {
  type        = string
  description = "ID of the worktype that will be associated to the created workitem"
}

