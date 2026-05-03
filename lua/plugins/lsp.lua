-- All language tooling: completion, mason, lspconfig, conform, schema/lazydev,
-- and rustaceanvim. Driven by the registry in lua/lang.lua.
local lang = require("lang")

return {
    -- Completion engine; also provides LSP capabilities used by lspconfig.
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<Tab>"] = { "accept", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
    },

    -- JSON/YAML schema catalog (consumed by jsonls).
    { "b0o/SchemaStore.nvim", lazy = true, version = false },

    -- Neovim Lua dev: inject runtime libs and `vim` globals into lua_ls.
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cond = function() return lang.is_enabled("lua") end,
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Mason: install LSP servers / formatters declared in lang.lua.
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
                        package_uninstalled = "✗",
                    },
                },
            })

            local ensure, exclude_auto = {}, {}
            for _, spec in pairs(lang.active()) do
                if spec.lsp then
                    vim.list_extend(ensure, spec.lsp.mason or {})
                    for _, pkg in ipairs(spec.lsp.mason or {}) do
                        if not (spec.lsp.servers and spec.lsp.servers[pkg]) then
                            table.insert(exclude_auto, pkg)
                        end
                    end
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure,
                automatic_enable = { exclude = exclude_auto },
            })
        end,
    },

    -- LSP server configs, wired with blink.cmp capabilities.
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        event = "VeryLazy",
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            for _, spec in pairs(lang.active()) do
                if spec.lsp and spec.lsp.servers then
                    for name, cfg in pairs(spec.lsp.servers) do
                        cfg = type(cfg) == "function" and cfg() or cfg
                        cfg.capabilities = capabilities
                        vim.lsp.config(name, cfg)
                        vim.lsp.enable(name)
                    end
                end
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<space>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },

    -- Formatter: pulls per-filetype formatters from lang.lua.
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = lang.formatters_by_ft(),
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 2000,
                },
            })
        end,
    },

    -- Rust: rustaceanvim takes over rust-analyzer (mason installs the binary).
    {
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false,
        ft = { "rust" },
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
