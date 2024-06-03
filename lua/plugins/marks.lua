---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["m"] = { desc = "󰈚 Marks" },
          ["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" },
          ["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" },
          ["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" },
          ["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" },
          ["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" },
          ["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" },
          ["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" },
          ["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" },
        },
      },
    },
  },
  {
    "chentoast/marks.nvim",
    event = "User AstroFile",
    opts = {
      default_mappings = false,
      excluded_filetypes = {
        "qf",
        "NvimTree",
        "toggleterm",
        "TelescopePrompt",
        "alpha",
        "netrw",
        "neo-tree",
      },
    },
  },
}
