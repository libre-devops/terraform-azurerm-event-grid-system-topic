variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine."
  type        = string
  default     = ""
}

variable "location" {
  description = "The location for this resource to be put in"
  type        = string
}

variable "name" {
  type        = string
  description = "The name of the event grid"
}

variable "rg_name" {
  description = "The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists"
  type        = string
}

variable "source_arm_resource_id" {
  type        = string
  description = "The name of the Resource Group where the Event Grid System Topic should exist, e.g. the resource ID its supposed to check"
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "topic_type" {
  type        = string
  description = "The topic type which the event grid is looking at events for"
}
