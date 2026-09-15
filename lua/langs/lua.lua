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
    plugins = {
        -- Neovim Lua dev: inject runtime libs and `vim` globals into lua_ls.
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
