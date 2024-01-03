-- set vim options here (vim.<first_key>.<second_key> = value)
local opt = {
  list = true, -- show whitespace characters
  listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
  showbreak = "↪ ",
}

local g = {
  mapleader = " ", -- set leader key
  maplocalleader = " ", -- set default local leader key
  resession_enabled = true,
  inlay_hints_enabled = true,
  transparent_background = true
}

return {
  opt = opt,
  g = g,
  wo = {
    spell = false,
  },
}
