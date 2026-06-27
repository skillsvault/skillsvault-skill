# skillsvault — the Orgsm skill

> Copyright (c) 2026 skillsvault. All rights reserved.

The **skillsvault** agent skill. Connect your agent to your organisation's
[skillsvault](https://orgsm.vercel.app) control plane: install the org-approved skills, keep them
current, and check a skill is allowed before use.

## Add the skill to your agent

```
npx skills add skillsvault-dev/skillsvault-skill
```

Your agent reads the skill and walks you through connecting — it installs the `skillsvault` CLI and
runs `skillsvault login` if needed:

```
curl -fsSL https://skillsvault.vercel.app/install.sh | sh
skillsvault login
```

The CLI is distributed as a signed binary (download only). Docs: https://skillsvault.vercel.app/docs

## License
Proprietary — property of skillsvault. See [LICENSE](./LICENSE).
