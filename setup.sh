#!/usr/bin/env bash
set -euo pipefail

# CCSkills - Fully automated setup
# Usage: ./setup.sh [--dry-run]

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE - No changes will be made ==="
    echo ""
fi

echo "=== CCSkills Automated Setup ==="
echo ""

# Check prerequisites
command -v jq >/dev/null 2>&1 || {
    echo "jq is required but not installed."
    echo ""
    if command -v brew >/dev/null 2>&1; then
        echo "Installing jq via Homebrew..."
        brew install jq
    else
        echo "Error: Homebrew not found. Please install jq manually:"
        echo "  brew install jq"
        echo "  or visit: https://stedolan.github.io/jq/"
        exit 1
    fi
}

# Paths
CLAUDE_DIR="$HOME/.claude"
CLAUDE_HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
HOOKS_EXAMPLE="$(pwd)/hooks-example.json"

# Create directories
echo "Creating directories..."
if [[ "$DRY_RUN" == "false" ]]; then
    mkdir -p "$CLAUDE_HOOKS_DIR"
fi

# Install hooks
echo "Installing hooks to ~/.claude/hooks/..."
if [[ "$DRY_RUN" == "false" ]]; then
    cp hooks/block-rm.sh "$CLAUDE_HOOKS_DIR/"
    chmod +x "$CLAUDE_HOOKS_DIR/block-rm.sh"
fi

# Configure settings.json
echo ""
echo "Configuring ~/.claude/settings.json..."

if [[ "$DRY_RUN" == "false" ]]; then
    if [[ -f "$SETTINGS_FILE" ]]; then
        # Merge hooks into existing settings
        echo "Merging hooks with existing settings..."

        # Read existing settings
        EXISTING=$(cat "$SETTINGS_FILE")

        # Read hooks config
        HOOKS_CONFIG=$(cat "$HOOKS_EXAMPLE")

        # Merge using jq - deep merge to preserve existing settings
        MERGED=$(echo "$EXISTING" "$HOOKS_CONFIG" | jq -s 'def deep_merge(a; b):
            b | to_entries |
            reduce .[] as $item (a;
                if ($item.key | IN("hooks")) then
                    .[$item.key] = deep_merge(.[$item.key] // {}; $item.value)
                else
                    .[$item.key] = $item.value
                end
            );
        deep_merge(.[0]; .[1])')

        # Write merged settings
        echo "$MERGED" > "$SETTINGS_FILE"

        echo "Settings merged successfully!"
    else
        # Create new settings file
        echo "Creating new settings.json..."
        mkdir -p "$CLAUDE_DIR"
        cp "$HOOKS_EXAMPLE" "$SETTINGS_FILE"
        echo "Settings created successfully!"
    fi
else
    echo "[DRY RUN] Would configure settings.json"
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Installed hooks:"
echo "  ✓ block-rm.sh → ~/.claude/hooks/block-rm.sh"
echo ""
echo "Configuration:"
echo "  ✓ Hooks added to ~/.claude/settings.json"
echo ""
echo "Hooks enabled:"
echo "  • PermissionRequest - macOS notification on permission request"
echo "  • PreToolUse - Blocks rm commands (safety protection)"
echo "  • Stop - macOS notification on task completion"
echo ""
echo "Restart Claude Code to apply changes:"
echo "  claude"
echo ""
echo "Test the rm blocker:"
echo "  Ask Claude to run 'rm test.txt' - it will be blocked!"
echo ""
echo "For more info: https://github.com/SlowGrowth1314/CCSkills"