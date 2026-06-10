local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlight" })
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "Diagnostic float" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
