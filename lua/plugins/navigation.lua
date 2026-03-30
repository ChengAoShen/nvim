return {
    -- Activity tracking (WakaTime)
    {
        "wakatime/vim-wakatime",
        event = "VeryLazy",
    },

    -- File explorer tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = true,
        keys = {
            { "<C-N>", "<CMD>NvimTreeToggle<CR>", mode = { "n", "t" } },
        },
        config = function()
            require("nvim-tree").setup({
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
                filters = {
                    custom = {
                        "\\.git$",
                        "\\.vscode$",
                        "\\.cache$",
                        "\\.DS_Store$",
                        "\\.pytest_cache$",
                        "__pycache__$",
                    }
                },
            })
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end
    },

    -- Seamless window navigation
    {
        'numToStr/Navigator.nvim',
        lazy = true,
        keys = {
            { "<leader>h", "<CMD>NavigatorLeft<CR>",  mode = { "n", "t" } },
            { "<leader>j", "<CMD>NavigatorDown<CR>",  mode = { "n", "t" } },
            { "<leader>k", "<CMD>NavigatorUp<CR>",    mode = { "n", "t" } },
            { "<leader>l", "<CMD>NavigatorRight<CR>", mode = { "n", "t" } },
        },
        config = true
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
