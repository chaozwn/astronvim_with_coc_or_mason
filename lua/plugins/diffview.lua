local prefix_diff_view = "<Leader>g"
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          [prefix_diff_view .. "g"] = {
            function() vim.cmd [[DiffviewOpen]] end,
            desc = "Open Git Diffview",
          },
          [prefix_diff_view .. "d"] = {
            function() vim.cmd [[DiffviewClose]] end,
            desc = "Close Git Diffview",
          },
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function() end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
    opts = function(_, opts)
      require("astrocore").extend_tbl(opts, {
        enhanced_diff_hl = true,
        view = {
          default = { winbar_info = true },
          file_history = { winbar_info = true },
        },
        hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    optional = true,
    opts = { integrations = { diffview = true } },
  },
}
