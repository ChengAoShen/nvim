# Neovim configs

This is my personal nvim configs file, which including various plugins and
settings.

## Install

Linux/MacOS

```bash
git clone https://github.com/ChengAoShen/nvim ~/.config/nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── basics/
│   │   ├── configs.lua         # General settings
│   │   ├── keymaps.lua         # Global keymaps
│   │   └── scipts.lua          # Autocommands & lazy.nvim bootstrap
│   └── plugins/
│       ├── ai.lua              # AI integration (Claude Code)
│       ├── appearance.lua      # UI, theme, statusline, snacks
│       ├── cmp.lua             # Completion (blink.cmp)
│       ├── format.lua          # Formatting (conform.nvim)
│       ├── lsp.lua             # LSP & Mason
│       └── utils.lua           # Editing tools & navigation
```

## Keybindings

Leader key: `<Space>`

### General

| Key | Mode | Action |
|-----|------|--------|
| `jj` | Insert | Escape to Normal mode |
| `<Space>nh` | Normal | Clear search highlight |
| `<Alt-Tab>` | Normal | Next buffer |
| `J` | Visual | Move selection down |
| `K` | Visual | Move selection up |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `gcc` / `gc` | Normal / Visual | Toggle comment |
| `ys{motion}{char}` | Normal | Add surround (e.g. `ysiw"`) |
| `ds{char}` | Normal | Delete surround (e.g. `ds"`) |
| `cs{old}{new}` | Normal | Change surround (e.g. `cs"'`) |
| `<Tab>` / `<CR>` | Insert | Accept completion |

### Diagnostics & LSP

| Key | Mode | Action |
|-----|------|--------|
| `<Space>e` | Normal | Open diagnostic float |
| `[d` / `]d` | Normal | Prev / Next diagnostic |
| `gd` | Normal | Go to definition |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | References |
| `K` | Normal | Hover documentation |
| `<Space>rn` | Normal | Rename symbol |
| `<Space>ca` | Normal | Code action |

### Search (snacks.picker)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ff` | Normal | Find files |
| `<Space>fg` | Normal | Live grep |
| `<Space><Space>` | Normal | Switch buffer |
| `<Space>fh` | Normal | Help tags |
| `<Space>?` | Normal | Recent files |
| `<Space>/` | Normal | Search in current buffer |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<Space>h` | Normal/Terminal | Navigate left window |
| `<Space>j` | Normal/Terminal | Navigate down window |
| `<Space>k` | Normal/Terminal | Navigate up window |
| `<Space>l` | Normal/Terminal | Navigate right window |
| `<C-n>` | Normal/Terminal | Toggle file tree |

### Jump (flash.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal/Visual | Flash jump |
| `S` | Normal/Visual | Flash treesitter |

### Claude Code

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ac` | Normal | Toggle Claude terminal |
| `<Space>af` | Normal | Focus Claude terminal |
| `<Space>ar` | Normal | Resume conversation |
| `<Space>aC` | Normal | Continue conversation |
| `<Space>am` | Normal | Select model |
| `<Space>ab` | Normal | Add current buffer to context |
| `<Space>as` | Visual | Send selection to Claude |
| `<Space>aa` | Normal | Accept diff |
| `<Space>ad` | Normal | Deny diff |
