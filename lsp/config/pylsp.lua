local util = require "lspconfig/util"

return {
  root_dir = function(fname)
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      "main.py",
    }
    return util.find_git_ancestor(fname) or util.root_pattern(unpack(root_files))(fname)
  end,
  settings = {
    pylsp = {
      configurationSources = { "pycodestyle" },
      plugins = {
        rope_autoimport = { enabled = true, memory = true },
        rope_completion = { enabled = true, eager = true },
      },
    },
  },
  plugins = {
    -- If this plugin does not work try running MyPy from the
    -- command line first
    pylsp_mypy = {
      enabled = true,
      live_mode = true,
    },
    rope_autoimport = { enabled = true, memory = true },
    rope_completion = { enabled = true, eager = true },
  },
}
