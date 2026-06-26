# orgsm — the Orgsm skill

> Copyright (c) 2026 Orgsm. All rights reserved.

The **orgsm** agent skill. Connect your agent to your organisation's
[Orgsm](https://orgsm.vercel.app) control plane: install the org-approved skills, keep them
current, and check a skill is allowed before use.

## Add the skill to your agent

```
npx skills add LatVAlY/orgsm-skill
```

Your agent reads the skill and walks you through connecting — it installs the `orgsm` CLI and
runs `orgsm login` if needed:

```
curl -fsSL https://orgsm.vercel.app/install.sh | sh
orgsm login
```

The CLI is distributed as a signed binary (download only). Docs: https://orgsm.vercel.app/docs

## License
Proprietary — property of Orgsm. See [LICENSE](./LICENSE).
