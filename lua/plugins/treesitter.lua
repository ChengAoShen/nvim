-- requires: tree-sitter CLI (npm install -g tree-sitter-cli), gcc/clang, git
local lang = require("lang")

return {
    {
        "romus204/tree-sitter-manager.nvim",
        lazy = false,
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = lang.parsers(),
            })

            -- Treesitter folding for any buffer with an available parser.
            -- Matching on filetype, not parser name: they can differ
            -- (tsx -> typescriptreact) and some parsers have no filetype
            -- (markdown_inline, luadoc).
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    -- get_parser returns nil (rather than erroring) when no
                    -- parser is installed, so the pcall alone is not a guard.
                    local ok, parser = pcall(vim.treesitter.get_parser, ev.buf)
                    if not ok or not parser then return end
                    vim.wo[0][0].foldmethod = "expr"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldlevel = 99
                end,
            })
        end,
    },
}
