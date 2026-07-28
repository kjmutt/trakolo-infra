environment = "staging"
location    = "eastus2"

app_fleet_min_replicas = 4
app_fleet_max_replicas = 10
app_fleet_cpu          = 2
app_fleet_memory_gb    = 4

postgres_sku                  = "GP_Standard_D4s_v3"
postgres_ha_enabled           = true
postgres_dedicated_enterprise = false
redis_sku                     = "Standard_C1"

worker_replicas = {
  sla      = 2
  rules    = 2
  webhooks = 3
  reports  = 2
  ai_agent = 1
}

dr_enabled = false
