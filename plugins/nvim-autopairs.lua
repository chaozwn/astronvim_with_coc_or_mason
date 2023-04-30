return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      enable_moveright = true,
    })
  end,
}
