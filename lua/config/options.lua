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
opt.mouse = "a"
opt.wrap = false
opt.linebreak = true
opt.textwidth = 88 -- used by gq and formatters; typing never auto-wraps
opt.colorcolumn = "88"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.swapfile = false
opt.undofile = true
opt.updatetime = 250
opt.exrc = true

-- Windows
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"

-- Open files unfolded: folds come from treesitter or a filetype's own foldexpr
-- (VimTeX), and Neovim's default foldlevel=0 would close every one on open.
opt.foldlevelstart = 99

-- No remote plugins are used; skip the language providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
})
