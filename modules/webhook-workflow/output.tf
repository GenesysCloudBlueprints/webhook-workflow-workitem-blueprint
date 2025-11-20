output "name" {
  value = var.name
}

output "workflow_id" {
  value = genesyscloud_flow.webhook_workflow.id
}
