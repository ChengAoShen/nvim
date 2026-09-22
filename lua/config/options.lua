-- Editor options. Only settings that differ from Neovim's defaults live here.
local opt = vim.opt

-- Indentation (2-space filetypes are overridden in config/autocmds.lua)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true

-- UI
opt.showmode = false -- the mode is already in lualine
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes" -- always reserve it, so the text never shifts
opt.termguicolors = true -- colours and highlight groups: config/colors.lua
opt.guifont = "FiraCode Nerd Font Mono:h18"
opt.mouse = "a"

-- `wrap` is off, so `linebreak` only matters where a filetype turns wrapping
-- back on (tex).
opt.wrap = false
opt.linebreak = true
opt.textwidth = 88
opt.colorcolumn = "88"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- `noselect`: nothing is preselected, so <CR> inserts a newline until an entry
-- is explicitly picked.
opt.completeopt = { "menu", "menuone", "noselect" }

opt.swapfile = false
opt.undofile = true
opt.updatetime = 250 -- also drives CursorHold (autoread, LSP highlights)
opt.exrc = true -- trust per-project .nvim.lua; Neovim asks before sourcing

-- Windows
opt.splitright = true
opt.splitbelow = true
opt.clipboard:append("unnamedplus")

-- Open files unfolded: folds come from treesitter or a filetype's own foldexpr
-- (VimTeX), and Neovim's default foldlevel=0 would close every one on open.
opt.foldlevelstart = 99

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
})
