# Neovim configs

This is my personal nvim config, including various plugins and settings.

## Install

Linux/MacOS

```bash
git clone https://github.com/ChengAoShen/nvim ~/.config/nvim
```

Extra requirements: `tree-sitter` CLI (`npm install -g tree-sitter-cli`), a C
compiler, and git. LSP servers and formatters are installed automatically by
mason, driven by `lua/langs/`.

## Structure

```
~/.config/nvim/
├── init.lua                # Entry point: leader + config.* requires
├── dprint.json             # Fallback dprint config (markdown, yaml, html, css)
├── .stylua.toml            # Lua formatting rules
└── lua/
    ├── lang.lua            # Aggregates lua/langs/ into one registry
    ├── langs/              # One file per language; delete it to drop the language
    │   ├── c.lua           # (disabled)
    │   ├── json.lua        # jsonls + SchemaStore, biome
    │   ├── lean.lua        # lean.nvim (LSP ships with elan/lake)
    │   ├── lua.lua         # lua_ls + lazydev, stylua
    │   ├── markdown.lua    # render-markdown, dprint
    │   ├── python.lua      # ruff + ty
    │   ├── rust.lua        # rustaceanvim + taplo
    │   ├── tex.lua         # VimTeX + texlab, latexindent
    │   └── typescript.lua  # vtsls, biome
    ├── config/
    │   ├── lazy.lua        # lazy.nvim bootstrap & setup
    │   ├── options.lua     # vim options & diagnostics appearance
    │   ├── keymaps.lua     # Global keymaps
    │   ├── autocmds.lua    # Autosave, yank highlight, autoread
    │   └── colors.lua      # catppuccin & every highlight override
    └── plugins/
        ├── completion.lua  # blink.cmp
        ├── lsp.lua         # mason, lspconfig
        ├── format.lua      # conform
        ├── treesitter.lua  # Parser install & folding
        ├── langs.lua       # Plugin specs contributed by lua/langs/
        ├── editor.lua      # Editing tools & navigation
        ├── git.lua         # gitsigns, diffview
        └── ui.lua          # Theme, statusline, snacks, noice
```

To add a language, add one file to `lua/langs/`: declare its mason packages,
LSP server configs, treesitter parsers, formatters and plugins in one table.
Set `enabled = false` to turn it off without deleting it.

## Keybindings

Leader: `<Space>`. Local leader: `\`.

### General

| Key | Mode | Action |
|-----|------|--------|
| `jj` | Insert | Escape to Normal mode |
| `<Space>nh` | Normal | Clear search highlight |
| `]b` / `[b` | Normal | Next / Prev buffer |
| `J` / `K` | Visual | Move selection down / up |
| `<M-h>` / `<M-l>` | Normal/Visual | Move line / selection left / right |
| `<M-j>` / `<M-k>` | Normal | Move current line down / up |
| `<Tab>` / `<S-Tab>` | Insert | Next / Prev completion item, snippet jump |
| `<CR>` | Insert | Accept completion |

### Diagnostics & LSP

| Key | Mode | Action |
|-----|------|--------|
| `gh` | Normal | Open diagnostic float |
| `<Space>q` | Normal | Diagnostics to location list |
| `[d` / `]d` | Normal | Prev / Next diagnostic (builtin) |
| `gd` / `gD` | Normal | Go to definition / declaration |
| `K` | Normal | Hover documentation (builtin) |
| `grn` / `gra` / `grr` / `gri` / `grt` / `gO` | Normal | Rename / Code action / References / Implementation / Type definition / Symbols (builtin) |
| `<C-k>` | Normal | Signature help |
| `<Space>th` / `<Space>tH` | Normal | Toggle inlay hints (buffer / global) |
| `<Space>fm` | Normal/Visual | Format buffer / selection |

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
| `<C-\>` | Normal/Terminal | Toggle terminal |
| `<Space>tt` | Normal | New terminal |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<Space>h/j/k/l` | Normal | Navigate window / tmux pane |
| `<C-h/j/k/l>` | Terminal | Navigate window / tmux pane |
| `<Space>;` | Normal | Pick winbar symbol (dropbar) |
| `[;` / `];` | Normal | Go to context start / next context |
| `s` | Normal/Visual/Op | Flash jump |
| `S` | Normal/Op | Flash treesitter (visual `S` is surround) |
| `r` / `R` | Op / Op+Visual | Remote flash / Treesitter search |
| `<C-s>` | Cmdline | Toggle flash during search |

### Editing

| Key | Mode | Action |
|-----|------|--------|
| `gcc` / `gc` | Normal / Visual | Toggle comment (builtin) |
| `ys{motion}{char}` | Normal | Add surround (e.g. `ysiw"`) |
| `S{char}` / `gS{char}` | Visual | Add surround / on new lines |
| `ds{char}` | Normal | Delete surround |
| `cs{old}{new}` | Normal | Change surround |
| `]t` / `[t` | Normal | Next / Prev todo comment |
| `<Space>ft` | Normal | Todo comments picker |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `]h` / `[h` | Normal | Next / Prev hunk |
| `<Space>gp` | Normal | Preview hunk inline |
| `<Space>gu` | Normal | Unified diff panel |
| `<Space>gd` / `<Space>gD` | Normal | Open / Close diffview |
| `<Space>gh` / `<Space>gH` | Normal | File history / Branch history |
| `<Space>gg` | Normal | Lazygit |
| `<Space>gf` / `<Space>gl` | Normal | Lazygit file history / log |
| `<Space>gb` | Normal | Git blame line |
| `<Space>gs` | Normal | Git status picker |

### Language-specific

| Key | Mode | Action |
|-----|------|--------|
| `K` / `<Space>rca` | Normal (rust) | Hover + actions / Code action |
| `\l…` | Normal (tex) | VimTeX commands (localleader is `\`) |
| `gK` | Normal (tex) | Open package docs (texdoc) |
| `<Space>tc` | Normal (tex) | Toggle conceal (raw LaTeX) |
| `<Space>tm` | Normal (markdown) | Toggle markdown render |

### Misc

| Key | Mode | Action |
|-----|------|--------|
| `:Screenkey` | Command | Toggle on-screen keypress display |
| `:TSManager` | Command | Treesitter parser manager |
| `:Mason` | Command | LSP / tool installer |
| `:Lazy` | Command | Plugin manager |
