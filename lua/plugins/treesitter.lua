-- requires: tree-sitter CLI (npm install -g tree-sitter-cli), gcc/clang, git
return {
    {
        "romus204/tree-sitter-manager.nvim",
        lazy = false,
        config = function()
            local lang_parsers = {
                python     = { "python" },
                rust       = { "rust", "toml" },
                lua        = { "lua", "luadoc" },
                json       = { "json", "json5" },
                typescript = { "typescript", "javascript", "tsx" },
                swift      = { "swift" },
                c          = { "c", "cpp" },
            }
            local parsers = {}
            for lang, ps in pairs(lang_parsers) do
                if vim.g.language[lang] then
                    vim.list_extend(parsers, ps)
                end
            end

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
