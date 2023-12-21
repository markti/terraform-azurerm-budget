resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_region
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

resource "time_static" "budget_start_date" {
}

resource "azurerm_consumption_budget_subscription" "main" {

  name            = "budget-${var.application_name}-${var.environment_name}"
  subscription_id = data.azurerm_subscription.current.id

  amount     = 50
  time_grain = "Monthly"

  time_period {
    start_date = "12/01/2023"
  }

  notification {
    enabled        = true
    threshold      = 90.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = [
      "mark@tinderholt.net"
    ]
  }
}