return {
    enabled = true,
    treesitter = { "markdown", "markdown_inline" },
    format = { markdown = { "dprint" } },
    tools = { "dprint" },
    plugins = {
        -- In-buffer markdown rendering (headings, code blocks, tables, checkboxes…)
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = { "markdown" },
            dependencies = { "echasnovski/mini.icons" },
            opts = {},
            keys = {
                { "<leader>tm", function() require("render-markdown").toggle() end, desc = "Toggle markdown render" },
            },
        },
    },
}
