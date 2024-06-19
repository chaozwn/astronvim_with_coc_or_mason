---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.recipes.auto-session-restore" },
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        maps.n["gr"] = { desc = "lsp operations" }
        maps.n["grr"] = false
        maps.n["grn"] = false
        maps.n["gra"] = false
      end
      opts.mappings = maps
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        if maps.n["<Leader>lR"] then maps.n["gr"] = maps.n["<Leader>lR"] end
      end
      opts.mappings = maps
    end,
  },
}
