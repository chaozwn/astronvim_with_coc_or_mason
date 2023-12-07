return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      default_prompt = "➤ ",
      win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
    },
    select = {
      backend = { "telescope", "builtin" },
      builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      get_config = function(opts)
        if opts.kind == "codeaction" then
          return {
            backend = "nui",
            -- nui = {
            --   relative = "cursor",
            --   max_width = 40,
            -- },
          }
        end
      end,
    },
  },
  lazy = false,
}
