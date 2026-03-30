return {
    -- Colorscheme
    -- {
    --     "navarasu/onedark.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('onedark').setup({
    --             style = 'darker',
    --             transparent = true,
    --             highlights = {}
    --         })
    --         require('onedark').load()
    --     end
    -- },
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

    -- File icons used by UI plugins
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = true
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
        "utilyre/barbecue.nvim",
        event = "BufReadPost",
        dependencies = "SmiteshP/nvim-navic",
        opts = {}
    },

    -- Snacks: dashboard, indent guides, smooth scroll
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 900,
        opts = {
            picker = {
                enabled = true,
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
