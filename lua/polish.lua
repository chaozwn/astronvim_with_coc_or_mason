local utils = require "utils"

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
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
    [".env.*"] = "sh",
  },
}
