-- return {
--   root_dir = function(fname)
--     local util = require "lspconfig/util"
--     return util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
--   end,
-- }
--
local default_filetypes = {
  -- html
  "aspnetcorerazor",
  "astro",
  "astro-markdown",
  "blade",
  "clojure",
  "django-html",
  "htmldjango",
  "edge",
  "eelixir", -- vim ft
  "elixir",
  "ejs",
  "erb",
  "eruby", -- vim ft
  "gohtml",
  "haml",
  "handlebars",
  "hbs",
  "html",
  -- 'HTML (Eex)',
  -- 'HTML (EEx)',
  "html-eex",
  "heex",
  "jade",
  "leaf",
  "liquid",
  "markdown",
  "mdx",
  "mustache",
  "njk",
  "nunjucks",
  "php",
  "razor",
  "slim",
  "twig",
  -- css
  "css",
  "less",
  "postcss",
  "sass",
  "scss",
  "stylus",
  "sugarss",
  -- js
  "javascript",
  "javascriptreact",
  "reason",
  "rescript",
  "typescript",
  "typescriptreact",
  -- mixed
  "vue",
  "svelte",
}

local util = require "lspconfig/util"
local dynamic_filetypes = function()
  if util.root_pattern("tailwind.config.js", "tailwind.config.ts") then
    return default_filetypes
  else
    return {}
  end
end

return {
  filetypes = dynamic_filetypes(),
}
