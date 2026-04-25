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
            { "<leader>h", function() require("smart-splits").move_cursor_left() end,  mode = { "n", "t" } },
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

    -- Accelerated j/k scrolling
    {
        "rhysd/accelerated-jk",
        lazy = true,
        keys = {
            { "j", mode = "n", "<Plug>(accelerated_jk_gj)", desc = "Accelerated j" },
            { "k", mode = "n", "<Plug>(accelerated_jk_gk)", desc = "Accelerated k" },
        },
    },

    -- Git diff viewer
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = true
    },
}
