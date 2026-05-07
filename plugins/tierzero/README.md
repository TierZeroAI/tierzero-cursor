# TierZero for Cursor

Native production telemetry inside Cursor. The plugin registers TierZero as an MCP server so the agent can read your logs, metrics, traces, CI/CD runs, and knowledge bases through a single API.

## What you get

- **MCP server** — `tierzero` is registered automatically. The agent can call every tool the TierZero MCP server exposes (`tierzero_ask`, `tierzero_fetch_context`, plus any others the server adds in the future) without shelling out.
- **Slash command** — `/investigate <query>` to kick off a TierZero investigation.
- **Skills** — `tierzero-investigate` (the entry point for any production problem — alerts, errors, latency, deploy regressions) and `tierzero-fetch` (load a saved TierZero chat, investigation, or artifact). The agent picks them automatically based on context.
- **Rule** — `alwaysApply` rule that nudges the agent to reach for TierZero whenever real production behavior would change its answer.

## Requirements

A TierZero account with at least one integration connected (Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry, GitHub, BuildKite, Temporal, Confluence, Notion, Slack, etc.).

## Authentication

The plugin uses OAuth — no tokens, no env vars. On first use Cursor opens a browser to TierZero, you log in, consent to the requested scope, and the token persists in Cursor. To revoke access, remove the MCP server from Cursor Settings → MCP.

## Usage

### Run an investigation

```
/investigate what errors hit payment-service in the last hour?
```

The agent calls `tierzero_ask` and summarizes the result.

### Load saved context

Just paste a TierZero URL or artifact UUID into the chat:

```
https://app.tierzero.ai/investigations/SW52ZXN0...
bf904904-afdc-4cf2-94d8-76a4a8bb4f75
```

The `tierzero-fetch` skill triggers automatically — the agent loads the chat / investigation / artifact and folds it into the current task.

### Hands-off

You don't have to invoke explicitly. The included rule tells the agent to reach for TierZero whenever production data would change its answer, e.g. while debugging an incident, reviewing a hot-path PR, or designing a feature that depends on current traffic patterns.

## What can the agent see?

Everything your TierZero org has connected. Common integrations:

- **Logs / metrics / traces** — Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry
- **Code & CI/CD** — GitHub, BuildKite, GitHub Actions
- **Workflows** — Temporal
- **Knowledge** — Confluence, Notion, Slack

## Documentation

- TierZero MCP server: <https://docs.tierzero.ai/references/mcp-server>
- TierZero docs: <https://docs.tierzero.ai>

## License

MIT
