---@type LazySpec
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  specs = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>fu"] = {
            "<cmd>UndotreeToggle<CR>",
            desc = "Find undotree",
          },
        },
      },
    },
  },
}
