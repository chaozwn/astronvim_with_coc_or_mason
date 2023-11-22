return {
  { import = "astrocommunity.test.neotest" },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        status = { virtual_text = true },
        output = { open_on_run = true },
      })
    end,
  },
}
