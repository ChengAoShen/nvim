-- Formatter. Which formatter runs for which filetype comes from lua/langs/ via
-- lang.lua; only formatters shared across languages (dprint) are defined here.
local lang = require("lang")

return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        keys = {
            {
                "<leader>fm",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "v" },
                desc = "Format buffer/selection",
            },
        },
        config = function()
            -- dprint insists on a config file: prefer the project's, fall back
            -- to the one shipped next to this config.
            local fallback_config = vim.fn.stdpath("config") .. "/dprint.json"

            local function find_config(ctx)
                local names =
                    { "dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc" }
                return vim.fs.find(names, { path = ctx.dirname, upward = true })[1]
            end

            local formatters = {
                dprint = {
                    command = "dprint",
                    args = function(_, ctx)
                        return {
                            "fmt",
                            "--config",
                            find_config(ctx) or fallback_config,
                            "--stdin",
                            "$FILENAME",
                        }
                    end,
                    cwd = function(_, ctx)
                        local config = find_config(ctx)
                        return config and vim.fs.dirname(config) or nil
                    end,
                },
            }

            for name, def in pairs(lang.formatters()) do
                formatters[name] = def
            end

            require("conform").setup({
                formatters_by_ft = lang.formatters_by_ft(),
                formatters = formatters,
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 2000,
                },
            })
        end,
    },
}
