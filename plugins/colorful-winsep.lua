return {
  ------------------------ 多窗口聚焦提示 -------------------
  "nvim-zh/colorful-winsep.nvim",
  event = "WinNew",
  opts = {
    -- This plugin will not be activated for filetype in the following table.
    no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "alpha" },
    -- highlight for Window separator
    highlight = {
      bg = "#16161E",
      fg = "#30cfd0",
    },
  },
}
