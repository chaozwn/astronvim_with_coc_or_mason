-- set vim options here (vim.<first_key>.<second_key> = value)
local opt = {
  list = true, -- show whitespace characters
  listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
  showbreak = "↪ ",
  -- showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
  spellfile = vim.fn.expand "~/.config/nvim/lua/user/spell/en.utf-8.add",
  thesaurus = vim.fn.expand "~/.config/nvim/lua/user/spell/mthesaur.txt",
  swapfile = false,
  wrap = true, -- soft wrap lines
  termguicolors = true,
  wildmenu = true,
  wildmode = "longest:list,full",
}

local g = {
  mapleader = " ", -- set leader key
  maplocalleader = " ", -- set default local leader key
  transparent_background = true,
  resession_enabled = true,
  inlay_hints_enabled = true,
}

return {
  opt = opt,
  g = g,
  wo = {
    spell = false,
  },
}
