-- Parsers come from lua/langs/; LaTeX and Lean deliberately have none.
-- Requires: tree-sitter CLI (npm install -g tree-sitter-cli), a C compiler, git.
local lang = require("lang")

return {
    {
        "romus204/tree-sitter-manager.nvim",
        lazy = false,
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = lang.parsers(),
            })

            -- Fold by treesitter wherever a parser exists. Matching on
            -- filetype, not parser name: the two can differ (tsx ->
            -- typescriptreact) and some parsers have no filetype at all.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup(
                    "UserTreesitterFold",
                    { clear = true }
                ),
                callback = function(ev)
                    -- get_parser returns nil rather than erroring when the
                    -- parser is missing, so the pcall alone is not a guard.
                    local ok, parser = pcall(vim.treesitter.get_parser, ev.buf)
                    if not ok or not parser then
                        return
                    end
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldlevel = 99
                end,
            })
        end,
    },
}
