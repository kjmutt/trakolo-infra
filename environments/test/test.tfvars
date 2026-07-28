environment = "test"
location    = "eastus2"

app_fleet_min_replicas = 2
app_fleet_max_replicas = 4
app_fleet_cpu          = 1
app_fleet_memory_gb    = 2

postgres_sku                  = "GP_Standard_D2s_v3" # general purpose
postgres_ha_enabled           = false
postgres_dedicated_enterprise = false
redis_sku                     = "Basic_C1"

worker_replicas = {
  sla      = 1
  rules    = 1
  webhooks = 2
  reports  = 1
  ai_agent = 1
}

dr_enabled = false
