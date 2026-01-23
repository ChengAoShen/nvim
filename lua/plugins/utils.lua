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
            require("nvim-tree").setup(
                {
                    git = {
                        enable = true,
                        ignore = false,
                        timeout = 500,
                    },
                    filters = {
                        custom = {
                            ".git",
                            ".pytest_cache",
                            ".vscode",
                            ".cache",
                            ".DS_Store",
                            "__pycache__", }
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

    -- Better text objects
    {
        'echasnovski/mini.ai',
        event = "VeryLazy",
        config = true
    },

    -- Comment toggling
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = true
    },

    -- Auto-close pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require("telescope").load_extension('fzf')
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
        end
    },

    -- Surround text editing
    {
        "kylechui/nvim-surround",
        event = "InsertEnter",
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

    -- Animated cursor
    {
        "gen740/SmoothCursor.nvim",
        event = "VeryLazy",
        config = true
    },

    -- Keybinding hints
    {
        "folke/which-key.nvim",
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
}
