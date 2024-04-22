vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x') -- delete without yanking
keymap.set("n", "<leader>+", "<C-a>") -- increment number
keymap.set("n", "<leader>-", "<C-x>") -- decrement number

-- split
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- equalize splits
keymap.set("n", "<leader>sx", "<C-w>c") -- close split

-- tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- new tab
keymap.set("n", "<leader>tc", ":tabclose<CR>") -- close tab
keymap.set("n", "<leader>tn", ":tabnext<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabprevious<CR>") -- previous tab

-- plugins keymap
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- toggle keymap plugin
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- CR means Enter

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- terminal
keymap.set("n", "<leader>t", ":terminal")

-- move lines
-- Move line up
vim.api.nvim_set_keymap("n", "<leader>k", ":move -2<CR>", { noremap = true, silent = true })

-- Move line down
vim.api.nvim_set_keymap("n", "<leader>j", ":move +1<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
