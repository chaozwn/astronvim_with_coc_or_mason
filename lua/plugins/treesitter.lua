-- :TSInstall lua
-- NOTE: https://github.com/AstroNvim/AstroNvim/commit/377db3f7d6273779533c988dadc07a08e0e43f2e new textobject
-- NOTE: treesitter new textobject. k: block, c: class, ?: conditional, f: function, l: loop, a: parameter, ""< | > | A ,F ,K" swap textobject
local is_available = require("astrocore").is_available

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
      local maps = opts.mappings
      if maps then
        if is_available "nvim-treesitter" then
          -- TsInformation
          maps.n["<Leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }
        end
      end
      -- telescope plugin mappings
      opts.mappings = maps
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}
