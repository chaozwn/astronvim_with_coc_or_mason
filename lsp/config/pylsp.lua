local util = require "lspconfig/util"

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  "main.py",
}
return {
  root_dir = function(fname) return util.find_git_ancestor(fname) or util.root_pattern(root_files) end,
  settings = {
    pylsp = {
      configurationSources = { "pycodestyle" },
      plugins = {
        rope_autoimport = { enabled = true, memory = true },
        rope_completion = { enabled = true, eager = true },
      },
    },
  },
}
