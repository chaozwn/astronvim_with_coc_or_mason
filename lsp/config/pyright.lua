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
}
