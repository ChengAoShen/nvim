if vim.g.language.python then
    return {
        {
            'kkoomen/vim-doge',
            lazy = true,
            ft = { 'python' },
            config = function()
                vim.g.doge_doc_standard_python = 'google'
            end,
        },

        {
            "linux-cultist/venv-selector.nvim",
            dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim",
                "mfussenegger/nvim-dap-python", "nvim-lua/plenary.nvim" },
            lazy = true,
            ft = { 'python' },
            config = function()
                require("venv-selector").setup({
                    anaconda_base_path = "/opt/homebrew/Caskroom/miniconda/base",
                    anaconda_envs_path = "/opt/homebrew/Caskroom/miniconda/base/envs",

                })
            end,
            keys = { { "<leader>vs", "<cmd>VenvSelect<cr>" }, }
        },

        {
            "GCBallesteros/NotebookNavigator.nvim",
            lazy = true,
            ft = { 'python' },
            keys = {
                { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
                { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
            },
            dependencies = {
                "echasnovski/mini.comment",
                "anuvyklack/hydra.nvim",
            },
            config = function()
                require("notebook-navigator").setup()
            end,
        },

        {
            "hkupty/iron.nvim",
            lazy = true,
            ft = { 'python' },
            config = function()
                require("iron.core").setup({
                    config = {
                        scratch_repl = true,
                        repl_definition = {
                            python = {
                                command = { "ipython" },
                                format = require("iron.fts.common").bracketed_paste,
                            },
                        },
                        repl_open_cmd = "vertical botright 80 split",
                    },
                })
            end,
        },
    }
else
    return {}
end
