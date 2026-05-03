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
                        -- 通用 LSP keymap 已由 plugins/lsp.lua 的 LspAttach autocmd 处理
                        local opts = { buffer = bufnr }
                        -- Rust 专属：避开 <leader>a（被 claudecode 占用）
                        vim.keymap.set("n", "<leader>rca", function()
                            vim.cmd.RustLsp("codeAction")
                        end, vim.tbl_extend("force", opts, { desc = "Rust code action" }))
                        vim.keymap.set("n", "K", function()
                            vim.cmd.RustLsp({ "hover", "actions" })
                        end, vim.tbl_extend("force", opts, { desc = "Rust hover + actions" }))
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            checkOnSave = true,
                            check = {
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
