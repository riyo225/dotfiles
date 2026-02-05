-- 検索ハイライト消去
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 診断情報のリスト表示
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- ターミナルから抜ける
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ウィンドウ間移動 (Ctrl + hjkl)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper window" })

-- Keybinding: Exit insert mode by pressing 'jj'
-- This is a faster alternative to the Esc key, keeping your hands on the home row.
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Performance: Set timeout for key sequences to 500ms
-- This ensures 'jj' is recognized quickly without too much delay.
vim.opt.timeoutlen = 500
