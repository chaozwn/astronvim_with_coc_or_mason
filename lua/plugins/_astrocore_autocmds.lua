return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      auto_turnoff_paste = {
        event = "InsertLeave",
        pattern = "*",
        command = "set nopaste",
      },
    },
  },
}
