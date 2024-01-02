return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
            vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
            vim.keymap.set('n', '<Leader>lp',
                function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
                require('dap.ui.widgets').preview()
            end)
            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)
        end
    },

    {
        "nvim-telescope/telescope-dap.nvim",
        event = "VeryLazy",
        config = function()
            require('telescope').load_extension('dap')
            vim.keymap.set('n', '<F5>', function()
                require 'telescope'.extensions.dap.configurations {}
            end)
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        config = function()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        depends = { "williamboman/mason.nvim", "mfussenegger/nvim-dap", },
        config = function()
            require('mason-nvim-dap').setup({
                ensure_installed = { "debugpy" },
                handlers = {
                    function(config)
                        require('mason-nvim-dap').default_setup(config)
                    end,
                    python = function(config)
                        config.adapters = {
                            type = "executable",
                            command = "ipython",
                            args = {
                                "-m",
                                "debugpy.adapter",
                            },
                        }
                        require('mason-nvim-dap').default_setup(config) -- don't forget this!
                    end,
                },
            })
        end
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    }
}
