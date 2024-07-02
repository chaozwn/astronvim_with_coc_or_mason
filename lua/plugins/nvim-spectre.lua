return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Spectre = "󰛔" } } },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>s"
          maps.n[prefix] = { desc = require("astroui").get_icon("Spectre", 1, true) .. "Search / Replace" }
          maps.n[prefix .. "s"] = { function() require("spectre").open() end, desc = "Spectre" }
          maps.n[prefix .. "f"] =
            { function() require("spectre").open_file_search() end, desc = "Spectre (current file)" }

          maps.x[prefix] = maps.n[prefix]
          maps.x[prefix .. "w"] = {
            function() require("spectre").open_visual { select_word = true } end,
            desc = "Spectre (current word)",
          }
        end,
      },
    },
    opts = function()
      return {
        mapping = {
          send_to_qf = { map = "<Leader>f" },
        },
      }
    end,
  },
}
