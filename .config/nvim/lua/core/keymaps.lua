vim.g.mapleader = " "

-- Indentation keybinds for normal and visual mode
vim.keymap.set("v", "<Tab>", ">>", {desc="Indent"}) 
vim.keymap.set("v", "<S-Tab>", "<<", {desc="Outdent"}) 
vim.keymap.set("n", "<Tab>", ">>", {desc="Indent"}) 
vim.keymap.set("n", "<S-Tab>", "<<", {desc="Outdent"}) 

-- Keys to switch between buffers 
vim.keymap.set("n" ,"<S-Right>","<cmd>bnext<cr>",{desc="Switch to right buffer"})
vim.keymap.set("n" ,"<S-Left>","<cmd>bprev<cr>",{desc="Switch to right buffer"})
vim.keymap.set("n" ,"<S-D>","<cmd>bw<cr>",{desc="Wipeout current buffer"})

-- Yank to system clipboard 
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+Y')
vim.keymap.set("n", "<leader>yy", '"+yy')
