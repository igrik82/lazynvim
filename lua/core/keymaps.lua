local keymap = vim.keymap

--Remap escape key
keymap.set("i", "jk", "<ESC>")
keymap.set("i", "kj", "<ESC>")

--bufferline
-- keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true })
-- keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true })

--Resize windows in vertical split
--keymap.set("n", "<C-]>", ":vertical resize -10<CR>", { noremap = true })
--keymap.set("n", "<C-[>", ":vertical resize +10<CR>", { noremap = true })
-- keymap.set("n", "<C-<Up>>", ":resize -2<CR>", { noremap = true })
-- keymap.set("n", "<C-'>", ":resize +2<CR>", { noremap = true })

--Nvim tree
-- keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

--Telescope
-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
-- keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Execute current python file in terminal
-- keymap.set("n", "<leader>t", ":w<CR>:belowright split |terminal python %<CR>")
--keymap.set(
--	"n",
--	"<leader>t",
--	":w<CR>:belowright split |!bash ~/Projects/cpp/compile.sh %<CR>|:q |:FloatermNew ./main<CR>"
--)
--keymap.set("n", "<leader>r", ":w<CR>:FloatermNew --height=0.9 --width=0.9 --autoclose=0 python %<CR>")

-- Copy micropython file to esp32
--keymap.set("n", "<leader>cv", ":w<CR>:! rshell --buffer-size=30 -p /dev/ttyUSB0 cp % /pyboard<CR>")

-- Execute micropython current file in esp32
--keymap.set("n", "<leader>e", ":w<CR>:! rshell --buffer-size=30 -p /dev/ttyUSB0 repl pyboard import %:r<CR>")
