return {
  name = "run goctl api generate",
  params = {
    cmd = { optional = true, type = "string", default = "goctl" },
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
    filetype = { "goctl" },
  },
}
