return {
    enabled = true,
    -- rust_analyzer is owned by rustaceanvim below; mason still installs it.
    lsp = {
        mason = { "rust_analyzer", "taplo" },
        servers = { taplo = {} },
    },
    treesitter = { "rust", "toml" },
    plugins = {
        -- lazy = false per upstream docs: the plugin gates itself on filetype.
        {
            "mrcjkb/rustaceanvim",
            version = "^6",
            lazy = false,
            init = function()
                vim.g.rustaceanvim = {
                    tools = {
                        code_actions = { ui_select_fallback = true },
                    },
                    server = {
                        on_attach = function(_, bufnr)
                            local function map(lhs, rhs, desc)
                                vim.keymap.set(
                                    "n",
                                    lhs,
                                    rhs,
                                    { buffer = bufnr, desc = desc }
                                )
                            end
                            map("<leader>rca", function()
                                vim.cmd.RustLsp("codeAction")
                            end, "Rust code action")
                            map("K", function()
                                vim.cmd.RustLsp({ "hover", "actions" })
                            end, "Rust hover + actions")
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
    },
}
