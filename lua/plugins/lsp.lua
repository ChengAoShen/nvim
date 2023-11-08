return{
        -- lsp --
        {"williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
        },
    
        {"williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed={"pyright",},
            })
        end,
        },
    
        {"neovim/nvim-lspconfig",
        config = function()
            require'lspconfig'.pyright.setup{} --need to change
        end,
        },
}
