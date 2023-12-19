return {
    {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function()
            vim.g.copilot_assume_mapped = true
        end,
    },

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
            local ensure_installed_table = {}
            if vim.g.language.python then
                table.insert(ensure_installed_table, "pylsp")
                table.insert(ensure_installed_table, "ruff_lsp")
            end
            if vim.g.language.rust then
                table.insert(ensure_installed_table, "rust_analyzer")
            end
            if vim.g.language.c then
                table.insert(ensure_installed_table, "clangd")
            end
            if vim.g.language.tex then
                table.insert(ensure_installed_table, "texlab")
            end
            if vim.g.language.lua then
                table.insert(ensure_installed_table, "lua_ls")
            end
            if vim.g.language.typescript then
                table.insert(ensure_installed_table, "tsserver")
            end
            if vim.g.language.json then
                table.insert(ensure_installed_table, "jsonls")
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed_table })
        end
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            if vim.g.language.python then
                require("lspconfig").pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                autopep8 = { enabled = false },
                                yapf = { enabled = false },
                                pydocstyle = { convention = "google" },
                                jedi_completion = { fuzzy = true },
                            },
                        },
                    },

                })
                require("lspconfig").ruff_lsp.setup({})
            end
            if vim.g.language.rust then
                require("lspconfig").rust_analyzer.setup({})
            end
            if vim.g.language.c then
                require("lspconfig").clangd.setup({})
            end
            if vim.g.language.tex then
                require("lspconfig").texlab.setup({})
            end
            if vim.g.language.lua then
                require("lspconfig").lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim' }, },
                        },
                    },
                })
            end
            if vim.g.language.typescript then
                require("lspconfig").tsserver.setup({})
            end
            if vim.g.language.json then
                require("lspconfig").jsonls.setup({})
            end
            if vim.g.language.swift then
                require("lspconfig").sourcekit.setup({})
            end


            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },
}
