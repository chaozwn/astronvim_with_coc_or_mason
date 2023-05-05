local util = require "lspconfig/util"

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  'main.py'
}

return {
  root_dir = function(fname) return util.find_git_ancestor(fname) or util.root_pattern(root_files) end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
      },
    },
  },
}
