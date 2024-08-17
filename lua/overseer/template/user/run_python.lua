return {
  name = "run python script",
  params = {
    cmd = { optional = true, type = "string", default = "python" },
    cwd = { optional = true, type = "string" },
  },
  builder = function(params)
    return {
      name = vim.fn.expand "%:t",
      cmd = params.cmd,
      args = { vim.fn.expand "%:p" },
      cwd = vim.fn.expand "%:p:h",
      components = {
        "task_list_on_start",
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
        "on_output_summarize",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
