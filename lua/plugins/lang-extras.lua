return {
    -- JSON / YAML schema catalog (auto schemas for package.json, tsconfig, etc.)
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false,
    },

    -- Neovim Lua dev: inject runtime libs and `vim` globals into lua_ls
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cond = function()
            return vim.g.language and vim.g.language.lua
        end,
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
