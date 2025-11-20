resource "genesyscloud_task_management_workbin" "example_workbin" {
  name        = "${var.prefix_name} Workbin ${var.environment_name}"
  description = "${var.prefix_name} Workbin"
  division_id = var.genesys_division_id
}

resource "genesyscloud_task_management_workitem_schema" "example_schema" {
  enabled     = "true"
  name        = "${var.prefix_name} Workitem Schema ${var.environment_name}"
  description = "The workitem schema for the ${var.prefix_name}"
  properties = jsonencode({
    "sample_text" : {
      "allOf" : [
        {
          "$ref" : "#/definitions/text"
        }
      ],
      "title" : "sampleText",
      "description" : "sample field for text",
      "minLength" : 0,
      "maxLength" : 100
    },
    "sample_integer" : {
      "allOf" : [
        {
          "$ref" : "#/definitions/integer"
        }
      ],
      "title" : "sampleInteger",
      "description" : "Custom attribute for integer",
      "minimum" : 1,
      "maximum" : 1000
    },
  })
}

# Available definitions for workitem schema properties:
# {
#     "custom_attribute_1_text" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/text"
#         }
#         ],
#         "title" : "custom_attribute_1",
#         "description" : "Custom attribute for text",
#         "minLength" : 0,
#         "maxLength" : 100
#     },
#     "custom_attribute_2_longtext" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/longtext"
#         }
#         ],
#         "title" : "custom_attribute_2",
#         "description" : "Custom attribute for long text",
#         "minLength" : 0,
#         "maxLength" : 1000
#     },
#     "custom_attribute_3_url" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/url"
#         }
#         ],
#         "title" : "custom_attribute_3",
#         "description" : "Custom attribute for url",
#         "minLength" : 0,
#         "maxLength" : 200
#     },
#     "custom_attribute_4_identifier" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/identifier"
#         }
#         ],
#         "title" : "custom_attribute_4",
#         "description" : "Custom attribute for identifier",
#         "minLength" : 0,
#         "maxLength" : 100
#     },
#     "custom_attribute_5_enum" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/enum"
#         }
#         ],
#         "title" : "custom_attribute_5",
#         "description" : "Custom attribute for enum",
#         "enum" : ["option_1", "option_2", "option_3"],
#         "_enumProperties" : {
#         "option_1" : {
#             "title" : "Option 1",
#             "_disabled" : false
#         },
#         "option_2" : {
#             "title" : "Option 2",
#             "_disabled" : false
#         },
#         "option_3" : {
#             "title" : "Option 3",
#             "_disabled" : false
#         },
#         },
#     },
#     "custom_attribute_6_date" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/date"
#         }
#         ],
#         "title" : "custom_attribute_6",
#         "description" : "Custom attribute for date",
#     },
#     "custom_attribute_7_datetime" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/datetime"
#         }
#         ],
#         "title" : "custom_attribute_7",
#         "description" : "Custom attribute for datetime",
#     },
#     "custom_attribute_8_integer" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/integer"
#         }
#         ],
#         "title" : "custom_attribute_8",
#         "description" : "Custom attribute for integer",
#         "minimum" : 1,
#         "maximum" : 1000
#     },
#     "custom_attribute_9_number" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/number"
#         }
#         ],
#         "title" : "custom_attribute_9",
#         "description" : "Custom attribute for number",
#         "minimum" : 1,
#         "maximum" : 1000
#     },
#     "custom_attribute_10_checkbox" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/checkbox"
#         }
#         ],
#         "title" : "custom_attribute_10",
#         "description" : "Custom attribute for checkbox"
#     },
#     "custom_attribute_11_tag" : {
#         "allOf" : [
#         {
#             "$ref" : "#/definitions/tag"
#         }
#         ],
#         "title" : "custom_attribute_11",
#         "description" : "Custom attribute for tag",
#         "items" : {
#         "minLength" : 1,
#         "maxLength" : 100
#         },
#         "minItems" : 0,
#         "maxItems" : 10,
#         "uniqueItems" : true
#     },
# }

resource "genesyscloud_task_management_worktype" "example_worktype" {
  name               = "${var.prefix_name} Worktype ${var.environment_name}"
  description        = "${var.prefix_name} Worktype"
  default_workbin_id = genesyscloud_task_management_workbin.example_workbin.id
  schema_id          = genesyscloud_task_management_workitem_schema.example_schema.id
  schema_version     = genesyscloud_task_management_workitem_schema.example_schema.version
  #   division_id        = data.genesyscloud_auth_division_home.home.id

  #   default_duration_seconds     = 86400
  #   default_expiration_seconds   = 86400
  #   default_due_duration_seconds = 86400
  #   default_priority             = 100
  #   default_ttl_seconds          = 86400

  #   default_language_id = genesyscloud_routing_language.english.id
  #   default_queue_id    = genesyscloud_routing_queue.example_queue.id
  #   default_skills_ids  = [genesyscloud_routing_skill.example_skill.id, genesyscloud_routing_skill.example_skill2.id]
  #   default_script_id   = genesyscloud_script.example_script.id

  #   assignment_enabled = true
}

### Other Worktype resources

## Worktype Statuses
# resource "genesyscloud_task_management_worktype_status" "open" {
#   worktype_id = genesyscloud_task_management_worktype.example_worktype.id
#   name        = "Open Status"
#   description = "Description of open status"
#   category    = "Open"
#   default     = false
# }

## Worktype Transitions
# resource "genesyscloud_task_management_worktype_status_transition" "open" {
#   worktype_id                     = genesyscloud_task_management_worktype.example_worktype.id
#   status_id                       = genesyscloud_task_management_worktype_status.open.id
#   destination_status_ids          = [genesyscloud_task_management_worktype_status.working.id, genesyscloud_task_management_worktype_status.waiting.id, genesyscloud_task_management_worktype_status.backlog.id, genesyscloud_task_management_worktype_status.resolved.id, genesyscloud_task_management_worktype_status.closed.id]
#   default_destination_status_id   = genesyscloud_task_management_worktype_status.working.id
#   status_transition_delay_seconds = 86500
#   status_transition_time          = "04:20:00"
# }

## Worktype Rules
# resource "genesyscloud_task_management_worktype_flow_datebased_rule" "datebased_rule" {
#   worktype_id = genesyscloud_task_management_worktype.example_worktype.id
#   name        = "DateBased Rule"
#   condition {
#     attribute                      = "dateDue"
#     relative_minutes_to_invocation = -10
#   }
# }

# resource "genesyscloud_task_management_worktype_flow_onattributechange_rule" "onattributechange_rule_data" {
#   worktype_id = genesyscloud_task_management_worktype.example_worktype.id
#   name        = "OnAttributeChange Rule"
#   condition {
#     attribute = "statusId"
#     new_value = genesyscloud_task_management_worktype_status.backlog.id
#     old_value = genesyscloud_task_management_worktype_status.open.id
#   }
# }

# resource "genesyscloud_task_management_worktype_flow_oncreate_rule" "oncreate_rule" {
#   worktype_id = genesyscloud_task_management_worktype.example_worktype_without_assignment.id
#   name        = "OnCreate Rule"
# }
