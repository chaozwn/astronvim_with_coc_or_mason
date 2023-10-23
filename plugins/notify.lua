return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    local newOpt = {
      timeout = 0,
    }
    return require("astronvim.utils").extend_tbl(opts, newOpt)
  end,
}
