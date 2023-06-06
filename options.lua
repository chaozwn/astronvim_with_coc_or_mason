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
  resession_enabled = true,
  -- lsp_type = "lsp",
  lsp_type = "coc",
}

if g.lsp_type == "coc" then
  opt["backup"] = false
  opt["writebackup"] = false
  opt["updatetime"] = 300
  opt["signcolumn"] = "yes"
  g["coc_global_extensions"] = {
    "coc-marketplace",
    "@yaegassy/coc-volar",
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
    "coc-word",
    "coc-translator",
    "coc-yank",
    "coc-highlight",
    "coc-eslint",
    "@yaegassy/coc-tailwindcss3"
  }
end

return {
  opt = opt,
  g = g,
  wo = {
    spell = false,
  },
}
