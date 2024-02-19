```hcl
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
```
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_system_topic.eventgrid_system_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for this resource to be put in | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the event grid | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists | `string` | n/a | yes |
| <a name="input_source_arm_resource_id"></a> [source\_arm\_resource\_id](#input\_source\_arm\_resource\_id) | The name of the Resource Group where the Event Grid System Topic should exist, e.g. the resource ID its supposed to check | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | n/a | yes |
| <a name="input_topic_type"></a> [topic\_type](#input\_topic\_type) | The topic type which the event grid is looking at events for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_grid_principal_id"></a> [event\_grid\_principal\_id](#output\_event\_grid\_principal\_id) | Client ID of system assigned managed identity if created |
| <a name="output_eventgrid_id"></a> [eventgrid\_id](#output\_eventgrid\_id) | Event Grid ID |
| <a name="output_eventgrid_identity"></a> [eventgrid\_identity](#output\_eventgrid\_identity) | The Event grid identity block |
| <a name="output_eventgrid_name"></a> [eventgrid\_name](#output\_eventgrid\_name) | Event Grid name |
| <a name="output_metric_arm_resource_id"></a> [metric\_arm\_resource\_id](#output\_metric\_arm\_resource\_id) | The Event grid metric arm resource id |
| <a name="output_source_arm_metric_id"></a> [source\_arm\_metric\_id](#output\_source\_arm\_metric\_id) | The Event grid source arm metric id |
