-- LSP infrastructure only; what to install and how to configure it comes from
-- lua/langs/. Completion: plugins/completion.lua. Formatting: plugins/format.lua.
local lang = require("lang")

return {
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

            local servers = {}
            for _, spec in pairs(lang.active()) do
                vim.list_extend(servers, spec.lsp and spec.lsp.mason or {})
            end

            -- automatic_enable off: every server is enabled explicitly below,
            -- and some packages are started by another plugin instead
            -- (rust_analyzer belongs to rustaceanvim).
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_enable = false,
            })

            -- Formatters and other non-LSP packages; mason-lspconfig only
            -- knows about servers.
            local registry = require("mason-registry")
            registry.refresh(function()
                for _, tool in ipairs(lang.tools()) do
                    local ok, pkg = pcall(registry.get_package, tool)
                    if ok and not pkg:is_installed() then
                        pkg:install()
                    end
                end
            end)
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        event = "VeryLazy",
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            for _, spec in pairs(lang.active()) do
                for name, cfg in pairs(spec.lsp and spec.lsp.servers or {}) do
                    -- A config may be a function, for settings that need a
                    -- plugin loaded first (jsonls + SchemaStore).
                    cfg = type(cfg) == "function" and cfg() or cfg
                    cfg.capabilities = capabilities
                    vim.lsp.config(name, cfg)
                    vim.lsp.enable(name)
                end
            end

            -- Only what Neovim has no default for; see config/keymaps.lua.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
                callback = function(ev)
                    local function map(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
                    end
                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
                end,
            })
        end,
    },
}
