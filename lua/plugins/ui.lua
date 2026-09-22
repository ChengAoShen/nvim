-- Ordered by repository name.
return {
    {
        "Bekaboo/dropbar.nvim",
        event = "BufReadPost",
        keys = {
            {
                "<leader>;",
                function()
                    require("dropbar.api").pick()
                end,
                desc = "Pick winbar symbol",
            },
            {
                "[;",
                function()
                    require("dropbar.api").goto_context_start()
                end,
                desc = "Go to context start",
            },
            {
                "];",
                function()
                    require("dropbar.api").select_next_context()
                end,
                desc = "Select next context",
            },
        },
    },

    {
        "NStefan002/screenkey.nvim",
        cmd = "Screenkey",
        opts = {},
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("config.colors").setup()
        end,
    },

    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
        -- Stands in for nvim-web-devicons, which several plugins require directly.
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            -- Centred, overriding the command_palette preset's top position.
            views = {
                cmdline_popup = {
                    position = { row = "50%", col = "50%" },
                },
            },
        },
    },

    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 900,
        opts = {
            dashboard = {
                enabled = true,
                preset = {
                    header = table.concat({
                        "                                                     ",
                        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                        "                                                     ",
                    }, "\n"),
                },
            },
            explorer = { enabled = true },
            indent = { enabled = true },
            notifier = { enabled = true },
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        hidden = true,
                        win = { list = { keys = { ["<C-N>"] = "close" } } },
                    },
                },
            },
            scroll = { enabled = true },
        },
        keys = {
            {
                "<leader>ff",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Live grep",
            },
            {
                "<leader><space>",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help tags",
            },
            {
                "<leader>?",
                function()
                    Snacks.picker.recent()
                end,
                desc = "Recent files",
            },
            {
                "<leader>/",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Search in buffer",
            },
            {
                "<C-N>",
                function()
                    Snacks.explorer()
                end,
                desc = "Open file explorer",
                mode = { "n", "t" },
            },

            {
                "<C-\\>",
                function()
                    Snacks.terminal.toggle()
                end,
                desc = "Toggle terminal",
                mode = { "n", "t" },
            },
            {
                "<leader>tt",
                function()
                    Snacks.terminal()
                end,
                desc = "New terminal",
            },

            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>gf",
                function()
                    Snacks.lazygit.log_file()
                end,
                desc = "Lazygit file history",
            },
            {
                "<leader>gl",
                function()
                    Snacks.lazygit.log()
                end,
                desc = "Lazygit log",
            },
            {
                "<leader>gb",
                function()
                    Snacks.picker.git_log_line()
                end,
                desc = "Git blame line",
            },
            {
                "<leader>gs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git status",
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                always_show_tabline = false, -- hidden until a second tabpage exists
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "buffers", mode = 2, show_filename_only = true } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            tabline = {
                lualine_a = {
                    {
                        "tabs",
                        mode = 2,
                        path = 0,
                        tab_max_length = 24,
                        symbols = { modified = " ●" },
                    },
                },
                lualine_z = {
                    {
                        function()
                            return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                        end,
                    },
                },
            },
        },
    },
}
