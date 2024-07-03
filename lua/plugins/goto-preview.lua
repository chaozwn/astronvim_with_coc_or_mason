if true then return {} end

---@type LazySpec
return {
  {
    "rmagatti/goto-preview",
    dependencies = {
      {
        "AstroNvim/astrocore",
        ---@diagnostic disable: missing-parameter
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "gp"
          if require("astrocore").is_available "goto-preview" then
            local goto_preview = require "goto-preview"
            maps.n[prefix] = { desc = " Preview" }
            maps.n[prefix .. "d"] = {
              function() goto_preview.goto_preview_definition() end,
              desc = "Go to preview definition",
            }
            maps.n[prefix .. "t"] = {
              function() goto_preview.goto_preview_type_definition() end,
              desc = "Go to preview type definition",
            }
            maps.n[prefix .. "i"] = {
              function() goto_preview.goto_preview_implementation() end,
              desc = "Go to preview implementation",
            }
            maps.n[prefix .. "D"] = {
              function() goto_preview.goto_preview_declaration() end,
              desc = "Go to preview declaration",
            }
            maps.n[prefix .. "r"] = {
              function() goto_preview.goto_preview_references() end,
              desc = "Go to preview references",
            }
          end
        end,
      },
    },
    event = "BufEnter",
    config = true,
    opts = {},
  },
}
