return {
  name = "goframe run",
  builder = function()
    return {
      cmd = "gf",
      args = { "run", "main.go" },
      cwd = vim.fn.getcwd(),
      components = {
        "on_complete_notify",
        "on_exit_set_status",
      },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
