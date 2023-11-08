return {
        {"linux-cultist/venv-selector.nvim",
            dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", 
                            "mfussenegger/nvim-dap-python","nvim-lua/plenary.nvim" },
            config = function()
                require("venv-selector").setup({
                    fd_binary_name = "find",
                    anaconda_base_path = "/opt/homebrew/Caskroom/miniconda/base",
                    anaconda_envs_path = "/opt/homebrew/Caskroom/miniconda/base/envs",
    
                })
            end,
            event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
            keys = {{ "<leader>vs", "<cmd>VenvSelect<cr>" },}
        }

}