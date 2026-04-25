return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                -- style = 'darker',
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
            require('tokyonight').load()
        end
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

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        opts = {
            -- theme = "onedark",
            theme = "tokyonight"
        }
    },

    -- Buffer tabs
    {
        "akinsho/bufferline.nvim",
        event = "BufReadPost",
        config = true
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

    -- Search match lens integration
    {
        "kevinhwang91/nvim-hlslens",
        event = "BufReadPost",
        config = function()
            require("scrollbar.handlers.search").setup({})
        end,
    },

    -- Scrollbar with search markers
    {
        "petertriho/nvim-scrollbar",
        event = "BufReadPost",
        config = true
    },

}
