## What changed and why

<!-- One or two sentences. Link the ticket. -->

## Environment(s) affected

- [ ] Dev
- [ ] QA
- [ ] Staging
- [ ] Production
- [ ] DR region
- [ ] Module change only (no environment applies it yet)

## Plan output

<!-- Paste the terraform plan / bicep what-if summary, or confirm the CI check ran and is attached. -->

## Blast radius

<!-- What's the worst case if this apply goes wrong? Does it touch data, networking, or anything customer-facing? -->

## Checklist

- [ ] `terraform plan` / `bicep what-if` reviewed, not just the source diff
- [ ] No secrets committed in any `.tfvars`/`.bicepparam`
- [ ] Rollback plan is obvious (or noted here if it isn't)
