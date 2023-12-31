return {
    {
        "wakatime/vim-wakatime",
        event = "VeryLazy",
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
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
            vim.g.loaded_newrwPlugin = 1
        end
    },

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

    {
        'echasnovski/mini.ai',
        event = "VeryLazy",
        config = true
    },

    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = true
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = true
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
        event = "InsertEnter",
        config = true
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "rust", "cpp", "c",
                    "lua", "json", "javascript", "html", "toml" },
                highlight = {
                    enable = true,
                    disable = { "latex" },
                },
                indent = {
                    enable = true,
                },
            })
        end
    },

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

    {
        "rhysd/accelerated-jk",
        lazy = true,
        keys = {
            { "j", mode = "n", "<Plug>(accelerated_jk_gj)", desc = "Accelerated j" },
            { "k", mode = "n", "<Plug>(accelerated_jk_gk)", desc = "Accelerated k" },
        },
    },

    {
        "simrat39/symbols-outline.nvim",
        config = true
    },

    {
        "CRAG666/code_runner.nvim",
        lazy = true,
        opts = {
            filetype = {
                python = "cd $dir && ipython -i $fileName",
                c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
                cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
                rust = "cd $dir && cargo run",
                lua = "cd $dir && lua $fileName",
            },
        },
        keys = {
            { "<leader>rc", mode = "n", "<cmd>RunCode<CR>", desc = "Run Code" },
        },
    },

    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = true
    },

    {
        'simrat39/symbols-outline.nvim',
        event  = "VeryLazy",
        config = true
    },

    {
        "sidebar-nvim/sidebar.nvim",
        -- lazy = true,
        config = function()
            require("sidebar-nvim").setup({
                open = false,
                sections = { "symbols", "diagnostics", "git" },
            })
            vim.keymap.set("n", "<C-M>", "<cmd>SidebarNvimToggle<CR>")
        end
    },

    {
        "rcarriga/nvim-notify",
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
                -- background_colour = "#000000",
                max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
                max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
                -- level = "TRACE",
            })

            vim.notify = notify
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = "MunifTanjim/nui.nvim",
        opts = {
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
        },
        config = true
    },

    {
        'rmagatti/goto-preview',
        event = "VeryLazy",
        opts = {
            default_mappings = true
        },
        config = true
    },

    {
        "gen740/SmoothCursor.nvim",
        event = "VeryLazy",
        config = true
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true
    },

    {
        "ellisonleao/glow.nvim",
        event = "VeryLazy",
        config = true,
        cmd = "Glow"
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "VeryLazy",
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
            vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)

            require("ufo").setup({
                fold_virt_text_handler = handler,
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end
            })
        end
    },

    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        keys = {
            {
                "<leader>th",
                "<cmd>ToggleTerm size=20 direction=horizontal<CR>",
                mode = { "n", "t" },
                desc = "Open horizontal terminal"
            },
            {
                "<leader>tv",
                "<cmd>ToggleTerm size=80 direction=vertical<CR>",
                mode = { "n", "t" },
                desc = "Open vertical terminal"
            },
            {
                "<leader>tf",
                "<cmd>ToggleTerm direction=float<CR>",
                mode = { "n", "t" },
                desc = "Open floating terminal"
            },
        },
        opts = {}
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        keys = {
            {
                "<leader>td",
                "<cmd>TroubleToggle document_diagnostics<cr>"
                ,
                mode = { "n", "t" },
                desc = "Document trouble"
            },

            {
                "<leader>tw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                mode = { "n", "t" },
                desc = "Workspace trouble"
            },

            {
                "<leader>tt",
                "<cmd>TodoTrouble<CR>",
                mode = { "n", "t" },
                desc = "Todo trouble"
            }
        },
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    {
        "f-person/git-blame.nvim" ,
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>")
        end
    }
}
