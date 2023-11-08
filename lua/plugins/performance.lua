return {
        {"folke/tokyonight.nvim", 
        config=function()
            vim.cmd[[colorscheme tokyonight-storm]]
        end},

        {"nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config=function()
            require("lualine").setup({theme='tokyonight-stom'})
        end},
    
        {"akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config=function()
            require("bufferline").setup()
        end},

        {"utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",},
        config=function()
            require("barbecue").setup({theme='tokyonight-stom'})
        end},

        {"lukas-reineke/indent-blankline.nvim",
        config=function()
            require("ibl").setup()
        end},

        {'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config=function ()
            require("alpha").setup(require'alpha.themes.dashboard'.config)
        end},

        {"folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config=function()
            require("todo-comments").setup()
        end},
        
}
