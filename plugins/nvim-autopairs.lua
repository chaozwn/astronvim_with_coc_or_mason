return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      enable_check_bracket_line = true,
      map_c_h = true,
      map_bs = true,
      check_ts = true,
      enable_abbr = true,
      map_cr = false
    })
  end,
}
