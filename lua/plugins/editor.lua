-- Ordered by repository name.

-- `flash("jump")` -> a function calling require("flash").jump().
local function flash(fn)
    return function()
        require("flash")[fn]()
    end
end

local function todo(fn)
    return function()
        require("todo-comments")[fn]()
    end
end

return {
    { "echasnovski/mini.ai", event = "VeryLazy", opts = {} },

    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {
            -- J/K rather than the default <M-j>/<M-k> in visual mode.
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "J",
                up = "K",
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
        },
    },

    {
        "folke/flash.nvim",
        lazy = true,
        opts = {
            -- Inline labels with priority below inlay hints (default 4096), so
            -- a label renders right after the match, not after the LSP type.
            label = { style = "inline" },
            highlight = { priority = 1000 },
        },
        keys = {
            { "s", flash("jump"), mode = { "n", "x", "o" }, desc = "Flash" },
            -- No `x`: visual-mode S is nvim-surround's, and it would silently
            -- win this anyway by loading later.
            {
                "S",
                flash("treesitter"),
                mode = { "n", "o" },
                desc = "Flash Treesitter",
            },
            { "r", flash("remote"), mode = "o", desc = "Remote Flash" },
            {
                "R",
                flash("treesitter_search"),
                mode = { "o", "x" },
                desc = "Treesitter Search",
            },
            { "<c-s>", flash("toggle"), mode = "c", desc = "Toggle Flash Search" },
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            {
                "<leader>ft",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo comments",
            },
            { "]t", todo("jump_next"), desc = "Next todo" },
            { "[t", todo("jump_prev"), desc = "Prev todo" },
        },
    },

    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

    {
        "mrjones2014/smart-splits.nvim",
        lazy = true,
        -- Terminal mode uses <C-hjkl>, not <leader>hjkl: the leader is <Space>,
        -- so a `t`-mode <leader>h mapping turns every space typed in a terminal
        -- into a 'timeoutlen' wait, and swallows it outright when the next
        -- keystroke is h/j/k/l (" how", " list", " just"...).
        keys = function()
            local keys = {}
            for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
                local function move()
                    require("smart-splits")["move_cursor_" .. dir]()
                end
                local desc = "Move to " .. dir .. " split"
                table.insert(keys, { "<leader>" .. key, move, mode = "n", desc = desc })
                table.insert(
                    keys,
                    { "<C-" .. key .. ">", move, mode = "t", desc = desc }
                )
            end
            return keys
        end,
    },

    { "wakatime/vim-wakatime", event = "VeryLazy" },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
