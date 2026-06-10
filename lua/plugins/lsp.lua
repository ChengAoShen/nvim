-- LSP infrastructure: mason installs, lspconfig wiring, schema/lazydev helpers.
-- Driven by the registry in lua/lang.lua. Completion lives in
-- plugins/completion.lua, formatting in plugins/format.lua, rust in
-- plugins/rust.lua.
local lang = require("lang")

return {
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
        "mason-org/mason.nvim",
        dependencies = "mason-org/mason-lspconfig.nvim",
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

            -- Non-LSP tools (formatters etc.) from lang.lua.
            local registry = require("mason-registry")
            registry.refresh(function()
                for _, tool in ipairs(lang.tools()) do
                    local ok, pkg = pcall(registry.get_package, tool)
                    if ok and not pkg:is_installed() then pkg:install() end
                end
            end)
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
                    local function map(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client:supports_method("textDocument/inlayHint", ev.buf) then
                        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                    end
                    map("<leader>th", function()
                        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
                        vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = ev.buf })
                    end, "Toggle inlay hints")
                end,
            })
        end,
    },
}
