return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
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
            require("nvim-treesitter").install(parsers)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = parsers, -- 只对安装了 parser 的 filetype 生效
                callback = function(ev)
                    vim.treesitter.start(ev.buf)
                end,
            })
        end,
    },
}
