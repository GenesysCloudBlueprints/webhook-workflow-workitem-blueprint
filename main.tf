module "webhook_integration" {
  source = "./modules/webhook-integration"
  name   = "Blueprint Webhook Integration ${var.environment_name}"
}

data "genesyscloud_integration_webhook" "webhook_integration_data" {
  depends_on = [module.webhook_integration]
  name       = module.webhook_integration.name
}

data "genesyscloud_auth_division" "division_data" {
  name = var.genesys_division_name
}

module "genesys_data_action_integration" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Blueprint Webhook Data Actions Integration ${var.environment_name}"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

module "create_workitem_data_action" {
  depends_on      = [module.genesys_data_action_integration]
  source          = "./modules/data-actions/create-workitem"
  action_name     = "Create Workitem Action ${var.environment_name}"
  action_category = module.genesys_data_action_integration.integration_name
  integration_id  = module.genesys_data_action_integration.integration_id
}

module "workitem_elements" {
  depends_on          = [data.genesyscloud_auth_division.division_data]
  source              = "./modules/workitem-elements"
  prefix_name         = "Blueprint Webhook"
  environment_name    = var.environment_name
  genesys_division_id = data.genesyscloud_auth_division.division_data.id
}

module "webhook_workflow" {
  depends_on                = [module.workitem_elements, module.create_workitem_data_action, module.genesys_data_action_integration]
  source                    = "./modules/webhook-workflow"
  name                      = "Blueprint Webhook Workflow ${var.environment_name}"
  division                  = var.genesys_division_name
  data_action_category      = module.genesys_data_action_integration.integration_name
  workitem_data_action_name = module.create_workitem_data_action.name
  worktype_id               = module.workitem_elements.worktype_id
}

resource "genesyscloud_processautomation_trigger" "webhook_trigger" {
  depends_on = [data.genesyscloud_integration_webhook.webhook_integration_data]
  name       = "Blueprint Webhook Trigger ${var.environment_name}"
  topic_name = "v2.integrations.inbound.webhook.{id}.invocation"
  enabled    = true
  target {
    id   = module.webhook_workflow.workflow_id
    type = "Workflow"
    workflow_target_settings {
      data_format = "Json"
    }
  }
  match_criteria = jsonencode(([
    {
      "jsonPath" : "webhookId",
      "operator" : "Equal",
      "value" : "${data.genesyscloud_integration_webhook.webhook_integration_data.web_hook_id}"
    }
  ]))
}
