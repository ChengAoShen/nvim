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
opt.completeopt = { "menu", "menuone", "noselect" }
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
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.exrc = true
opt.cursorline = true
opt.autoread = true

vim.o.guifont = "FiraCode Nerd Font Mono:h18"

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
})
