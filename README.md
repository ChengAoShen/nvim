# Neovim configs

This is my personal nvim config, including various plugins and settings.

## Install

Linux/MacOS

```bash
git clone https://github.com/ChengAoShen/nvim ~/.config/nvim
```

Extra requirements: `tree-sitter` CLI (`npm install -g tree-sitter-cli`), a C
compiler, and git. LSP servers and formatters are installed automatically by
mason, driven by `lua/lang.lua`.

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point: leader + config.* requires
├── lua/
│   ├── lang.lua                # Per-language registry: LSP / treesitter / formatters
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim bootstrap & setup
│   │   ├── options.lua         # vim options & diagnostics appearance
│   │   ├── keymaps.lua         # Global keymaps
│   │   └── autocmds.lua        # Autosave, yank highlight, autoread
│   └── plugins/
│       ├── completion.lua      # blink.cmp
│       ├── lsp.lua             # mason, lspconfig, schemastore, lazydev
│       ├── format.lua          # conform
│       ├── rust.lua            # rustaceanvim
│       ├── treesitter.lua      # Parser install & folding
│       ├── editor.lua          # Editing tools & navigation
│       ├── git.lua             # Gitsigns, diffview
│       └── ui.lua              # Theme, statusline, snacks, noice
```

To add a language, edit `lua/lang.lua` only: declare its mason packages, LSP
server configs, treesitter parsers, and formatters in one entry.

## Keybindings

Leader key: `<Space>`

### General

| Key | Mode | Action |
|-----|------|--------|
| `jj` | Insert | Escape to Normal mode |
| `<Space>nh` | Normal | Clear search highlight |
| `]b` / `[b` | Normal | Next / Prev buffer |
| `J` / `K` | Visual | Move selection down / up |
| `<Tab>` / `<CR>` | Insert | Accept completion |

### Diagnostics & LSP

| Key | Mode | Action |
|-----|------|--------|
| `gh` | Normal | Open diagnostic float |
| `<Space>q` | Normal | Diagnostics to location list |
| `[d` / `]d` | Normal | Prev / Next diagnostic (builtin) |
| `gd` / `gD` | Normal | Go to definition / declaration |
| `K` | Normal | Hover documentation (builtin) |
| `grn` / `gra` / `grr` / `gri` | Normal | Rename / Code action / References / Implementation (builtin) |
| `<C-k>` | Normal | Signature help |
| `<Space>th` | Normal | Toggle inlay hints |
| `<Space>fm` | Normal/Visual | Format buffer / selection (conform) |

### Rust (rust buffers only)

| Key | Mode | Action |
|-----|------|--------|
| `K` | Normal | Hover + actions |
| `<Space>rca` | Normal | Rust code action |

### Search & files (snacks)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ff` | Normal | Find files |
| `<Space>fg` | Normal | Live grep |
| `<Space><Space>` | Normal | Switch buffer |
| `<Space>fh` | Normal | Help tags |
| `<Space>?` | Normal | Recent files |
| `<Space>/` | Normal | Search in current buffer |
| `<C-n>` | Normal/Terminal | Toggle file explorer |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<Space>h/j/k/l` | Normal/Terminal | Navigate window / tmux pane |
| `<Space>;` | Normal | Pick winbar symbol (dropbar) |
| `[;` / `];` | Normal | Go to context start / next context |
| `s` / `S` | Normal/Visual/Op | Flash jump / Flash treesitter |
| `r` / `R` | Op / Op+Visual | Remote flash / Treesitter search |
| `<C-s>` | Cmdline | Toggle flash during search |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `gcc` / `gc` | Normal / Visual | Toggle comment (builtin) |
| `ys{motion}{char}` | Normal | Add surround (e.g. `ysiw"`) |
| `ds{char}` | Normal | Delete surround |
| `cs{old}{new}` | Normal | Change surround |
| `]t` / `[t` | Normal | Next / Prev todo comment |
| `<Space>ft` | Normal | Todo comments picker |

### Git (gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `]h` / `[h` | Normal | Next / Prev hunk |
| `<Space>gs` / `<Space>gr` | Normal | Stage / Reset hunk |
| `<Space>gp` | Normal | Preview hunk |
| `<Space>gd` | Normal | Diff this file |
| `<Space>gb` / `<Space>gB` | Normal | Blame line / Toggle line blame |
| `ih` | Op/Visual | Select hunk text object |

### Misc

| Key | Mode | Action |
|-----|------|--------|
| `<Space>tm` | Normal | Toggle markdown render |
| `:Screenkey` | Command | Toggle on-screen keypress display |
