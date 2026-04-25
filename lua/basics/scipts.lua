-- autosave
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        vim.fn.execute("silent! write")
    end,
})

-- yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank({ higroup = 'Visual', timeout = 200 })
    end
})

-- auto update
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    pattern = "*",
    command = "checktime",
})

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
require("lazy").setup("plugins")
