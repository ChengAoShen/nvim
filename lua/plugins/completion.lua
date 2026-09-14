return {
    -- Completion engine; provides the LSP capabilities consumed in plugins/lsp.lua.
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = {
                preset = "default",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },
            appearance = { nerd_font_variant = "mono" },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
    },
}
