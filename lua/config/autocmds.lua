-- Editor-wide autocommands; plugin- and language-specific ones live with that
-- plugin spec or language file. One group, cleared on load, so re-sourcing
-- this file replaces them rather than stacking a second copy.
local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

local function autocmd(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end

-- Autosave real files only: no terminals, pickers, scratch or unnamed buffers.
autocmd("InsertLeave", {
    callback = function(ev)
        local bo = vim.bo[ev.buf]
        if bo.buftype ~= "" or bo.readonly or not bo.modifiable or not bo.modified then
            return
        end
        if vim.api.nvim_buf_get_name(ev.buf) == "" then
            return
        end
        vim.cmd("silent! write")
    end,
})

autocmd("TextYankPost", {
    desc = "Briefly highlight the yanked text",
    callback = function()
        vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    desc = "Reload files changed outside Neovim ('autoread' is on by default)",
    command = "checktime",
})

autocmd("FileType", {
    desc = "2-space indent for JS/TS/JSON",
    pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})
