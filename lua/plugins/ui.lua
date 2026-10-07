-- Ordered by repository name.

-- `snacks("picker.files")` -> a function calling Snacks.picker.files().
local function snacks(path)
    return function()
        local fn = Snacks
        for key in path:gmatch("[^.]+") do
            fn = fn[key]
        end
        fn()
    end
end

local function dropbar(fn)
    return function()
        require("dropbar.api")[fn]()
    end
end

return {
    {
        "Bekaboo/dropbar.nvim",
        event = "BufReadPost",
        keys = {
            { "<leader>;", dropbar("pick"), desc = "Pick winbar symbol" },
            { "[;", dropbar("goto_context_start"), desc = "Go to context start" },
            { "];", dropbar("select_next_context"), desc = "Select next context" },
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
        priority = 1000,
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
        config = function(_, opts)
            require("snacks").setup(opts)
            Snacks.toggle.inlay_hints():map("<leader>th")
        end,
        keys = {
            { "<leader>ff", snacks("picker.files"), desc = "Find files" },
            { "<leader>fg", snacks("picker.grep"), desc = "Live grep" },
            { "<leader><space>", snacks("picker.buffers"), desc = "Buffers" },
            { "<leader>fh", snacks("picker.help"), desc = "Help tags" },
            { "<leader>?", snacks("picker.recent"), desc = "Recent files" },
            { "<leader>/", snacks("picker.lines"), desc = "Search in buffer" },
            {
                "<C-N>",
                snacks("explorer"),
                mode = { "n", "t" },
                desc = "Open file explorer",
            },

            {
                "<C-\\>",
                snacks("terminal.toggle"),
                mode = { "n", "t" },
                desc = "Toggle terminal",
            },
            { "<leader>tt", snacks("terminal"), desc = "New terminal" },

            { "<leader>gg", snacks("lazygit"), desc = "Lazygit" },
            { "<leader>gf", snacks("lazygit.log_file"), desc = "Lazygit file history" },
            { "<leader>gl", snacks("lazygit.log"), desc = "Lazygit log" },
            { "<leader>gb", snacks("picker.git_log_line"), desc = "Git blame line" },
            { "<leader>gs", snacks("picker.git_status"), desc = "Git status" },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        -- Only what differs from lualine's defaults; it merges per section.
        opts = {
            options = {
                globalstatus = true,
                always_show_tabline = false, -- hidden until a second tabpage exists
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_c = { { "buffers", mode = 2, show_filename_only = true } },
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
