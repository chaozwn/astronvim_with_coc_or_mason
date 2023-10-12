local lsp_util = require "lspconfig.util"
return {
  root_dir = function(fname) return lsp_util.root_pattern("astro.config.mjs",
				"astro.config.js",
				"astro.config.cjs",
				"package.json")(fname) end,
	filetypes={
	  "astro",
	  "md",
	  "mdx"
	}
}
