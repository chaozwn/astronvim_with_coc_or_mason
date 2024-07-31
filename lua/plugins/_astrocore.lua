local utils = require "utils"

---@type LazySpec
return {
  ---@type AstroCoreOpts
  "AstroNvim/astrocore",
  opts = {
    -- Configure project root detection, check status with `:AstroRootInfo`
    diagnostics = {
      update_in_insert = false,
    },
    -- modify core features of AstroNvim
    features = {
      notifications = true, -- enable notifications at start
    },
    -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    filetypes = {
      extension = {
        mdx = "markdown.mdx",
        qmd = "markdown",
        yml = utils.yaml_ft,
        yaml = utils.yaml_ft,
        json = "jsonc",
        api = "goctl",
        MD = "markdown",
        tpl = "gotmpl",
      },
      filename = {
        [".eslintrc.json"] = "jsonc",
      },
      pattern = {
        ["/tmp/neomutt.*"] = "markdown",
        ["tsconfig*.json"] = "jsonc",
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".env.*"] = "sh"
      },
    },
  },
}
