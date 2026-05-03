if not vim.g.language or not vim.g.language.rust then
    return {}
end

return {
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        ft = { "rust" },
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    code_actions = { ui_select_fallback = true },
                },
                server = {
                    on_attach = function(_, bufnr)
                        local opts = { buffer = bufnr }
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                        vim.keymap.set("n", "<space>f", function()
                            vim.lsp.buf.format({ async = true })
                        end, opts)
                        vim.keymap.set("n", "<leader>a", function()
                            vim.cmd.RustLsp("codeAction")
                        end, opts)
                        vim.keymap.set("n", "K", function()
                            vim.cmd.RustLsp({ "hover", "actions" })
                        end, opts)
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = { enable = true },
                            inlayHints = { enable = true },
                        },
                    },
                },
            }
        end,
    },
}
