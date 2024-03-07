local function get_npm_global_path()
  local handle = io.popen "npm root -g"
  local result = handle:read "*a"
  handle:close()
  -- 去除结果字符串末尾的换行符
  result = string.gsub(result, "[\r\n]+$", "")
  return result
end

local is_vue_project = require("utils").is_vue_project()
return {
  {
    ---@type LazySpec
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    ---@diagnostic disable: missing-fields
    opts = function(_, opts)
      local tsserver_handler = opts.handlers.tsserver
      if not is_vue_project then tsserver_handler = false end
      return require("astrocore").extend_tbl(opts, {
        handlers = {
          tsserver = tsserver_handler,
        },
        config = {
          tsserver = {
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
            init_options = {
              hostInfo = "neovim",
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = get_npm_global_path() .. "/@vue/typescript-plugin",
                  languages = {
                    "typescript",
                    "vue",
                  },
                },
              },
            },
            capabilities = {
              workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vue" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      -- opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "volar" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "js" })
    end,
  },
}
