resource "azurerm_eventgrid_system_topic" "eventgrid_system_topic" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags

  source_arm_resource_id = var.source_arm_resource_id
  topic_type             = var.topic_type

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }
}
