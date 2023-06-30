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
  cmdheight = 1,
}

local is_mac = require("user.utils.utils").is_mac()
local get_coc_config_home = function()
  if is_mac then
    return "~/.config/nvim/lua/user"
  else
    return "~/.config/nvim"
  end
end
local g = {
  transparent_background = true,
  resession_enabled = true,
  -- lsp_type
  lsp_type = "coc",
  -- lsp_type = "lsp",
  -- fix coc completion problem
  coc_snippet_next = "<C-n>",
  coc_snippet_prev = "<C-p>",
  coc_config_home = get_coc_config_home(),
}

if g.lsp_type == "coc" then
  opt["backup"] = false
  opt["writebackup"] = false
  opt["updatetime"] = 300
  opt["signcolumn"] = "yes"
  g["coc_global_extensions"] = {
    "coc-marketplace",
    "coc-emmet",
    "coc-tsserver",
    "coc-json",
    "coc-html",
    "coc-css",
    "coc-clangd",
    "coc-go",
    "coc-sumneko-lua",
    "coc-vimlsp",
    "coc-sh",
    "coc-db",
    "coc-pyright",
    "coc-toml",
    "coc-prettier",
    "coc-snippets",
    "coc-pairs",
    "coc-highlight",
    "coc-eslint",
    "@yaegassy/coc-tailwindcss3",
  }
end

return {
  opt = opt,
  g = g,
  wo = {
    spell = false,
  },
}
