-- TM_SELECTED_TEXT The currently selected text or the empty string
-- TM_CURRENT_LINE The contents of the current line
-- TM_CURRENT_WORD The contents of the word under cursor or the empty string
-- TM_LINE_INDEX The zero-index based line number
-- TM_LINE_NUMBER The one-index based line number
-- TM_FILENAME The filename of the current document
-- TM_FILENAME_BASE The filename of the current document without its extensions
-- TM_DIRECTORY The directory of the current document
-- TM_FILEPATH The full file path of the current document

---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    -- load snippets paths
    require("luasnip.loaders.from_vscode").lazy_load {
      paths = { vim.fn.stdpath "config" .. "/snippets" },
    }
  end,
}
