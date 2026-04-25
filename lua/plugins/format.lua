return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    typescript = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    json = { "prettierd" },
                    jsonc = { "prettierd" },
                    yaml = { "prettierd" },
                    markdown = { "prettierd" },
                    html = { "prettierd" },
                    css = { "prettierd" },
                    scss = { "prettierd" },
                    less = { "prettierd" },
                    python = { "ruff_organize_imports", "ruff_format" },
                },
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 2000,
                },
            })
        end,
    },
}
