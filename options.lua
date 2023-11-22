-- set vim options here (vim.<first_key>.<second_key> = value)
local opt = {
  list = true, -- show whitespace characters
  listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
  showbreak = "↪ ",
  swapfile = false,
  wrap = true, -- soft wrap lines
  -- termguicolors = false,
  termguicolors = true,
  wildmenu = true,
  wildmode = "longest:list,full",
-- <<<<<<< HEAD
--   cmdheight = 1,
--   pumheight = 35,
-- =======
-- >>>>>>> origin/mason
}

local g = {
  mapleader = " ", -- set leader key
  maplocalleader = " ", -- set default local leader key
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
