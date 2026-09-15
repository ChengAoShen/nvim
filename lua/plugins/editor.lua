return {
    -- Better text objects
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        config = true,
    },

    -- Auto-close pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    -- Surround text editing
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true,
    },

    -- Highlight TODOFIXME comments (picker via snacks)
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "<leader>ft", function() Snacks.picker.todo_comments() end,        desc = "Todo comments" },
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
        },
    },

    -- Keybinding hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true,
    },

    -- Seamless window/tmux navigation
    {
        "mrjones2014/smart-splits.nvim",
        lazy = true,
        -- Terminal mode uses <C-hjkl>, not <leader>hjkl: the leader is <Space>,
        -- so a `t`-mode <leader>h mapping turns every space typed in a terminal
        -- into a 'timeoutlen' wait, and swallows it outright when the next
        -- keystroke is h/j/k/l (" how", " list", " just"...).
        keys = {
            { "<leader>h", function() require("smart-splits").move_cursor_left() end,  mode = "n", desc = "Move to left split" },
            { "<leader>j", function() require("smart-splits").move_cursor_down() end,  mode = "n", desc = "Move to split below" },
            { "<leader>k", function() require("smart-splits").move_cursor_up() end,    mode = "n", desc = "Move to split above" },
            { "<leader>l", function() require("smart-splits").move_cursor_right() end, mode = "n", desc = "Move to right split" },
            -- Other option
            { "<C-h>",     function() require("smart-splits").move_cursor_left() end,  mode = "t", desc = "Move to left split" },
            { "<C-j>",     function() require("smart-splits").move_cursor_down() end,  mode = "t", desc = "Move to split below" },
            { "<C-k>",     function() require("smart-splits").move_cursor_up() end,    mode = "t", desc = "Move to split above" },
            { "<C-l>",     function() require("smart-splits").move_cursor_right() end, mode = "t", desc = "Move to right split" },
        },
    },

    -- Enhanced jump/search motions
    {
        "folke/flash.nvim",
        lazy = true,
        opts = {
            -- Inline labels with priority below inlay hints (default 4096),
            -- so labels render right after the match instead of after the
            -- LSP type annotation.
            label = { style = "inline" },
            highlight = { priority = 1000 },
        },
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    -- Activity tracking (WakaTime)
    {
        "wakatime/vim-wakatime",
        event = "VeryLazy",
    },
}
