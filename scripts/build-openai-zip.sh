#!/bin/sh
# Builds dist/skillsvault-openai.zip, the package for OpenAI's plugin directory
# (ChatGPT + Codex), from this repo's Agent Plugins manifests.
#
# The MCP server and both skills: approved-skills works in any client through
# the MCP tools; skillsvault sets up the CLI where there is a terminal (Codex).
# No hooks (OpenAI rejects them). The other agents' manifests
# (.claude-plugin, .cursor-plugin, gemini-extension.json) stay out.
set -eu
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/skillsvault-openai.zip
zip -qrX dist/skillsvault-openai.zip plugin.json mcp.json skills assets/icon.png README.md LICENSE -x "*.DS_Store" "skills/*/skillsvault.json"
unzip -l dist/skillsvault-openai.zip
