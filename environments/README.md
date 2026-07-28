# Environment configuration

Each folder's `.tfvars` fills in the schema defined in [`../variables.tf`](../variables.tf). Apply with:

```sh
terraform apply -var-file=environments/<env>/<env>.tfvars
```

## Sizing rationale

Dev and Test are deliberately minimal — they exist to run code, not to predict load. Staging is sized to match Production so performance/load testing there is meaningful. Production's app-fleet and worker replica counts are the low end of the "5,000–10,000 concurrent users" tier from the cloud SaaS capacity table in the application's `system-requirements.html` documentation — adjust `app_fleet_max_replicas` and `worker_replicas` upward as real usage approaches that ceiling, and re-check that table's next tier before assuming a bigger box is still the answer.

**SKU names are illustrative, not guaranteed current** — Azure's PostgreSQL Flexible Server and Redis SKU catalogs change over time. Verify `postgres_sku` / `redis_sku` against `az postgres flexible-server list-skus` and the current Azure Cache for Redis pricing tiers before the first real apply.

## DR

There's no separate `dr/` tfvars file — the DR region is Production's own configuration (`dr_enabled = true`, `dr_region = "westus"`), applied a second time targeting the DR region by the same Terraform run. It is not an independently-sized environment; it mirrors Production, per the disaster-recovery design in `release-engineering.html`.
