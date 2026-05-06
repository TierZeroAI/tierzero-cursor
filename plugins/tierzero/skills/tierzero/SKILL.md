---
name: tierzero
description: Query production telemetry through TierZero to inform debugging, incident investigation, feature design, and code review. Use proactively whenever real production behavior would change your answer.
---

# TierZero: Production Telemetry Skill

Query production telemetry data through TierZero's MCP server to inform debugging, incident investigation, feature design, and code review.

## When to use

TRIGGER when:

- Debugging a production issue, error, or alert
- Investigating an incident
- Designing a new feature where traffic patterns or current usage matter
- Refactoring code where you need to know who/what calls the affected paths
- Reviewing a PR where production behavior would change your verdict
- Any task where understanding real production behavior (traffic, error rates, latency, usage) would inform a better decision

DO NOT trigger for pure unit tests, doc-only changes, or tasks with zero production relevance.

## How to call

This plugin registers TierZero as an MCP server (`tierzero`) in Cursor. Use the MCP tools directly — do **not** shell out to curl or write a wrapper script.

Primary tools:

- `tierzero_ask` — kicks off an investigation and returns the answer. Pass a single `query` argument describing what you want to know in plain English. Be specific (service name, time range, symptoms).
- `tierzero_fetch_context` — load a TierZero conversation, investigation, or artifact by URL or UUID. See the `fetch-context` skill.

Other tools exposed by the TierZero MCP server are also available — check the server's tool list when more specific access (e.g. raw logs, traces, CI runs) is useful.

## Writing good queries

A good query for `tierzero_ask`:

- Names the service or component (e.g. `payment-service`, not "the API")
- Specifies a time window (e.g. "last 30 minutes", "since 14:00 UTC", "during the deploy at 13:42")
- States the symptom (errors, latency, drop in traffic, unexpected log line)
- Mentions the integration if you know it (Datadog, Sentry, GitHub Actions, etc.)

Examples:

- `What errors occurred in payment-service in the last hour?`
- `Show p95 latency for /api/checkout over the last 24h and flag anomalies.`
- `Did any GitHub Actions workflows for the api repo fail today?`
- `Has the rate of 5xx on the auth-service changed since the deploy at 13:42 UTC?`

## After the call

- Summarize the findings tied back to the user's current task
- Cite the integration the data came from (Datadog logs, Sentry issue, etc.) when relevant
- If TierZero links to a TierZero investigation or chat, surface that URL so the user can drill in
- If the result is empty or the integration isn't connected, tell the user and suggest what to connect

## Prerequisites

- The user must have a TierZero account with relevant integrations connected (Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry, GitHub, BuildKite, Temporal, Confluence, Notion, Slack, etc.).
- Authentication is handled automatically via OAuth. If MCP calls fail with auth errors, tell the user to open Cursor Settings → MCP → tierzero and click Authorize (or re-authorize), then retry.
