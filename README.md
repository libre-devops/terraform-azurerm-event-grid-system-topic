```hcl
// This module does not consider for CMKs and allows the users to manually set bypasses
#checkov:skip=CKV2_AZURE_1:CMKs are not considered in this module
#checkov:skip=CKV2_AZURE_18:CMKs are not considered in this module
#checkov:skip=CKV_AZURE_33:Storage logging is not configured by default in this module
#tfsec:ignore:azure-storage-queue-services-logging-enabled tfsec:ignore:azure-storage-allow-microsoft-service-bypass #tfsec:ignore:azure-storage-default-action-deny
module "sa" {
  source = "registry.terraform.io/libre-devops/storage-account/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  storage_account_name            = "st${var.short}${var.loc}${terraform.workspace}01"
  access_tier                     = "Hot"
  identity_type                   = "SystemAssigned"
  allow_nested_items_to_be_public = true

  storage_account_properties = {

    // Set this block to enable network rules
    network_rules = {
      default_action = "Allow"
    }

    blob_properties = {
      versioning_enabled       = false
      change_feed_enabled      = false
      default_service_version  = "2020-06-12"
      last_access_time_enabled = false

      deletion_retention_policies = {
        days = 10
      }

      container_delete_retention_policy = {
        days = 10
      }
    }

    routing = {
      publish_internet_endpoints  = false
      publish_microsoft_endpoints = true
      choice                      = "MicrosoftRouting"
    }
  }
}

#tfsec:ignore:azure-storage-no-public-access
resource "azurerm_storage_container" "event_grid_blob" {
  name                  = "blob${var.short}${var.loc}${terraform.workspace}01"
  storage_account_name  = module.sa.sa_name
  container_access_type = "container"
}

module "event_grid_system_topic" {
  source = "registry.terraform.io/libre-devops/event-grid-system-topic/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  identity_type = "SystemAssigned"
  
  event_grid_name        = "evgst-${var.short}-${var.loc}-${terraform.workspace}-01"
  topic_type             = "Microsoft.Storage.StorageAccounts"
  source_arm_resource_id = module.sa.sa_id
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
| <a name="input_event_grid_name"></a> [event\_grid\_name](#input\_event\_grid\_name) | The name of the event grid | `string` | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for this resource to be put in | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists | `string` | n/a | yes |
| <a name="input_source_arm_resource_id"></a> [source\_arm\_resource\_id](#input\_source\_arm\_resource\_id) | The name of the Resource Group where the Event Grid System Topic should exist, e.g. the resource ID its supposed to check | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |
| <a name="input_topic_type"></a> [topic\_type](#input\_topic\_type) | The topic type which the event grid is looking at events for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventgrid_id"></a> [eventgrid\_id](#output\_eventgrid\_id) | Event Grid ID |
| <a name="output_eventgrid_identity"></a> [eventgrid\_identity](#output\_eventgrid\_identity) | The Event grid identity block |
| <a name="output_eventgrid_name"></a> [eventgrid\_name](#output\_eventgrid\_name) | Event Grid name |
| <a name="output_metric_arm_resource_id"></a> [metric\_arm\_resource\_id](#output\_metric\_arm\_resource\_id) | The Event grid metric arm resource id |
| <a name="output_source_arm_metric_id"></a> [source\_arm\_metric\_id](#output\_source\_arm\_metric\_id) | The Event grid source arm metric id |
