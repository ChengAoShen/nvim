-- Formatter: pulls per-filetype formatters from lang.lua.
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
            local dprint_config_names = { "dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc" }
            local fallback_dprint_config = vim.fn.stdpath("config") .. "/dprint.json"

            local function find_dprint_config(ctx)
                return vim.fs.find(dprint_config_names, { path = ctx.dirname, upward = true })[1]
            end

            require("conform").setup({
                formatters_by_ft = lang.formatters_by_ft(),
                formatters = {
                    dprint = {
                        command = "dprint",
                        args = function(_, ctx)
                            return {
                                "fmt",
                                "--config",
                                find_dprint_config(ctx) or fallback_dprint_config,
                                "--stdin",
                                "$FILENAME",
                            }
                        end,
                        cwd = function(_, ctx)
                            local config = find_dprint_config(ctx)
                            return config and vim.fs.dirname(config) or nil
                        end,
                    },
                },
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 2000,
                },
            })
        end,
    },
}
