return {
    -- Activity tracking (WakaTime)
    {
        "wakatime/vim-wakatime",
        event = "VeryLazy",
    },

    -- Seamless window/tmux navigation
    {
        "mrjones2014/smart-splits.nvim",
        lazy = true,
        keys = {
            { "<leader>g", function() require("smart-splits").move_cursor_left() end,  mode = { "n", "t" } },
            { "<leader>j", function() require("smart-splits").move_cursor_down() end,  mode = { "n", "t" } },
            { "<leader>k", function() require("smart-splits").move_cursor_up() end,    mode = { "n", "t" } },
            { "<leader>l", function() require("smart-splits").move_cursor_right() end, mode = { "n", "t" } },
        },
    },

    -- Enhanced jump/search motions
    {
        "folke/flash.nvim",
        lazy = true,
        config = true,
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc = "Flash"
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc = "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc = "Toggle Flash Search"
            },
        },
    },

    -- Git diff viewer
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = true
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
