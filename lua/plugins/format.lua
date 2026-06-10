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
            require("conform").setup({
                formatters_by_ft = lang.formatters_by_ft(),
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 2000,
                },
            })
        end,
    },
}
