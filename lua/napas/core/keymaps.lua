vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- splits equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current spilt window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open current buffer in new tab

-- terminal
keymap.set("n", "<leader>cf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Open Horizontally Terminal" }) -- open terminal
keymap.set("n", "<leader>ch", "<cmd>ToggleTerm<CR>", { desc = "Open Float Terminal" }) -- open terminal

-- git blame
keymap.set("n", "<leader>ge", "<cmd>GitBlameEnable<CR>", { desc = "Enable git blame message" }) -- enable git blame message
keymap.set("n", "<leader>gd", "<cmd>GitBlameDisable<CR>", { desc = "Disable git blame message" }) -- disable git blame
keymap.set("n", "<leader>go", "<cmd>GitBlameOpenFileURL<CR>", { desc = "Open the file in the default browser" }) -- open file in default browser
