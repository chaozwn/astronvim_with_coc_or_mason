-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  vim.filetype.add {
    extension = {
      -- mdx = "mdx",
   		-- mdx = 'markdown.mdx',
      -- md = "markdown",
      -- mdx = 'astro-markdown',
      -- md = "astro-markdown",
    },
  }
  -- local ft_to_parser = require("nvim-treesitter.parsers"). ft_to_parser.mdx = "markdown"
  -- vim.treesitter
  -- .language
  -- .register ( "mdx", "markdown"  )
  vim.treesitter
  .language
  .register ( "markdown", "mdx"   )
  --
  --     vim.treesitter.language.register("astro-markdown", "mdx")
  --     vim.treesitter.language.register("astro-markdown", "md")
  -- vim.treesitter.language.register("astro-markdown", "makrdown")
  -- Set up custom filetypes
  vim.filetype.add {
    extension = {
      md = "markdown",
    },
    filename = {
      ["Markdown"] = "markdown",
    },
    pattern = {
      ["*.md"] = "markdown",
    },
  }
  --
  require "user.autocmds"
end
