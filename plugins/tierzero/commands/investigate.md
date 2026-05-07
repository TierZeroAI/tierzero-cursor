---
name: investigate
description: Run a TierZero investigation against your connected production systems (logs, metrics, traces, CI/CD, knowledge bases).
---

# /investigate

Run a TierZero investigation against connected production systems.

The arguments after `/investigate` are the user's natural-language query.

## Steps

1. Treat everything the user typed after `/investigate` as the investigation `query`.
2. If the query is empty, ask the user what they want to investigate, then stop.
3. Call the `tierzero_ask` tool on the `tierzero` MCP server with that query as the `query` argument.
4. Wait for the response, then summarize the findings tied to the user's current work.
5. Surface any TierZero investigation URL returned in the result so the user can drill in.
6. If the call fails with an authentication error, tell the user to open Cursor Settings → MCP → tierzero and click Authorize (or re-authorize), then retry.

## Tips for a good query

- Name the service or component, not "the API"
- Include a time window ("last hour", "since the 13:42 UTC deploy")
- State the symptom (errors, latency, drop in traffic)

## Examples

- `/investigate what errors hit payment-service in the last hour?`
- `/investigate p95 latency for /api/checkout over the last 24h, flag anomalies`
- `/investigate did any github actions runs for the api repo fail today?`
