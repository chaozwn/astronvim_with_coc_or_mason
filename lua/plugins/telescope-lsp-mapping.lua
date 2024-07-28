return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        maps.n["gd"] = {
          function() require("telescope.builtin").lsp_definitions { reuse_win = true } end,
          desc = "Show the definition of current symbol",
        }
        maps.n["gI"] = {
          function() require("telescope.builtin").lsp_implementations { reuse_win = true } end,
          desc = "Implementation of current symbol",
        }
        maps.n["gy"] = {
          function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,
          desc = "Definition of current type",
        }
        maps.n["<Leader>lG"] = {
          function()
            vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
              if query then
                -- word under cursor if given query is empty
                if query == "" then query = vim.fn.expand "<cword>" end
                require("telescope.builtin").lsp_workspace_symbols {
                  query = query,
                  prompt_title = ("Find word (%s)"):format(query),
                }
              end
            end)
          end,
          desc = "Search workspace symbols",
        }
        maps.n["<Leader>lR"] =
          { function() require("telescope.builtin").lsp_references() end, desc = "Search references" }
        maps.n["gr"] = { function() require("telescope.builtin").lsp_references() end, desc = "Search references" }
      end
      opts.mappings = maps
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        maps.n["gra"] = false
        maps.n["grr"] = false
        maps.n["grn"] = false
      end
      opts.mappings = maps
    end,
  },
}
