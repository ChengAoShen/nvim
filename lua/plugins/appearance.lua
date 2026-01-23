return {
    -- Colorscheme
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup({
                style = 'darker',
                -- transparent =true,
                highlights = {}
            })
            require('onedark').load()
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
            theme = "onedark",
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

    -- Indentation guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        config = function()
            require("ibl").setup()
        end
    },

    -- Dashboard/start screen
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        config = function()
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }
            require("alpha").setup(dashboard.config)
        end
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
