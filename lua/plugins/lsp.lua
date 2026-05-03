-- Single source of truth: each language maps to mason packages + lspconfig configs.
-- mason: package names to install via mason
-- servers: { [server_name] = config | function() return config end }
-- Packages installed by mason but absent from `servers` (e.g. rust_analyzer)
-- will be excluded from mason-lspconfig's automatic_enable.
local LANG = {
    python = {
        mason = { "ruff", "ty" },
        servers = {
            -- ruff: lint / format / imports; ty: type checking + completion (Astral, beta)
            ruff = {
                on_attach = function(client, _)
                    -- Defer hover to ty to avoid duplicates
                    client.server_capabilities.hoverProvider = false
                end,
            },
            ty = {},
        },
    },
    rust = {
        -- rust_analyzer is owned by rustaceanvim (see plugins/rust.lua)
        mason = { "rust_analyzer", "taplo" },
        servers = { taplo = {} },
    },
    c = {
        mason = { "clangd" },
        servers = { clangd = {} },
    },
    lua = {
        mason = { "lua_ls" },
        servers = {
            lua_ls = {
                settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            },
        },
    },
    typescript = {
        mason = { "vtsls" },
        servers = {
            vtsls = {
                settings = {
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "literals" },
                            variableTypes = { enabled = false },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                        },
                    },
                },
            },
        },
    },
    json = {
        mason = { "jsonls" },
        servers = {
            jsonls = function()
                local ok, ss = pcall(require, "schemastore")
                return {
                    settings = {
                        json = {
                            schemas = ok and ss.json.schemas() or nil,
                            validate = { enable = true },
                        },
                    },
                }
            end,
        },
    },
    tex = {
        mason = {},
        servers = { texlab = {} },
    },
    swift = {
        mason = {},
        servers = { sourcekit = {} },
    },
}

local function active_specs()
    local out = {}
    for lang, spec in pairs(LANG) do
        if vim.g.language and vim.g.language[lang] then
            out[lang] = spec
        end
    end
    return out
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
                        package_uninstalled = "✗",
                    },
                },
            })

            local ensure, exclude_auto = {}, {}
            for _, spec in pairs(active_specs()) do
                vim.list_extend(ensure, spec.mason)
                for _, pkg in ipairs(spec.mason) do
                    if not (spec.servers and spec.servers[pkg]) then
                        table.insert(exclude_auto, pkg)
                    end
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure,
                automatic_enable = { exclude = exclude_auto },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        event = "VeryLazy",
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            for _, spec in pairs(active_specs()) do
                for name, cfg in pairs(spec.servers or {}) do
                    cfg = type(cfg) == "function" and cfg() or cfg
                    cfg.capabilities = capabilities
                    vim.lsp.config(name, cfg)
                    vim.lsp.enable(name)
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
}
