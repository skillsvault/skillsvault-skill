#!/bin/sh
# Builds dist/skillsvault-openai.zip, the package for OpenAI's plugin directory
# (ChatGPT + Codex), from this repo's Agent Plugins manifests.
#
# MCP only: no hooks (OpenAI rejects them) and no skills/ (the skill drives
# the skillsvault CLI, and ChatGPT has no terminal). The other agents'
# manifests (.claude-plugin, .cursor-plugin, gemini-extension.json) stay out.
set -eu
cd "$(dirname "$0")/.."
mkdir -p dist
rm -f dist/skillsvault-openai.zip
zip -qrX dist/skillsvault-openai.zip plugin.json mcp.json assets/icon.png README.md LICENSE -x "*.DS_Store"
unzip -l dist/skillsvault-openai.zip
