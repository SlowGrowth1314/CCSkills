# CCSkills

[English](#english) | [中文](#中文)

---

<a name="english"></a>
## English

Claude Code Hooks Collection - macOS notification and safety hooks for Claude Code CLI.

### Features

- **block-rm.sh** - Prevents dangerous `rm` commands, forces use of Trash instead
- **macOS Notifications** - Native notifications for permission requests and task completion
- **Easy Setup** - One-command installation via `setup.sh`

### Quick Start

```bash
git clone https://github.com/SlowGrowth1314/CCSkills.git
cd CCSkills
./setup.sh
```

### Prerequisites

- macOS (for notifications via osascript)
- [jq](https://stedolan.github.io/jq/) - JSON processor (auto-installed by setup.sh if missing)
- Claude Code CLI

### Installation

#### Automatic Installation

```bash
./setup.sh
```

The script will:
1. Check for `jq` dependency
2. Copy hooks to `~/.claude/hooks/`
3. Display instructions for enabling hooks in settings

#### Manual Installation

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

### Hooks

#### block-rm.sh

Prevents Claude Code from executing `rm` commands. Forces use of `mv <file> ~/.Trash/` instead.

**Why?** The `rm` command is irreversible. This hook prevents accidental data loss by blocking all `rm` commands and prompting safer alternatives.

**Hook type:** PreToolUse

**Blocked patterns:**
- `rm file.txt`
- `rm -rf directory/`
- `rm -rf /*` (especially this one)
- Any command containing `rm` with arguments

#### macOS Notifications

Native macOS notifications for Claude Code events:

| Event | Sound | Purpose |
|-------|-------|---------|
| PermissionRequest | Hero | Claude requests permission |
| Stop | Pop | Task completed |

**Hook types:** PermissionRequest, Stop

### Configuration

See `hooks-example.json` for a complete configuration example.

To enable all hooks, merge the contents of `hooks-example.json` into your `~/.claude/settings.json`:

```bash
# View current settings
cat ~/.claude/settings.json

# View example hooks
cat hooks-example.json
```

### Files

```
CCSkills/
├── hooks/
│   └── block-rm.sh        # Safety hook - blocks rm commands
├── hooks-example.json     # Sample hooks configuration
├── setup.sh               # One-command installation
├── LICENSE                # MIT License
├── README.md              # This file
└── CONTRIBUTING.md        # Contribution guidelines
```

### License

MIT License - see [LICENSE](LICENSE)

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

---

<a name="中文"></a>
## 中文

Claude Code Hooks 集合 - 为 Claude Code CLI 提供 macOS 通知和安全防护钩子。

### 功能特性

- **block-rm.sh** - 阻止危险的 `rm` 命令，强制使用回收站
- **macOS 通知** - 权限请求和任务完成时的原生通知
- **一键安装** - 通过 `setup.sh` 快速配置

### 快速开始

```bash
git clone https://github.com/SlowGrowth1314/CCSkills.git
cd CCSkills
./setup.sh
```

### 系统要求

- macOS（通知功能依赖 osascript）
- [jq](https://stedolan.github.io/jq/) - JSON 处理器（如缺失，setup.sh 会自动安装）
- Claude Code CLI

### 安装方式

#### 自动安装

```bash
./setup.sh
```

脚本会执行以下操作：
1. 检查 `jq` 依赖
2. 复制钩子到 `~/.claude/hooks/`
3. 显示配置启用指引

#### 手动安装

1. 复制钩子到 Claude 配置目录：
   ```bash
   mkdir -p ~/.claude/hooks
   cp hooks/block-rm.sh ~/.claude/hooks/
   chmod +x ~/.claude/hooks/block-rm.sh
   ```

2. 在 `~/.claude/settings.json` 中添加钩子配置：
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

### 钩子说明

#### block-rm.sh - rm 命令防护

阻止 Claude Code 执行 `rm` 命令，强制使用 `mv <file> ~/.Trash/` 替代。

**为什么需要？** `rm` 命令不可逆，此钩子防止意外数据丢失，提示使用更安全的替代方案。

**钩子类型：** PreToolUse

**拦截模式：**
- `rm file.txt`
- `rm -rf directory/`
- `rm -rf /*`（尤其重要）
- 任何包含 `rm` 的命令

#### macOS 通知

Claude Code 事件的 macOS 原生通知：

| 事件 | 声音 | 用途 |
|------|------|------|
| PermissionRequest | Hero | Claude 请求权限 |
| Stop | Pop | 任务完成 |

**钩子类型：** PermissionRequest, Stop

### 配置示例

完整配置见 `hooks-example.json`。

启用所有钩子：将 `hooks-example.json` 内容合并到 `~/.claude/settings.json`：

```bash
# 查看当前配置
cat ~/.claude/settings.json

# 查看钩子示例
cat hooks-example.json
```

### 项目结构

```
CCSkills/
├── hooks/
│   └── block-rm.sh        # 安全钩子 - 阻止 rm 命令
├── hooks-example.json     # 钩子配置示例
├── setup.sh               # 一键安装脚本
├── LICENSE                # MIT 许可证
├── README.md              # 本文件
└── CONTRIBUTING.md        # 贡献指南
```

### 许可证

MIT License - 详见 [LICENSE](LICENSE)

### 贡献指南

详见 [CONTRIBUTING.md](CONTRIBUTING.md)