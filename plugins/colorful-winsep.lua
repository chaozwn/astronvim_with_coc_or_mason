return {
  ------------------------ 多窗口聚焦提示 -------------------
  "nvim-zh/colorful-winsep.nvim",
  event = "WinNew",
  opts = {
    -- This plugin will not be activated for filetype in the following table.
    no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
    -- highlight for Window separator
    highlight = {
      bg = "#16161E",
      fg = "#a7a6cb",
    },
  },
}
