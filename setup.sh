#!/usr/bin/env bash
set -euo pipefail

# CCSkills - First-time setup
# Usage: ./setup.sh

echo "=== CCSkills Setup ==="
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

# Create Claude hooks directory
CLAUDE_HOOKS_DIR="$HOME/.claude/hooks"
mkdir -p "$CLAUDE_HOOKS_DIR"

# Install hooks
echo "Installing hooks to ~/.claude/hooks/..."
cp hooks/block-rm.sh "$CLAUDE_HOOKS_DIR/"
chmod +x "$CLAUDE_HOOKS_DIR/block-rm.sh"

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Hooks installed:"
echo "  - block-rm.sh (PreToolUse hook)"
echo ""
echo "Next steps:"
echo "  1. Add hooks to your ~/.claude/settings.json"
echo "  2. See hooks-example.json for configuration"
echo "  3. Restart Claude Code to apply changes"
echo ""
echo "Example configuration for ~/.claude/settings.json:"
echo ""
cat hooks-example.json
echo ""
echo "For more details, see README.md"