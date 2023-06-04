return {
  "stevearc/resession.nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {})
  end
}
