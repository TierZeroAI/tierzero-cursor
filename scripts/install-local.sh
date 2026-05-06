#!/usr/bin/env bash
#
# Install the tierzero plugin into a local Cursor instance for testing.
#
# Workflow (per https://medium.com/@v.tajzich/how-to-write-and-test-cursor-plugins-locally-the-part-the-docs-dont-tell-you-4eee705d7f76):
#   1. Copy plugin contents into ~/.cursor/plugins/tierzero/
#   2. Register in ~/.claude/plugins/installed_plugins.json
#   3. Enable in ~/.claude/settings.json
#   4. (Manual) toggle Cursor Settings > Features > "Include third-party Plugins, Skills, and other configs"
#   5. (Manual) fully quit and relaunch Cursor
#
# Re-run this script whenever you edit plugin files. Reload Window often misses changes — fully quit Cursor.

set -euo pipefail

PLUGIN_NAME="tierzero"
PLUGIN_ID="${PLUGIN_NAME}@local"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC="$REPO_ROOT/plugins/$PLUGIN_NAME"

if [ ! -d "$SRC" ]; then
  echo "Error: plugin source not found at $SRC" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required (brew install jq)" >&2
  exit 1
fi

TARGET="$HOME/.cursor/plugins/$PLUGIN_NAME"
INSTALLED_JSON="$HOME/.claude/plugins/installed_plugins.json"
SETTINGS_JSON="$HOME/.claude/settings.json"

echo "==> Copying $SRC -> $TARGET"
rm -rf "$TARGET"
mkdir -p "$TARGET"
for entry in .cursor-plugin commands rules skills agents scripts hooks assets mcp.json README.md; do
  if [ -e "$SRC/$entry" ]; then
    cp -R "$SRC/$entry" "$TARGET/"
  fi
done

mkdir -p "$(dirname "$INSTALLED_JSON")"
mkdir -p "$(dirname "$SETTINGS_JSON")"
[ -f "$INSTALLED_JSON" ] || echo '{}' > "$INSTALLED_JSON"
[ -f "$SETTINGS_JSON" ]  || echo '{}' > "$SETTINGS_JSON"

echo "==> Registering in $INSTALLED_JSON"
TMP="$(mktemp)"
jq --arg id "$PLUGIN_ID" --arg path "$TARGET" '
  .plugins //= {}
  | .plugins[$id] = [{ scope: "user", installPath: $path }]
' "$INSTALLED_JSON" > "$TMP" && mv "$TMP" "$INSTALLED_JSON"

echo "==> Enabling in $SETTINGS_JSON"
TMP="$(mktemp)"
jq --arg id "$PLUGIN_ID" '
  .enabledPlugins //= {}
  | .enabledPlugins[$id] = true
' "$SETTINGS_JSON" > "$TMP" && mv "$TMP" "$SETTINGS_JSON"

cat <<EOF

Installed $PLUGIN_ID at $TARGET.

Next steps (one time):
  1. Cursor Settings > Features > enable "Include third-party Plugins, Skills, and other configs"
  2. Fully quit Cursor (Cmd+Q) and relaunch — "Reload Window" is unreliable.
  3. Cursor Settings > MCP > tierzero > click "Authorize", log in to TierZero in the browser.

Verify after launch:
  - Settings > Plugins lists "TierZero" as enabled
  - Settings > MCP shows the "tierzero" server as healthy
  - Typing "/" in chat shows /tierzero and /tierzero-fetch
EOF
