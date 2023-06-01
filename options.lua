-- set vim options here (vim.<first_key>.<second_key> = value)
local opt = {
  -- conceallevel = 2, -- enable conceal
  list = true, -- show whitespace characters
  listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
  showbreak = "↪ ",
  -- showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
  spellfile = vim.fn.expand "~/.config/nvim/lua/user/spell/en.utf-8.add",
  thesaurus = vim.fn.expand "~/.config/nvim/lua/user/spell/mthesaur.txt",
  swapfile = false,
  wrap = true, -- soft wrap lines
  termguicolors = true,
}

local g = {}

local lsp_type = require("user.config.lsp_type").lsp_type
if lsp_type == 'coc' then
  opt["backup"] = false
  opt["writebackup"] = false
  opt["updatetime"] = 300
  opt["signcolumn"] = "yes"
  g["coc_global_extensions"] = {
    'coc-marketplace',
    '@yaegassy/coc-volar',
    'coc-emmet',
    'coc-tsserver',
    'coc-json',
    'coc-html',
    'coc-css',
    'coc-clangd',
    'coc-go',
    'coc-sumneko-lua',
    'coc-vimlsp',
    'coc-sh',
    'coc-db',
    'coc-pyright',
    'coc-toml',
    'coc-prettier',
    'coc-snippets',
    'coc-pairs',
    'coc-word',
    'coc-translator',
    'coc-yank',
    'coc-highlight',
    'coc-eslint',
  }
end

return {
  opt = opt,
  g = g,
  wo = {
    spell = false,
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
-- end
-- end
