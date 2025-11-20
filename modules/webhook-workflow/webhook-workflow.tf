
resource "genesyscloud_flow" "webhook_workflow" {
  filepath = "${path.module}/WebhookWorkflow.yaml"
  substitutions = {
    workflow_name             = var.name
    division                  = var.division
    default_language          = "en-us"
    data_action_category      = var.data_action_category
    workitem_data_action_name = var.workitem_data_action_name
    worktype_id               = var.worktype_id
  }
}
