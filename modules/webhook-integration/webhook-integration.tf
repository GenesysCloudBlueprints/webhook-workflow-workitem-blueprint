resource "genesyscloud_integration" "webhook_integration" {
  intended_state   = "ENABLED"
  integration_type = "webhook"
  config {
    name = var.name
  }
}
