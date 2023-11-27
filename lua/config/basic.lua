local opt = vim.opt

-- Global Settings --
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
opt.textwidth = 80
opt.mouse = "a"
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undo")
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.exrc = true

vim.wo.colorcolumn = "80"
vim.o.guifont = "Fira Code:h18"
-- vim.o.guifont = "Monaspace Radon:h20"
-- vim.g.neovide_transparency = 0.9

-- autosave
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        vim.fn.execute("silent! write")
    end,
})

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
