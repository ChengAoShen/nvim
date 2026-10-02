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
-- <leader>th (inlay hints) is a Snacks toggle: plugins/ui.lua.
