return {
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_assume_mapped = true
        end,
    },


    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
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
                            ".vim",
                            ".vscode",
                            ".cache",
                            ".DS_Store",
                            "__pycache__", }
                    },
                })
            vim.keymap.set("n", "<C-N>", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "tr", "<cmd>NvimTreeToggle<CR>")
            vim.g.loaded_netrw = 1
            vim.g.loaded_newrwPlugin = 1
        end
    },

    {
        'numToStr/Navigator.nvim',
        config = function()
            require('Navigator').setup()
            vim.keymap.set({ 'n', 't' }, '<leader>h', '<CMD>NavigatorLeft<CR>')
            vim.keymap.set({ 'n', 't' }, '<leader>l', '<CMD>NavigatorRight<CR>')
            vim.keymap.set({ 'n', 't' }, '<leader>k', '<CMD>NavigatorUp<CR>')
            vim.keymap.set({ 'n', 't' }, '<leader>j', '<CMD>NavigatorDown<CR>')
            vim.keymap.set({ 'n', 't' }, '<leader>p', '<CMD>NavigatorPrevious<CR>')
        end
    },

    {
        'echasnovski/mini.ai',
        config = function()
            require("mini.ai").setup()
        end
    },

    {
        "echasnovski/mini.comment",
        config = function()
            require("mini.comment").setup()
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },

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

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = { enable = true, disable = { "latex" }, },
                indent = { enable = true, },
            })
        end
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        -- -@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },

    {
        "rhysd/accelerated-jk",
        config = function()
            vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
            vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
        end
    },

    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end
    },
    {
        "CRAG666/code_runner.nvim",
        config = function()
            require('code_runner').setup({
                filetype = {
                    python = "python3 -u",
                    c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
                    cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
                },
            })
            vim.keymap.set("n", "<leader>rc", "<cmd>RunCode<CR>")
        end
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = function()
            require('diffview').setup()
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        event  = "VeryLazy",
        config = function()
            require('symbols-outline').setup()
        end
    },

    {
        "sidebar-nvim/sidebar.nvim",
        event = "VeryLazy",
        config = function()
            require("sidebar-nvim").setup({
                open = false,
                -- bind = {["<C-M>"] = function () require("sidebar-nvim").toggle() end},
                sections = { "todos", "symbols", "diagnostics", "git" },
                vim.keymap.set("n", "<C-M>", "<cmd>SidebarNvimToggle<CR>")
            })
        end
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        event = "VeryLazy",
        config = function()
            local notify = require("notify")
            notify.setup({
                -- -- "fade", "slide", "fade_in_slide_out", "static"
                -- stages = "static",
                -- on_open = nil,
                -- on_close = nil,
                timeout = 2000,
                -- fps = 1,
                -- render = "default",
                -- background_colour = "Normal",
                max_width = math.floor(vim.api.nvim_win_get_width(0) / 3),
                max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
                -- level = "TRACE",
            })

            vim.notify = notify
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },

    {
        'rmagatti/goto-preview',
        event = "VeryLazy",
        config = function()
            require('goto-preview').setup({
                default_mappings = true
            })
        end
    },

    {
        'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup()
        end
    }
}
