-- Aggregates the per-language specs in lua/langs/. One file per language;
-- deleting a file removes that language's tooling entirely.
--
-- Each langs/*.lua returns a table that may define:
--   enabled      = boolean
--   lsp.mason    = list of mason package names to install
--   lsp.servers  = { [server_name] = config | function() return config end }
--                  packages installed by mason but absent from `servers`
--                  (e.g. rust_analyzer, owned by rustaceanvim) are excluded
--                  from mason-lspconfig automatic_enable.
--   treesitter   = list of parser names
--   format       = { [filetype] = { formatter names... } }
--   formatters   = { [name] = conform formatter definition }  -- overrides
--   tools        = list of extra mason packages (formatters etc.)
--   plugins      = list of lazy.nvim plugin specs for this language
local M = {}

local function load_langs()
    local out = {}
    for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/langs/*.lua", true)) do
        local name = vim.fn.fnamemodify(path, ":t:r")
        out[name] = require("langs." .. name)
    end
    return out
end

M.langs = load_langs()

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

-- lazy.nvim specs contributed by enabled languages (see plugins/langs.lua).
function M.plugins()
    local out = {}
    for _, spec in pairs(M.active()) do
        if spec.plugins then vim.list_extend(out, spec.plugins) end
    end
    return out
end

-- Non-LSP mason packages needed by base_formatters below.
local base_tools = { "biome", "dprint" }

-- Base formatters not tied to any language toggle.
local base_formatters = {
    yaml = { "dprint" },
    html = { "biome" },
    css = { "biome" },
    scss = { "dprint" },
    less = { "dprint" },
}

-- Deduplicated mason packages (formatters etc.) beyond LSP servers.
function M.tools()
    local seen, out = {}, {}
    local function add(list)
        for _, tool in ipairs(list or {}) do
            if not seen[tool] then
                seen[tool] = true
                table.insert(out, tool)
            end
        end
    end
    add(base_tools)
    for _, spec in pairs(M.active()) do
        add(spec.tools)
    end
    return out
end

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

-- conform formatter definitions contributed by enabled languages, merged into
-- the shared ones in plugins/format.lua.
function M.formatters()
    local out = {}
    for _, spec in pairs(M.active()) do
        if spec.formatters then
            for name, def in pairs(spec.formatters) do
                out[name] = def
            end
        end
    end
    return out
end

return M
