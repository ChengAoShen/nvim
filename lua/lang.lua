-- Single source of truth for per-language tooling.
-- Each entry under M.langs may define:
--   enabled      = boolean
--   lsp.mason    = list of mason package names to install
--   lsp.servers  = { [server_name] = config | function() return config end }
--                  packages installed by mason but absent from `servers`
--                  (e.g. rust_analyzer, owned by rustaceanvim) are excluded
--                  from mason-lspconfig automatic_enable.
--   treesitter   = list of parser names
--   format       = { [filetype] = { formatters... } }
local M = {}

M.langs = {
    python = {
        enabled = true,
        lsp = {
            mason = { "ruff", "ty" },
            servers = {
                ruff = {
                    on_attach = function(client, _)
                        -- Defer hover to ty to avoid duplicates
                        client.server_capabilities.hoverProvider = false
                    end,
                },
                ty = {},
            },
        },
        treesitter = { "python" },
        format = { python = { "ruff_organize_imports", "ruff_format" } },
    },

    rust = {
        enabled = true,
        -- rust_analyzer owned by rustaceanvim; mason still installs it.
        lsp = {
            mason = { "rust_analyzer", "taplo" },
            servers = { taplo = {} },
        },
        treesitter = { "rust", "toml" },
    },

    lua = {
        enabled = true,
        lsp = {
            mason = { "lua_ls" },
            servers = {
                lua_ls = {
                    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
                },
            },
        },
        treesitter = { "lua", "luadoc" },
    },

    typescript = {
        enabled = true,
        lsp = {
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
        treesitter = { "typescript", "javascript", "tsx" },
        format = {
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
        },
    },

    json = {
        enabled = true,
        lsp = {
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
        treesitter = { "json", "json5" },
        format = {
            json = { "prettierd" },
            jsonc = { "prettierd" },
        },
    },

    c = {
        enabled = false,
        lsp = { mason = { "clangd" }, servers = { clangd = {} } },
        treesitter = { "c", "cpp" },
    },

    tex = {
        enabled = false,
        lsp = { mason = {}, servers = { texlab = {} } },
    },

    swift = {
        enabled = false,
        lsp = { mason = {}, servers = { sourcekit = {} } },
        treesitter = { "swift" },
    },
}

function M.is_enabled(name)
    return M.langs[name] and M.langs[name].enabled or false
end

function M.active()
    local out = {}
    for name, spec in pairs(M.langs) do
        if spec.enabled then out[name] = spec end
    end
    return out
end

function M.parsers()
    local out = {}
    for _, spec in pairs(M.active()) do
        if spec.treesitter then vim.list_extend(out, spec.treesitter) end
    end
    return out
end

-- Base formatters not tied to any language toggle.
local base_formatters = {
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    less = { "prettierd" },
}

function M.formatters_by_ft()
    local out = vim.deepcopy(base_formatters)
    for _, spec in pairs(M.active()) do
        if spec.format then
            for ft, fmts in pairs(spec.format) do
                out[ft] = fmts
            end
        end
    end
    return out
end

return M
