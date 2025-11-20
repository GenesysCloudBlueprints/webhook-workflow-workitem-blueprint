resource "genesyscloud_integration_action" "create_workitem" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type" : "object",
    "properties" : {
      "name" : {
        "type" : "string"
      },
      "worktypeId" : {
        "type" : "string"
      },
      "sample_text" : {
        "type" : "string"
      },
      "sample_integer" : {
        "type" : "integer"
      }
      # You can add more properties here as needed when creating workitems
    }
  })
  contract_output = jsonencode({
    "type" : "object",
    "properties" : {
      "id" : {
        "type" : "string"
      }
    }
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/taskmanagement/workitems"
    request_type         = "POST"
    headers              = {}
    # Add the additional properties in the request template as needed
    request_template = "{\n    \"name\": \"$${input.name}\",\n    \"typeId\": \"$${input.worktypeId}\",\n    \"customFields\": {\n        \"sample_text\": \"$${input.sample_text}\",\n        \"sample_integer\": $${input.sample_integer}\n    }\n}"
  }
  config_response {
    translation_map          = {}
    translation_map_defaults = {}
    success_template         = "$${rawResult}"
  }
}
