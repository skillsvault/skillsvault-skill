# orgnsm — the Orgsm skill

> Copyright (c) 2026 Orgnsm. All rights reserved.

The **orgnsm** agent skill. Connect your agent to your organisation's
[Orgnsm](https://orgsm.vercel.app) control plane: install the org-approved skills, keep them
current, and check a skill is allowed before use.

## Add the skill to your agent

```
npx skills add orgnsm-dev/orgnsm-skill
```

Your agent reads the skill and walks you through connecting — it installs the `orgnsm` CLI and
runs `orgnsm login` if needed:

```
curl -fsSL https://orgnsm.vercel.app/install.sh | sh
orgnsm login
```

The CLI is distributed as a signed binary (download only). Docs: https://orgnsm.vercel.app/docs

## License
Proprietary — property of Orgnsm. See [LICENSE](./LICENSE).
