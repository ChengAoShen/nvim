return {
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
}
