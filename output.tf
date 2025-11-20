output "webhook_url" {
  value = data.genesyscloud_integration_webhook.webhook_integration_data.invocation_url
}
output "webhook_id" {
  value = data.genesyscloud_integration_webhook.webhook_integration_data.web_hook_id
}
