# trakolo-infra

Infrastructure as Code, monitoring, and per-environment configuration for every Trakolo environment (Dev, QA, Staging, Production, and the DR region). Companion to [`kjmutt/trakolo`](https://github.com/kjmutt/trakolo), the application repo.

This repo intentionally absorbs what could otherwise be two more repos:

- **Configuration** — per-environment parameter files under `environments/<env>/`, not a separate "config" repo. Same reviewers, same lifecycle, same deploy mechanism as the rest of infra.
- **Monitoring** — alert rules and dashboards under `monitoring/`, not a separate "monitoring" repo, for the same reason.

On-premise installation artifacts (`install/docker-compose.yml`, Ansible playbooks) live in the **application repo**, not here — they version with the app release they support, not with Trakolo's own cloud environments.

## Layout

```
modules/            Reusable Terraform/Bicep modules, one per architecture layer:
  edge/                Azure DNS, Front Door / API Management
  app-fleet/           Static Web Apps, Container Apps environment
  control-plane/       Azure Cache for Redis, tenant registry
  data-tier/           PostgreSQL Flexible Server (shared + dedicated), Blob Storage
  workers/             Container Apps jobs (worker-sla/rules/webhooks/reports/ai-agent), Service Bus
  observability/       Azure Monitor, Application Insights, Key Vault

environments/
  dev/                 terraform.tfvars / bicepparam for Dev — smallest SKUs
  qa/                  QA — isolated resource group
  staging/             Staging — production-matched SKUs
  production/          Production — full SKUs + DR pairing
  dr/                  The paired DR region standby

monitoring/          Alert rules and dashboard definitions, environment-agnostic
```

## First-time environment creation vs. ongoing updates

- **First time**: `terraform apply` (or `az deployment group create` for Bicep) with an environment's parameter file creates that environment's entire resource group from scratch — everything in `modules/`, wired together. Secrets are generated straight into Key Vault as part of the same apply.
- **Ongoing updates**: same modules, same command. `terraform plan` / `bicep what-if` runs in CI on every PR so reviewers see the exact diff before anything applies. A nightly drift-detection plan (expecting zero changes) catches manual portal edits that bypassed the pipeline.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the branching strategy and PR requirements.
