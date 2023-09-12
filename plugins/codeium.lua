return {
  {
    "jcdickinson/http.nvim",
    build = "cargo build --workspace --release",
    lazy = false,
    enabled = true,
  },
  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "jcdickinson/http.nvim",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function() require("codeium").setup {} end,
    lazy = false,
    enabled = true,
  },
}

