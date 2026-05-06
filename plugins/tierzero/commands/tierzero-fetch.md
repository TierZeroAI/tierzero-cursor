---
name: tierzero-fetch
description: Load a TierZero conversation, investigation, or artifact by URL or UUID and use it as context for the current task.
---

# /tierzero-fetch

Pull a saved TierZero chat, investigation, or artifact into the current Cursor session.

## Steps

1. Take the argument after `/tierzero-fetch` as the input. Accepted forms:
   - Chat URL: `https://app.tierzero.ai/chat/c/<GlobalID>`
   - Investigation URL: `https://app.tierzero.ai/investigations/<GlobalID>`
   - Artifact UUID: `bf904904-afdc-4cf2-94d8-76a4a8bb4f75`
2. If the argument is missing, ask the user for a URL or UUID, then stop.
3. Call the `tierzero_fetch_context` tool on the `tierzero` MCP server with `url` set to the input. Default `include_sources` to `false`; pass `true` only if the user asked for sources.
4. Summarize the loaded context and tie it to the user's current task. For investigations, present the conclusion and the evidence. For chats, summarize what was decided and any open follow-ups.

## Examples

- `/tierzero-fetch https://app.tierzero.ai/investigations/SW52ZXN0...`
- `/tierzero-fetch bf904904-afdc-4cf2-94d8-76a4a8bb4f75`
- `/tierzero-fetch https://app.tierzero.ai/chat/c/Q2hh...  with sources` (set `include_sources: true`)
