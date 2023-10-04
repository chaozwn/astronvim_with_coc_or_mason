return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
        extraArgs = { "--profile", "rust-analyzer" },
      },
    },
  },
}
