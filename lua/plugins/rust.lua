-- Rust: rustaceanvim takes over rust-analyzer (mason installs the binary,
-- declared in lang.lua).
local lang = require("lang")

return {
    -- lazy = false per upstream docs: the plugin gates itself on filetype.
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        cond = function() return lang.is_enabled("rust") end,
        init = function()
            vim.g.rustaceanvim = {
                tools = {
                    code_actions = { ui_select_fallback = true },
                },
                server = {
                    on_attach = function(_, bufnr)
                        local opts = { buffer = bufnr }
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
