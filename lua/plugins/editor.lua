return {
    -- Better text objects
    {
        'echasnovski/mini.ai',
        event = "VeryLazy",
        config = true
    },

    -- Auto-close pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    -- Surround text editing
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true
    },

    -- Highlight TODO/FIXME comments (picker via snacks)
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
        config = true
    },
}
