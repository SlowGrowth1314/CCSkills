# Contributing to CCSkills

Thank you for your interest in contributing to CCSkills!

## Development Setup

```bash
git clone https://github.com/SlowGrowth1314/CCSkills.git
cd CCSkills
./setup.sh
```

## Prerequisites

- macOS (for osascript notifications)
- [jq](https://stedolan.github.io/jq/) - JSON processor
- Claude Code CLI

## Project Structure

```
CCSkills/
├── hooks/                 # Hook scripts
│   └── block-rm.sh       # Safety hook implementation
├── hooks-example.json    # Sample configuration
├── setup.sh              # Installation script
├── LICENSE               # MIT License
├── README.md             # Documentation
└── CONTRIBUTING.md        # This file
```

## Adding New Hooks

1. Create a new shell script in `hooks/`
2. Make it executable: `chmod +x hooks/your-hook.sh`
3. Add configuration example to `hooks-example.json`
4. Update README.md with hook documentation
5. Test thoroughly before submitting PR

### Hook Script Template

```bash
#!/bin/bash
# your-hook.sh - Brief description
# Hook type: PreToolUse | PostToolUse | PermissionRequest | Stop

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')
tool_input=$(echo "$input" | jq -r '.tool_input')

# Your logic here
# Exit 0 to allow, exit 2 to block

exit 0
```

## Hook Types

| Type | When It Runs | Use Case |
|------|--------------|----------|
| PreToolUse | Before tool execution | Block dangerous commands |
| PostToolUse | After tool execution | Auto-format, validation |
| PermissionRequest | When Claude requests permission | Notifications |
| Stop | When session ends | Cleanup, notifications |

## Code Style

- Use `set -euo pipefail` for safety
- Add descriptive comments at the top of scripts
- Use `jq -r` for JSON parsing
- Exit 0 to allow, exit 2 to block (PreToolUse only)
- Write error messages to stderr

## Testing Hooks

Test your hooks manually before submitting:

```bash
# Test block-rm.sh
echo '{"tool_name":"Bash","tool_input":{"command":"rm test.txt"}}' | bash hooks/block-rm.sh
echo $?  # Should be 2 (blocked)

echo '{"tool_name":"Bash","tool_input":{"command":"ls -la"}}' | bash hooks/block-rm.sh
echo $?  # Should be 0 (allowed)
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-hook`
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Using Claude Code

This project is designed to work with Claude Code. The hooks integrate directly with Claude Code's hook system.

```bash
claude    # Start Claude Code - reads CLAUDE.md for context
```

## Reporting Issues

Use GitHub Issues for bug reports and feature requests. Include:

- macOS version
- Claude Code version
- Steps to reproduce
- Expected vs actual behavior

## License

By contributing, you agree that your contributions will be licensed under the MIT License.