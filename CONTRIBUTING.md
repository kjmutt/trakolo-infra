# Branching strategy

Same trunk-based model as the application repo — `main` is the only long-lived branch and is always applicable to Dev without a separate promotion step. There are no persistent per-environment branches; environment identity comes from which `environments/<env>/` parameter file a plan/apply targets, not from which branch is checked out.

## Branch naming

| Pattern | Use |
|---|---|
| `infra/<ticket-id>-short-desc` | Any module or environment-config change. Cut from `main`, short-lived. |
| `hotfix/<ticket-id>-short-desc` | Emergency infra fix (e.g., a security-group rule blocking production traffic). |

## Why infra gets stricter review than the app repo

Infra changes have a wider and quieter blast radius than an application PR — a bad security-group rule or an accidental resource deletion can take down every tenant, not just fail a code review. This repo's ruleset requires **two** approving reviews (not one) and a passing `terraform-plan` / `bicep-what-if` check that reviewers actually read before approving, since the diff output is often the only place the real impact of a one-line HCL/Bicep change becomes visible.

## Pull request requirements

Every PR into `main` requires:

1. **`terraform plan` / `bicep what-if` posted as a check** — reviewers read the resource-level diff, not just the source diff.
2. **Two approving reviews**, including a CODEOWNERS review for the environment(s) touched — see [`.github/CODEOWNERS`](.github/CODEOWNERS).
3. **All review conversations resolved.**
4. **No direct pushes to `main`.**

Apply happens through the same pipeline gates as application code: automatic for Dev, manual approval gate for Staging and Production. A nightly scheduled `terraform plan` against every environment (expecting zero changes) catches drift from manual portal edits that bypassed this process — a non-empty nightly plan is treated as an incident, not a routine diff to wave through.

## Secrets

Never commit a `.tfvars`/`.bicepparam` file containing a real secret. Generated secrets (DB passwords, API keys) are written straight to Key Vault by the apply step itself; environment parameter files should only ever contain non-secret configuration (SKU sizes, region names, feature toggles).
