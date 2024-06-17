---@type LazySpec
return {
  {
    "kiyoon/jupynium.nvim",
    dependencies = {
      "rcarriga/nvim-notify", -- optional
      "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
    },
    opts = {
      python_host = "python",
      default_notebook_URL = "localhost:8888/nbclassic",
      jupyter_command = "jupyter",
    },
    build = "pip install --user .",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  },
}
