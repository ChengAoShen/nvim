-- Aggregates the per-language specs in lua/langs/. One file per language;
-- deleting a file removes that language's tooling entirely.
--
-- Each langs/*.lua returns a table that may define:
--   enabled     = boolean
--   lsp.mason   = mason package names to install
--   lsp.servers = { [server] = config | function() return config end }
--   treesitter  = parser names
--   format      = { [filetype] = { formatter names... } }
--   formatters  = { [name] = conform formatter definition }
--   tools       = extra mason packages (formatters etc.)
--   plugins     = lazy.nvim plugin specs
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

function M.active()
    local out = {}
    for name, spec in pairs(M.langs) do
        if spec.enabled then
            out[name] = spec
        end
    end
    return out
end

-- Collect `key` from every enabled language into one deduplicated list.
local function collect(key, initial)
    local seen, out = {}, {}
    local function add(list)
        for _, item in ipairs(list or {}) do
            if not seen[item] then
                seen[item] = true
                table.insert(out, item)
            end
        end
    end
    add(initial)
    for _, spec in pairs(M.active()) do
        add(spec[key])
    end
    return out
end

-- Merge `key` (a table) from every enabled language into one table.
local function merge(key, initial)
    local out = initial and vim.deepcopy(initial) or {}
    for _, spec in pairs(M.active()) do
        for k, v in pairs(spec[key] or {}) do
            out[k] = v
        end
    end
    return out
end

-- Filetypes with no language file of their own. dprint covers them all; its
-- markup_fmt/malva/pretty_yaml plugins are configured in dprint.json.
local base_formatters = {
    html = { "dprint" },
    css = { "dprint" },
    scss = { "dprint" },
    less = { "dprint" },
    yaml = { "dprint" },
}

function M.parsers()
    return collect("treesitter")
end
function M.plugins()
    return collect("plugins")
end
function M.tools()
    return collect("tools", { "dprint" })
end
function M.formatters_by_ft()
    return merge("format", base_formatters)
end
function M.formatters()
    return merge("formatters")
end

return M
