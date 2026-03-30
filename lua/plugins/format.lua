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
                format_on_save = function()
                    return {
                        lsp_fallback = true,
                        async = false,
                        timeout_ms = 2000,
                    }
                end,
            })
        end,
    },
}
