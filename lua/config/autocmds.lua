-- 2-space indent for JS/TS/JSON
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "json" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- Autosave on InsertLeave (real, writable, modified file buffers only)
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].buftype ~= "" then return end
        if not vim.bo[buf].modifiable or vim.bo[buf].readonly then return end
        if not vim.bo[buf].modified then return end
        if vim.api.nvim_buf_get_name(buf) == "" then return end
        vim.cmd("silent! write")
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- Reload externally-modified files (autoread is set in options.lua)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    pattern = "*",
    command = "checktime",
})
