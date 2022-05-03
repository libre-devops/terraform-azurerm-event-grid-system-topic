output "eventgrid_id" {
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.id
  description = "Event Grid ID"
}

output "eventgrid_identity" {
  description = "The Event grid identity block"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.identity
}

output "eventgrid_name" {
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.name
  description = "Event Grid name"
}

output "metric_arm_resource_id" {
  description = "The Event grid metric arm resource id"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.metric_arm_resource_id
}

output "source_arm_metric_id" {
  description = "The Event grid source arm metric id"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.source_arm_resource_id
}
