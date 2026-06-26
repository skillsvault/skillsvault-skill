# orgsm CLI reference

| Command | What it does | Exit |
|---|---|---|
| `orgsm configure --org <slug> --key <key> [--url <base>]` | Connect this machine to an org; pins the signing key. | 0/1 |
| `orgsm sync` | Pull + verify the signed policy bundle. | 0/1 |
| `orgsm pull [--harness <h>] [--all]` | Install approved skills (banned removed). `--all` = every detected harness. | 0/1 |
| `orgsm detect` | List detected AI agents + whether each is enforced or distribution-only. | 0 |
| `orgsm gate --skill <org/skill>` | Evaluate a skill. | 0 allow · 0 warn · 2 halt |
| `orgsm status` | Show config + bundle freshness. | 0 |
| `orgsm publish <path>` | Publish a skill folder to the org registry. | 0/1 |

## Decision semantics

The gate evaluates a locally-stored, signed bundle (no network, no model on the
path). The **most restrictive** matching rule wins: `halt > warn > allow`. A
banned skill always halts, even if a broader warn policy also matches.
