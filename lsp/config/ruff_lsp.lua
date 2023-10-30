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
    return util.find_git_ancestor(fname) or util.root_pattern(table.unpack(root_files))(fname)
  end,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = { "--config=$HOME/.config/ruff/ruff.toml" },
      organizeImports = true,
      fixAll = true,
    },
  },
  settings = {},
}
