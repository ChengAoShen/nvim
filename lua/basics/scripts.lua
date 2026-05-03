-- autosave
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].buftype ~= "" then return end
        if not vim.bo[buf].modifiable or vim.bo[buf].readonly then return end
        if not vim.bo[buf].modified then return end
        if vim.api.nvim_buf_get_name(buf) == "" then return end
        vim.cmd("silent! write")
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
