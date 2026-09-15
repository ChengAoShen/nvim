return {
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
        json = { "biome" },
        jsonc = { "biome" },
    },
    tools = { "biome" },
    plugins = {
        -- Schema catalog consumed by jsonls above.
        { "b0o/SchemaStore.nvim", lazy = true, version = false },
    },
}
