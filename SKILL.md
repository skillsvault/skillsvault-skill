---
name: orgnsm
description: Connect this agent to your organisation's orgnsm control plane and manage agent skills — install the org-approved skills, keep them current, and check a skill is allowed before use. Run this on first use to get set up (it will prompt the user to sign in if needed), and whenever you install, update, govern, or verify the org's skills.
---

# orgnsm — connect & govern your organisation's skills

orgnsm is your organisation's control plane for agent skills. This skill connects
this machine to it, installs the org-approved skills, and keeps what you run
aligned with what the organisation approved.

## Step 1 — make sure you're connected (do this first)

Run:

```
orgnsm whoami
```

- **Prints an organisation** → you're connected. Go to Step 2.
- **"not configured"** → connect now (Step 1a).
- **`orgnsm: command not found`** → install the CLI first (Step 1b), then 1a.

### 1a. Sign in — ask the user

Tell the user you need them to authorise this machine, then run:

```
orgnsm login
```

This opens their browser to sign in to orgnsm and authorise this machine. If they
already have an **agent key** (from the orgnsm dashboard → Settings → API keys),
they can connect non-interactively instead:

```
orgnsm login --key <agent-key> --org <org-slug>
```

### 1b. Install the CLI (only if `orgnsm` is missing)

```
curl -fsSL https://orgnsm.vercel.app/install.sh | sh
```

If you cannot run that, ask the user to install the `orgnsm` CLI, then retry.

## Step 2 — set up enforcement + install approved skills

```
orgnsm install-hook    # gate skills at invocation time (Claude Code)
orgnsm pull --all      # install the org's approved skills into every detected harness
```

`pull --all` installs the current approved version of each skill and **removes
any banned skill** from this machine.

## Step 3 — manage skills (ongoing)

- `orgnsm pull --all` — refresh: install approved, remove banned.
- `orgnsm gate --skill <org/skill>` — check a skill before use: **allow / warn /
  halt** (halt = do not use; the reason names the approved replacement).
- `orgnsm publish <path>` — publish a skill folder to the org registry.
- `orgnsm whoami` · `orgnsm status` — which org, and how fresh the policy bundle is.

## Rules (always)

1. If `orgnsm gate` **halts** a skill, do **not** use it — follow the reason.
2. Prefer `orgnsm pull` to get the approved version over any older/sideloaded copy.
3. Never bypass a halt.

See `references/cli.md` for the full command reference.
