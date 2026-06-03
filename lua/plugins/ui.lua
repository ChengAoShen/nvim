return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte / frappe / macchiato / mocha
                transparent_background = true,
                integrations = { noice = true },
                custom_highlights = function(colors)
                    return {
                        NormalFloat = { bg = "NONE" },
                        FloatBorder = { bg = "NONE" },
                        NormalSB = { bg = "NONE" },
                        NvimTreeNormal = { bg = "NONE" },
                        TelescopeNormal = { bg = "NONE" },
                        TelescopeBorder = { bg = "NONE" },
                    }
                end,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- File icons (replaces nvim-web-devicons, provides compat layer)
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },

    -- Statusline (with buffers section replacing bufferline)
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = { theme = "auto", globalstatus = true },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "buffers", mode = 2, show_filename_only = true } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- Breadcrumb navigation in winbar
    {
        "Bekaboo/dropbar.nvim",
        event = "BufReadPost",
        keys = {
            { "<leader>;", function() require("dropbar.api").pick() end,                desc = "Pick winbar symbol" },
            { "[;",        function() require("dropbar.api").goto_context_start() end,  desc = "Go to context start" },
            { "];",        function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
        },
    },

    -- Snacks: dashboard, indent guides, smooth scroll
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 900,
        opts = {
            explorer = {
                enabled = true,
            },
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        hidden = true,
                        win = {
                            list = {
                                keys = {
                                    ["<C-N>"] = "close",
                                },
                            },
                        },
                    },
                },
            },
            scroll = {
                enabled = true,
            },
            notifier = {
                enabled = true,
            },
            indent = {
                enabled = true,
            },
            dashboard = {
                enabled = true,
                preset = {
                    header = table.concat({
                        "                                                     ",
                        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                        "                                                     ",
                    }, "\n"),
                },
            },
        },
        keys = {
            { "<leader>ff",      function() Snacks.picker.files() end,   desc = "Find files" },
            { "<leader>fg",      function() Snacks.picker.grep() end,    desc = "Live grep" },
            { "<leader><space>", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fh",      function() Snacks.picker.help() end,    desc = "Help tags" },
            { "<leader>?",       function() Snacks.picker.recent() end,  desc = "Recent files" },
            { "<leader>/",       function() Snacks.picker.lines() end,   desc = "Search in buffer" },
            { "<C-N>",           function() Snacks.explorer() end,       desc = "Open file explorer", mode = { "n", "t" } },
        },
    },

    -- Replaces cmdline, messages and popupmenu UI; routes notifications
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
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
                inc_rename = false,
                lsp_doc_border = false,
            },
            -- Center the command palette on screen (overrides command_palette preset's top position)
            views = {
                cmdline_popup = {
                    position = { row = "50%", col = "50%" },
                },
            },
        },
    },

    -- On-screen keypress display for screencasts; toggle with :Screenkey
    {
        "NStefan002/screenkey.nvim",
        cmd = "Screenkey",
        opts = {},
    },

}
