local root_files = {
  "project.md",
}
local util = require "lspconfig/util"

return {
  root_dir = function(fname) return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
