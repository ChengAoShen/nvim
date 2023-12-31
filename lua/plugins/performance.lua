return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            --设置背景图片
            require('onedark').setup({
                style = 'darker',
                -- transparent =true,
                highlights = {}
            })
            require('onedark').load()
        end
    },

    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = true
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            theme = "onedark",
        }
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = true
    },

    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        dependencies = "SmiteshP/nvim-navic",
        opts = {}
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            require("ibl").setup()
        end
    },

    {
        'goolord/alpha-nvim',
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

    {
        "hiphish/rainbow-delimiters.nvim",
        event  = "VeryLazy",
        config = function()
            require("rainbow-delimiters.setup").setup({})
        end

    },

    {
        "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        config = function()
            require("scrollbar.handlers.search").setup({})
        end,
    },

    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = true
    },

}
