-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  vim.filetype.add {
    extension = {
      mdx = "mdx",
      md = "markdown",
    },
  }
  -- local ft_to_parser = require("nvim-treesitter.parsers"). ft_to_parser.mdx = "markdown"
  vim.treesitter
  .language
  .register ( "mdx", "markdown"  )

  -- Set up custom filetypes
  -- vim.filetype.add {
  --   extension = {
  --     foo = "fooscript",
  --   },
  --   filename = {
  --     ["Foofile"] = "fooscript",
  --   },
  --   pattern = {
  --     ["~/%.config/foo/.*"] = "fooscript",
  --   },
  --
  require "user.autocmds"
end
