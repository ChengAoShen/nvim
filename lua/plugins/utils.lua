return {
    "github/copilot.vim",

    {"nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config=function()
            require("nvim-tree").setup(
                {git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,},
                filters = {
                    custom ={
                        ".git",
                        ".pytest_cache",
                        ".vim",
                        ".vscode",
                        ".cache",
                        ".DS_Store",
                        "__pycache__",}
                },})
            vim.keymap.set("n","<C-N>","<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n","tr","<cmd>NvimTreeToggle<CR>")
            vim.g.loaded_netrw = 1
            vim.g.loaded_newrwPlugin = 1
        end},

    {'numToStr/Navigator.nvim',
        config = function()
            require('Navigator').setup()
            vim.keymap.set({'n', 't'}, '<leader>h', '<CMD>NavigatorLeft<CR>')
            vim.keymap.set({'n', 't'}, '<leader>l', '<CMD>NavigatorRight<CR>')
            vim.keymap.set({'n', 't'}, '<leader>k', '<CMD>NavigatorUp<CR>')
            vim.keymap.set({'n', 't'}, '<leader>j', '<CMD>NavigatorDown<CR>')
            vim.keymap.set({'n', 't'}, '<leader>p', '<CMD>NavigatorPrevious<CR>')
        end},

    {'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end},

    {'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup()
        end},

    {"lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end},

    {"nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', 
                build = 'make' }
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require("telescope").load_extension('fzf')
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
        end},

    {"kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end},

    {"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = {enable = true,},
                indent = {enable = true,},})
        end},
}

