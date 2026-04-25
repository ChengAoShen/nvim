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

    -- Highlight TODO/FIXME comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    -- Keybinding hints
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true
    },
}
