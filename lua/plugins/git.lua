-- Ordered by repository name.

-- Side by side needs two code columns plus the file panel; below this width
-- the two versions stack instead.
local WIDE_ENOUGH = 180

local function open_diffview(cmd)
    return function()
        local layout = vim.o.columns >= WIDE_ENOUGH and "diff2_horizontal"
            or "diff2_vertical"
        local view = require("diffview.config").get_config().view
        view.default.layout = layout
        view.file_history.layout = layout
        vim.cmd(cmd)
    end
end

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local function map(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
                end
                map("]h", function()
                    gs.nav_hunk("next")
                end, "Next hunk")
                map("[h", function()
                    gs.nav_hunk("prev")
                end, "Prev hunk")
                map("<leader>gu", function()
                    gs.diff(nil, nil, { diff = "unified" })
                end, "Unified diff panel")
                map("<leader>gp", gs.preview_hunk_inline, "Preview hunk inline")
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", open_diffview("DiffviewOpen"), desc = "Diff working tree" },
            { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
            {
                "<leader>gh",
                open_diffview("DiffviewFileHistory %"),
                desc = "File history",
            },
            {
                "<leader>gH",
                open_diffview("DiffviewFileHistory"),
                desc = "Branch history",
            },
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
                -- Start collapsed; <leader>b toggles the panel back.
                view_opened = function(view)
                    if view.panel and view.panel:is_open() then
                        view.panel:close()
                    end
                end,
            },
        },
    },
}
