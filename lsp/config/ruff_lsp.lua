return {
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = { "--config=$HOME/.config/ruff/ruff.toml" },
    },
  },
  settings = {
    ruff_lsp = {
      organizeImports = true,
    },
  },
}
