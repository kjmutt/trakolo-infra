environment = "dev"
location    = "eastus2"

app_fleet_min_replicas = 1
app_fleet_max_replicas = 2
app_fleet_cpu          = 0.5
app_fleet_memory_gb    = 1

postgres_sku                  = "B_Standard_B1ms" # burstable, smallest tier
postgres_ha_enabled           = false
postgres_dedicated_enterprise = false
redis_sku                     = "Basic_C0"

worker_replicas = {
  sla      = 1
  rules    = 1
  webhooks = 1
  reports  = 1
  ai_agent = 1
}

dr_enabled = false
