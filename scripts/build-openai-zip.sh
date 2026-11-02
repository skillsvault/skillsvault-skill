#!/bin/sh
# Builds dist/skillsvault-openai.zip, the package for OpenAI's plugin directory
# (ChatGPT + Codex).
#
# OpenAI's dashboard detects an MCP server only through the Codex layout its
# own published plugins use (openai/plugins: linear, datadog): a
# .codex-plugin/plugin.json that points at ./.mcp.json and ./skills/. So the
# package is generated in that layout from this repo's plugin.json, instead of
# shipping the portable root plugin.json + mcp.json (which the dashboard reads
# as "no MCP server", i.e. a skills-only plugin).
#
# Contents: the MCP server, both skills, the icon. No hooks (OpenAI rejects
# them) and none of the other agents' manifests.
set -eu
cd "$(dirname "$0")/.."
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT

mkdir -p "$stage/.codex-plugin" "$stage/assets"
python3 - "$stage" <<'PY'
import json, sys
stage = sys.argv[1]
root = json.load(open("plugin.json"))
openai = root.get("extensions", {}).get("com.openai", {})
manifest = {
    "name": root["name"],
    "version": root["version"],
    "description": root["description"],
    "author": root["author"],
    "homepage": root["homepage"],
    "repository": root["repository"],
    "license": root["license"],
    "keywords": root["keywords"],
    "skills": "./skills/",
    "mcpServers": "./.mcp.json",
    "interface": openai["interface"],
}
json.dump(manifest, open(f"{stage}/.codex-plugin/plugin.json", "w"), indent=2)
mcp = {"mcpServers": {"skillsvault": {
    "type": "http",
    "url": "https://skillsvault.io/api/mcp",
    "oauth_resource": "https://skillsvault.io/api/mcp",
}}}
json.dump(mcp, open(f"{stage}/.mcp.json", "w"), indent=2)
PY
cp -R skills "$stage/skills"
find "$stage/skills" -name skillsvault.json -delete
cp assets/icon.png "$stage/assets/icon.png"
cp README.md LICENSE "$stage/"

mkdir -p dist
rm -f dist/skillsvault-openai.zip
(cd "$stage" && zip -qrX "$OLDPWD/dist/skillsvault-openai.zip" .codex-plugin .mcp.json skills assets README.md LICENSE -x "*.DS_Store")
unzip -l dist/skillsvault-openai.zip
