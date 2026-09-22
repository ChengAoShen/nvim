-- Global keymaps. Plugin keymaps live in that plugin's `keys` spec, and
-- buffer-local LSP ones in plugins/lsp.lua. Neovim 0.11+ already provides
-- grn/gra/grr/gri/grt/gO and ]d/[d, so none of those are redefined here.
local map = vim.keymap.set

map("i", "jj", "<ESC>", { desc = "Exit insert mode" })
map("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlight" })

map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

map("n", "gh", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Inlay hints start off; these work with no language server attached, which is
-- why they are not in the LspAttach block.
map("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
        { bufnr = 0 }
    )
end, { desc = "Toggle inlay hints (buffer)" })
map("n", "<leader>tH", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints (global)" })
