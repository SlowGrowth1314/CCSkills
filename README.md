# CCSkills

Claude Code Hooks Collection - macOS notification and safety hooks for Claude Code CLI.

## Features

- **block-rm.sh** - Prevents dangerous `rm` commands, forces use of Trash instead
- **macOS Notifications** - Native notifications for permission requests and task completion
- **Easy Setup** - One-command installation via `setup.sh`

## Quick Start

```bash
git clone https://github.com/SlowGrowth1314/CCSkills.git
cd CCSkills
./setup.sh
```

## Prerequisites

- macOS (for notifications via osascript)
- [jq](https://stedolan.github.io/jq/) - JSON processor (auto-installed by setup.sh if missing)
- Claude Code CLI

## Installation

### Automatic Installation

```bash
./setup.sh
```

The script will:
1. Check for `jq` dependency
2. Copy hooks to `~/.claude/hooks/`
3. Display instructions for enabling hooks in settings

### Manual Installation

1. Copy hooks to your Claude config:
   ```bash
   mkdir -p ~/.claude/hooks
   cp hooks/block-rm.sh ~/.claude/hooks/
   chmod +x ~/.claude/hooks/block-rm.sh
   ```

2. Add hook configuration to `~/.claude/settings.json`:
   ```json
   {
     "hooks": {
       "PreToolUse": [
         {
           "hooks": [
             {
               "command": "bash ~/.claude/hooks/block-rm.sh",
               "type": "command"
             }
           ]
         }
       ]
     }
   }
   ```

## Hooks

### block-rm.sh

Prevents Claude Code from executing `rm` commands. Forces use of `mv <file> ~/.Trash/` instead.

**Why?** The `rm` command is irreversible. This hook prevents accidental data loss by blocking all `rm` commands and prompting safer alternatives.

**Hook type:** PreToolUse

**Blocked patterns:**
- `rm file.txt`
- `rm -rf directory/`
- `rm -rf /*` (especially this one)
- Any command containing `rm` with arguments

### macOS Notifications

Native macOS notifications for Claude Code events:

| Event | Sound | Purpose |
|-------|-------|---------|
| PermissionRequest | Hero | Claude requests permission |
| Stop | Pop | Task completed |

**Hook types:** PermissionRequest, Stop

## Configuration

See `hooks-example.json` for a complete configuration example.

To enable all hooks, merge the contents of `hooks-example.json` into your `~/.claude/settings.json`:

```bash
# View current settings
cat ~/.claude/settings.json

# View example hooks
cat hooks-example.json
```

## Using with Claude Code

This project includes documentation that Claude Code can read for context:

```bash
claude    # Start Claude Code - it reads project context automatically
```

## Files

```
CCSkills/
├── hooks/
│   └── block-rm.sh        # Safety hook - blocks rm commands
├── hooks-example.json     # Sample hooks configuration
├── setup.sh               # One-command installation
├── LICENSE                # MIT License
├── README.md              # This file
└── CONTRIBUTING.md        - Contribution guidelines
```

## License

MIT License - see [LICENSE](LICENSE)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)