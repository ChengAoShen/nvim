return {
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
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
    },
    tools = { "biome" },
}
