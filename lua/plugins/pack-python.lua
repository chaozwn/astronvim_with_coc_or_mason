local utils = require "astrocore"
local is_available = require("astrocore").is_available
local set_mappings = require("astrocore").set_mappings
local lsp_util = require "vim.lsp.util"

local function extract_method()
  local range_params = lsp_util.make_given_range_params()
  local arguments = { vim.uri_from_bufnr(0):gsub("file://", ""), range_params.range }
  print "extract_method"
  local params = {
    command = "pylance.extractMethod",
    arguments = arguments,
  }
  vim.lsp.buf.execute_command(params)
end

local function extract_variable()
  local range_params = lsp_util.make_given_range_params()
  local arguments = { vim.uri_from_bufnr(0):gsub("file://", ""), range_params.range }
  print "extract_variable"
  local params = {
    command = "pylance.extractVarible",
    arguments = arguments,
  }
  vim.lsp.buf.execute_command(params)
end

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local function on_workspace_executecommand(err, result, ctx)
  if ctx.params.command:match "WithRename" then
    ctx.params.command = ctx.params.command:gsub("WithRename", "")
    print(vim.inspect(ctx.params))
    vim.lsp.buf.execute_command(ctx.params)
  end
  if result then
    if result.label == "Extract Method" then
      local old_value = result.data.newSymbolName
      local file = vim.tbl_keys(result.edits.changes)[1]
      local range = result.edits.changes[file][1].range.start
      local params = { textDocument = { uri = file }, position = range }
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local bufnr = ctx.bufnr
      local prompt_opts = {
        prompt = "New Method Name: ",
        default = old_value,
      }
      if not old_value:find "new_var" then range.character = range.character + 5 end
      vim.ui.input(prompt_opts, function(input)
        if not input or #input == 0 then return end
        params.newName = input
        local handler = client.handlers["textDocument/rename"] or vim.lsp.handlers["textDocument/rename"]
        client.request("textDocument/rename", params, handler, bufnr)
      end)
    end
  end
end

return {
  { "microsoft/python-type-stubs" },
  { "pandas-dev/pandas-stubs" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = { "pylance" },
      ---@diagnostic disable: missing-fields
      config = {
        pylance = {
          on_attach = function(client, bufnr)
            if is_available "venv-selector.nvim" then
              set_mappings({
                n = {
                  ["<Leader>lv"] = {
                    "<cmd>VenvSelect<CR>",
                    desc = "Select VirtualEnv",
                  },
                  ["<Leader>lV"] = {
                    function()
                      require("astrocore").notify(
                        "Current Env:" .. require("venv-selector").get_active_venv(),
                        vim.log.levels.INFO
                      )
                    end,
                    desc = "Show Current VirtualEnv",
                  },
                },
              }, { buffer = bufnr })
            end
          end,
          filetypes = { "python" },
          root_dir = function(...)
            local util = require "lspconfig.util"
            return util.find_git_ancestor(...)
              or util.root_pattern(unpack {
                "pyproject.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                "pyrightconfig.json",
              })(...)
          end,
          cmd = { "pylance", "--stdio" },
          single_file_support = true,
          before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath "python" end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                completeFunctionParens = true,
                indexing = true,
                inlayHints = false,
                stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
                extraPaths = {
                  vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
                  vim.fn.stdpath "data" .. "/lazy/pandas-stubs/pandas-stubs",
                },
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "information",
                  reportUnusedFunction = "information",
                  reportUnusedVariable = "information",
                  reportGeneralTypeIssues = "none",
                  reportOptionalMemberAccess = "none",
                  reportOptionalSubscript = "none",
                  reportPrivateImportUsage = "none",
                },
              },
            },
          },
          handlers = {
            ["workspace/executeCommand"] = on_workspace_executecommand,
          },
          commands = {
            PylanceExtractMethod = {
              extract_method,
              description = "Extract Method",
            },
            PylanceExtractVarible = {
              extract_variable,
              description = "Extract Variable",
            },
            PylanceOrganizeImports = {
              organize_imports,
              description = "Organize Imports",
            },
          },
          docs = {
            description = "https://github.com/microsoft/pylance-release\n\n`pylance`, Fast, feature-rich language support for Python",
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
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "black", "isort" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "python" })
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    opts = {
      anaconda_base_path = "~/miniconda3",
      anaconda_envs_path = "~/miniconda3/envs",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
      require("dap-python").setup(path, opts)
    end,
  },
}
