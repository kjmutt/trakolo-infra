variable "environment" {
  type        = string
  description = "dev | test | staging | production"
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "Primary Azure region"
}

# --- App fleet (Container Apps) ---
variable "app_fleet_min_replicas" {
  type = number
}
variable "app_fleet_max_replicas" {
  type = number
}
variable "app_fleet_cpu" {
  type        = number
  description = "vCPU per Container Apps replica"
}
variable "app_fleet_memory_gb" {
  type = number
}

# --- Data tier ---
variable "postgres_sku" {
  type        = string
  description = "Azure Database for PostgreSQL Flexible Server SKU name — verify against the current Azure SKU catalog before applying, these change over time"
}
variable "postgres_ha_enabled" {
  type    = bool
  default = false
}
variable "postgres_dedicated_enterprise" {
  type        = bool
  default     = false
  description = "Provision the dedicated-per-Enterprise-tenant Flexible Server pool for this environment"
}
variable "redis_sku" {
  type = string
}

# --- Background workers ---
variable "worker_replicas" {
  type = map(number)
  description = "Replica count per worker: sla, rules, webhooks, reports, ai_agent"
}

# --- Disaster recovery ---
variable "dr_enabled" {
  type    = bool
  default = false
}
variable "dr_region" {
  type    = string
  default = "westus"
}
