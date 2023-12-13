local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

return {
    {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
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
                ensure_installed = { "lua_ls", "clangd", "texlab",
                    "rust_analyzer", "ruff_lsp", "pyright", "jsonls" },
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",

        config = function()
            require("lspconfig").pyright.setup({
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                        }
                    },
                }
            })
            require("lspconfig").ruff_lsp.setup {
                on_attach = on_attach,
            }

            require("lspconfig").rust_analyzer.setup({
                on_attach = on_attach,
            })
            require("lspconfig").clangd.setup({
                on_attach = on_attach,
            })
            require("lspconfig").texlab.setup({
                on_attach = on_attach,
            })
            require("lspconfig").jsonls.setup({
                on_attach = on_attach,
            })
            require("lspconfig").lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' }, },
                    },
                },
            })
        end,
    },
}
