local opt = vim.opt
opt.showmode = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.wildmenu = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = { "menu", "noselect" }
opt.termguicolors = true
opt.signcolumn = "yes"
opt.autoread = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 50
opt.wrap = false
opt.linebreak = true
opt.textwidth = 88
opt.mouse = "a"
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.exrc = true
opt.cursorline = true

vim.wo.colorcolumn = "88"
vim.o.guifont = "FiraCode Nerd Font Mono:h18"

-- Seeting global language options
vim.g.language = {
    python = true,
    rust = false,
    lua = true,
    json = true,
    swift = false,
}
