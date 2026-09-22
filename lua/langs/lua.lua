return {
    enabled = true,
    lsp = {
        mason = { "lua_ls" },
        servers = {
            lua_ls = {
                settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            },
        },
    },
    treesitter = { "lua", "luadoc" },
    format = { lua = { "stylua" } },
    tools = { "stylua" },
    plugins = {
        -- Injects Neovim runtime libs and the `vim` global into lua_ls.
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
}
