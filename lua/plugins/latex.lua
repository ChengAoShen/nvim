return{
    {"lervag/vimtex",
    config = function ()
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_view_method = 'skim'
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_mappings_prefix = '<leader>t'
    end,
    }

}
