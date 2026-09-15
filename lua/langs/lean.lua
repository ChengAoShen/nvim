-- Lean 4. The language server ships with the toolchain (elan/lake), not mason,
-- and lean.nvim enables it itself: it provides its own lsp/leanls.lua and calls
-- `vim.lsp.enable 'leanls'`, so no entry under `lsp` here. blink.cmp installs
-- its capabilities globally via vim.lsp.config('*'), so leanls picks those up
-- without extra wiring.
--
-- No treesitter parser either: tree-sitter-manager's registry has no `lean`,
-- and lean.nvim ships syntax/lean.vim for highlighting.
return {
    enabled = true,
    plugins = {
        {
            "Julian/lean.nvim",
            -- Neovim detects the `lean` filetype on its own, so ft-lazy works.
            ft = { "lean" },
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                mappings = true,
                -- `\alpha` -> α while typing. The leader here is insert-mode
                -- only, so it does not collide with maplocalleader ("\").
                abbreviations = { enable = true },
                infoview = {
                    autoopen = true,
                    orientation = "vertical",
                    width = 60,
                },
            },
        },
    },
}
