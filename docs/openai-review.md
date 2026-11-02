# OpenAI plugin review: what to submit

Everything the OpenAI plugin dashboard asks for, ready to paste. Package:
`dist/skillsvault-openai.zip` (built by `scripts/build-openai-zip.sh`).
Spec: https://developers.openai.com/plugins/deploy/submission

## Before uploading

- [ ] Category: pick from the dashboard's list (manifest says "Developer Tools").
- [ ] Domain verification: put the token OpenAI gives at
      `https://skillsvault.io/.well-known/openai-apps-challenge` (plain text, the token only).
- [ ] MCP auth in the dashboard: OAuth, client registration **DCR**
      (`https://skillsvault.io/api/oauth/register`), scope `mcp`, public client (no secret).
- [ ] Reviewer account: OpenAI requires one with immediate access, **no magic link, email code
      or MFA**. Our sign-in is magic link / GitHub only, so we need a way for reviewers to sign in.
- [ ] Demo recording: `skillsvault-launch-16x9.mp4` (launch video).
- [ ] Reviewer org seeded with skills, one banned skill and one Block policy (see cases below).

## Tools under review

| Tool | What it does |
|---|---|
| `list_skills` | The org's approved skills; `query` finds the best matches, closest ones marked `match: "closest"`. |
| `load_skill` | A skill's SKILL.md, version, status and signed provenance. Banned → refused; deprecated → warning. Audited. |
| `get_skill_file` | One bundled file of a skill. Same policy gate. Audited. |

Seed the reviewer org with: `review/pdf-forms` (active), `review/code-review` (active),
`review/old-deploy` (deprecated), `review/auto-merge` (banned), and a Block policy on
namespace `experimental`.

## Positive cases (5)

1. **Find a skill by task**
   Prompt: "Which of our approved skills can fill in a PDF form?"
   tools_triggered: `list_skills`
   expected_behavior: Lists `review/pdf-forms` first, with its description and portal url.

2. **Load and follow a skill**
   Prompt: "Load our code review skill and use it to review this diff: `- return a\n+ return a ?? b`"
   tools_triggered: `list_skills`, `load_skill`
   expected_behavior: Loads `review/code-review`, follows its checklist, cites the skill's url.

3. **Read a bundled file**
   Prompt: "Show me the field reference that ships with the PDF forms skill."
   tools_triggered: `load_skill`, `get_skill_file`
   expected_behavior: Fetches the skill's `references/` file and summarises it.

4. **Deprecated skill carries its warning**
   Prompt: "Load the old-deploy skill."
   tools_triggered: `load_skill`
   expected_behavior: Delivers the instructions and tells the user the skill is deprecated.

5. **Inventory**
   Prompt: "List every skill my organisation has approved."
   tools_triggered: `list_skills`
   expected_behavior: Lists the active and deprecated skills; banned ones are absent.

## Negative cases (3)

1. **Banned skill is refused**
   Prompt: "Load the auto-merge skill and run it."
   expected: No content is returned; the assistant says the organisation blocked it and why.

2. **No matching skill**
   Prompt: "Use our skill for booking flights."
   expected: No approved skill matches (closest results, if any, are marked as such); the assistant
   doesn't invent one.

3. **Not a skill request**
   Prompt: "What's the weather in Berlin?"
   expected: skillsvault tools aren't called.
