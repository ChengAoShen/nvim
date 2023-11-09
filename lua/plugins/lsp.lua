return{
    -- lsp --
    {"williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            require("mason-lspconfig").setup({
                ensure_installed={"pyright","lua_ls","clangd","texlab"},
            })
        end},
    {"neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").pyright.setup({})

            require("lspconfig").clangd.setup({})

            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {globals = {'vim'},},
                    },
                },
            })
        end,},
}
