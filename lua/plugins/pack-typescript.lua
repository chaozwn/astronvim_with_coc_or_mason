local utils = require "astrocore"
local set_mappings = utils.set_mappings

local function decode_json(filename)
  -- Open the file in read mode
  local file = io.open(filename, "r")
  if not file then
    return false -- File doesn't exist or cannot be opened
  end

  -- Read the contents of the file
  local content = file:read "*all"
  file:close()

  -- Parse the JSON content
  local json_parsed, json = pcall(vim.fn.json_decode, content)
  if not json_parsed or type(json) ~= "table" then
    return false -- Invalid JSON format
  end
  return json
end

local format_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local function check_json_key_exists(json, ...) return vim.tbl_get(json, ...) ~= nil end
local lsp_rooter, prettierrc_rooter
local has_prettier = function(bufnr)
  if type(bufnr) ~= "number" then bufnr = vim.api.nvim_get_current_buf() end
  local rooter = require "astrocore.rooter"
  if not lsp_rooter then lsp_rooter = rooter.resolve "lsp" end
  if not prettierrc_rooter then
    prettierrc_rooter = rooter.resolve {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      "prettier.config.js",
      ".prettierrc.mjs",
      "prettier.config.mjs",
      "prettier.config.cjs",
      ".prettierrc.toml",
    }
  end
  local prettier_dependency = false
  for _, root in ipairs(require("astrocore").list_insert_unique(lsp_rooter(bufnr), { vim.fn.getcwd() })) do
    local package_json = decode_json(root .. "/package.json")
    if
      package_json
      and (
        check_json_key_exists(package_json, "dependencies", "prettier")
        or check_json_key_exists(package_json, "devDependencies", "prettier")
      )
    then
      prettier_dependency = true
      break
    end
  end
  return prettier_dependency or next(prettierrc_rooter(bufnr))
end

local null_ls_formatter = function(params)
  if vim.tbl_contains(format_filetypes, params.filetype) then return has_prettier(params.bufnr) end
  return true
end

return {
  ---@type LazySpec
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    ---@diagnostic disable: missing-fields
    opts = {
      autocmds = {
        eslint_fix_on_save = {
          cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
          {
            event = "BufWritePost",
            desc = "Fix all eslint errors",
            callback = function() vim.cmd.EslintFixAll() end,
          },
        },
      },
      config = {
        vtsls = {
          on_attach = function()
            set_mappings({
              n = {
                ["<Leader>la"] = {
                  function() vim.lsp.buf.code_action { context = { only = { "source", "refactor", "quickfix" } } } end,
                  desc = "Lsp All Action",
                },
              },
            }, { buffer = true })
          end,
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = true },
              },
            },
            vtsls = {
              enableMoveToFileCodeAction = true,
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          utils.list_insert_unique(opts.ensure_installed, { "javascript", "typescript", "tsx", "jsdoc" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "eslint", "vtsls" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "prettierd" })
      if not opts.handlers then opts.handlers = {} end

      opts.handlers.prettierd = function(source_name, methods)
        local null_ls = require "null-ls"
        for _, method in ipairs(methods) do
          null_ls.register(null_ls.builtins[method][source_name].with { runtime_condition = null_ls_formatter })
        end
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "js" }) end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
  { "dmmulroy/ts-error-translator.nvim", opts = {}, ft = { "typescript", "vue" } },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      if not dap.configurations.javascript then
        dap.configurations.javascript = js_config
      else
        utils.extend_tbl(dap.configurations.javascript, js_config)
      end
    end,
  },
  {
    "bennypowers/template-literal-comments.nvim",
    ft = { "javascript", "typescript" },
    config = true,
  },
}
