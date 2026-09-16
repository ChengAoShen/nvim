-- Side-by-side diff needs roughly two full code columns plus the file panel.
-- Below this terminal width we stack the two versions instead.
local WIDE_ENOUGH = 180

local function open_diffview(cmd)
    return function()
        local layout = vim.o.columns >= WIDE_ENOUGH and "diff2_horizontal" or "diff2_vertical"
        local view = require("diffview.config").get_config().view
        view.default.layout = layout
        view.file_history.layout = layout
        vim.cmd(cmd)
    end
end

return {
    -- Git diff viewer
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", open_diffview("DiffviewOpen"),           desc = "Diff working tree" },
            { "<leader>gD", "<cmd>DiffviewClose<cr>",                desc = "Close diffview" },
            { "<leader>gh", open_diffview("DiffviewFileHistory %"),  desc = "File history" },
            { "<leader>gH", open_diffview("DiffviewFileHistory"),    desc = "Branch history" },
        },
        opts = {
            file_panel = {
                listing_style = "list",
                win_config = { position = "left", width = 30 },
            },
            file_history_panel = {
                win_config = { position = "bottom", height = 14 },
            },
            hooks = {
                -- Start with the panel collapsed; <leader>b toggles it back.
                view_opened = function(view)
                    if view.panel and view.panel:is_open() then
                        view.panel:close()
                    end
                end,
            },
        },
    },

    -- Git signs / hunk operations / inline blame
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                vim.keymap.set("n", "]h", function() gs.nav_hunk("next") end, { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h", function() gs.nav_hunk("prev") end, { buffer = bufnr, desc = "Prev hunk" })
                vim.keymap.set("n", "<leader>gu", function() gs.diff(nil, nil, { diff = "unified" }) end,
                    { buffer = bufnr, desc = "Unified diff panel" })
                vim.keymap.set("n", "<leader>gp", gs.preview_hunk_inline,
                    { buffer = bufnr, desc = "Preview hunk inline" })
            end,
        },
    },
}
