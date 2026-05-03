local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>")
keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "gh", vim.diagnostic.open_float)
keymap.set("n", '<space>q', vim.diagnostic.setloclist)
