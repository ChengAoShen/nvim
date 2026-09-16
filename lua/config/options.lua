local opt = vim.opt
opt.showmode = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menu", "menuone", "noselect" }
-- Colours and highlight groups are owned by config/colors.lua.
opt.termguicolors = true
opt.signcolumn = "yes"
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.wrap = false
opt.linebreak = true
opt.textwidth = 88
opt.colorcolumn = "88"
opt.mouse = "a"
opt.undofile = true
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.exrc = true
opt.cursorline = true
-- Open files fully unfolded. Folds come from treesitter (plugins/treesitter.lua)
-- or a filetype's own foldexpr (e.g. VimTeX); without this, Neovim's default
-- foldlevel=0 closes every one of them on open.
opt.foldlevelstart = 99

vim.o.guifont = "FiraCode Nerd Font Mono:h18"

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
})
