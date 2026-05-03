return {
    -- Git diff viewer
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = true,
    },

    -- Git signs / hunk operations / inline blame
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = false,
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end
                map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
                map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>gd", gs.diffthis, "Diff this")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
            end,
        },
    },
}
