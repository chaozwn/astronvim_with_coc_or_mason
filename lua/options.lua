-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/options.lua
-- Add any additional options here

vim.opt.conceallevel = 2 -- enable conceal
vim.opt.concealcursor = ""
vim.opt.list = false -- show whitespace characters
vim.opt.listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" }
vim.opt.showbreak = "↪ "
vim.opt.showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1
vim.opt.spellfile = vim.fn.expand "~/.config/nvim/spell/en.utf-8.add"
vim.opt.splitkeep = "screen"
vim.opt.swapfile = false
vim.opt.thesaurus = vim.fn.expand "~/.config/nvim/spell/mthesaur.txt"
vim.opt.wrap = true -- soft wrap lines
vim.opt.scrolloff = 5 -- keep 3 lines when scrolling

vim.g.resession_enabled = true
