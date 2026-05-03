-- requires: tree-sitter CLI (npm install -g tree-sitter-cli), gcc/clang, git
local lang = require("lang")

return {
    {
        "romus204/tree-sitter-manager.nvim",
        lazy = false,
        config = function()
            local parsers = lang.parsers()

            require("tree-sitter-manager").setup({
                ensure_installed = parsers,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = parsers,
                callback = function()
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldlevel = 99
                end,
            })
        end,
    },
}
