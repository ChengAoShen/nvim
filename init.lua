require("config.basic")
require("config.keymaps")
require("lazy").setup("plugins")
require("lazy").setup({
    {
        'kkoomen/vim-doge',
        config = function()
            vim.g.doge_doc_standard_python = 'google'
        end,
    },
})
require("languages.python")
