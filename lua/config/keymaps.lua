vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>")
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>")
keymap.set("n", "<A-Tab>", "<cmd>bNext<CR>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local opts = { noremap = true, silent = true }
keymap.set("n", '<space>e', vim.diagnostic.open_float, opts)
keymap.set("n", '[d', vim.diagnostic.goto_prev, opts)
keymap.set("n", ']d', vim.diagnostic.goto_next, opts)
keymap.set("n", '<space>q', vim.diagnostic.setloclist, opts)

keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
