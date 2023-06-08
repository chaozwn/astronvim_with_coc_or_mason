return {
-- filetypes={
-- 	  "markdown",
-- 	  "markdown.mdx",
-- 	  "md",
-- 	  "mdx"
-- 	},
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      },
    },
  },
}
