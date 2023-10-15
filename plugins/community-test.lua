return {
  { import = "astrocommunity.test.neotest" },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if require("lazyvim.util").has "trouble.nvim" then
              vim.cmd "Trouble quickfix"
            else
              vim.cmd "copen"
            end
          end,
        },
      })
    end,
  },
}
