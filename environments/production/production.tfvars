environment = "production"
location    = "eastus2"

app_fleet_min_replicas = 10
app_fleet_max_replicas = 60
app_fleet_cpu          = 4
app_fleet_memory_gb    = 8

postgres_sku                  = "GP_Standard_D8s_v3"
postgres_ha_enabled           = true
postgres_dedicated_enterprise = true # dedicated Flexible Server pool provisioned per Enterprise tenant
redis_sku                     = "Premium_P1"

worker_replicas = {
  sla      = 4
  rules    = 4
  webhooks = 8
  reports  = 4
  ai_agent = 2
}

dr_enabled = true
dr_region  = "westus"
