# TierZero Cursor Plugin

Cursor Marketplace plugin for [TierZero](https://tierzero.ai) — agentic production engineering for SWE, SRE, and DevOps. Resolve and investigate issues against your existing observability, CI/CD, and self-improving knowledge bases.

## Install

Install from the Cursor Marketplace (search "TierZero"). On first use Cursor opens a browser, you log in to TierZero and consent — done. No tokens to copy, no env vars to set.

## What's in the box

This is a multi-plugin marketplace repo with one published plugin:

| Plugin | What it does |
|--------|--------------|
| [`tierzero`](./plugins/tierzero) | Registers the TierZero MCP server, ships the `/investigate` slash command, plus `tierzero-investigate` and `tierzero-fetch` skills and an always-on rule that tell the agent when to use them. |

See [`plugins/tierzero/README.md`](./plugins/tierzero/README.md) for details and usage.

## Local development

Test changes locally without going through the marketplace:

```bash
git clone https://github.com/TierZeroAI/tierzero-cursor
cd tierzero-cursor
./scripts/install-local.sh
```

The script copies the plugin into `~/.cursor/plugins/tierzero/`, registers it in `~/.claude/plugins/installed_plugins.json`, and enables it in `~/.claude/settings.json`. Re-run after every edit.

One-time setup in Cursor:

1. Settings → Features → enable **Include third-party Plugins, Skills, and other configs**
2. Fully quit Cursor (Cmd+Q) and relaunch. *Reload Window is unreliable* — quit + relaunch.
3. Settings → MCP → tierzero → click **Authorize**, log in to TierZero in the browser, consent.

Verify it loaded: Settings → Plugins shows **TierZero**, Settings → MCP shows `tierzero` healthy (green), typing `/` in chat shows `/investigate`.

## Layout

```
.
├── .cursor-plugin/marketplace.json    # marketplace manifest
└── plugins/
    └── tierzero/
        ├── .cursor-plugin/plugin.json # plugin manifest
        ├── mcp.json                   # registers TierZero MCP server
        ├── commands/                  # slash commands
        ├── skills/                    # tool-use skills
        ├── rules/                     # always-apply guidance
        ├── assets/                    # logo
        └── README.md
```

## License

MIT
