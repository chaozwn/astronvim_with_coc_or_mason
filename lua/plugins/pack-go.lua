--TODO: https://github.com/golang/go/issues/60903

local function create_buf_config_file()
  local source_file = vim.fn.stdpath "config" .. "/buf.yaml"
  local target_file = vim.fn.getcwd() .. "/buf.yaml"
  local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
  local cmd = is_windows
      and string.format("copy %s %s", vim.fn.shellescape(source_file, true), vim.fn.shellescape(target_file, true))
    or string.format("cp %s %s", vim.fn.shellescape(source_file), vim.fn.shellescape(target_file))
  os.execute(cmd)
end

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        gopls = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = { dynamicRegistration = true },
            },
            textDocument = {
              completion = {
                completionItem = {
                  commitCharactersSupport = true,
                  deprecatedSupport = true,
                  documentationFormat = { "markdown", "plaintext" },
                  preselectSupport = true,
                  insertReplaceSupport = true,
                  labelDetailsSupport = true,
                  snippetSupport = true,
                  resolveSupport = {
                    properties = {
                      "documentation",
                      "details",
                      "additionalTextEdits",
                    },
                  },
                },
                contextSupport = true,
                dynamicRegistration = true,
              },
            },
          },
          on_attach = function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end,
          settings = {
            gopls = {
              analyses = {
                ST1003 = false,
                fieldalignment = false,
                fillreturns = true,
                nilness = true,
                nonewvars = true,
                shadow = true,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = false, -- Show a code lens toggling the display of gc's choices.
                generate = true, -- show the `go generate` lens.
                regenerate_cgo = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              buildFlags = { "-tags", "integration" },
              completeUnimported = true,
              diagnosticsDelay = "500ms",
              matcher = "Fuzzy",
              semanticTokens = true,
              staticcheck = true,
              symbolMatcher = "fuzzy",
              usePlaceholders = false,
            },
          },
        },
      },
    },
  },
  -- Golang support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(
          opts.ensure_installed,
          { "go", "gomod", "gosum", "gowork", "goctl", "gotmpl" }
        )
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "gomodifytags",
        "gotests",
        "iferr",
        "impl",
      })

      if not opts.handlers then opts.handlers = {} end

      opts.handlers.buf = function()
        local null_ls = require "null-ls"
        local buf_buildins = null_ls.builtins.diagnostics.buf
        table.insert(buf_buildins._opts.args, "--config")
        table.insert(buf_buildins._opts.args, vim.fn.stdpath "config" .. "/buf.yaml")
        null_ls.register(null_ls.builtins.diagnostics.buf.with {
          generator_opts = buf_buildins._opts,
        })
        null_ls.register(null_ls.builtins.formatting.buf.with {
          condition = function() return true end,
        })
      end

      vim.api.nvim_create_autocmd("FileType", {
        desc = "create completion",
        pattern = "proto",
        callback = function()
          vim.keymap.set(
            "n",
            "<Leader>uB",
            create_buf_config_file,
            { silent = true, noremap = true, buffer = true, desc = "Create buf config file" }
          )
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "gopls" })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, opts)
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "delve" })
        end,
      },
    },
    opts = {},
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      if not require("lazy.core.config").spec.plugins["mason.nvim"] then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "williamboman/mason.nvim", optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-go" },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-go"(require("astrocore").plugin_opts "neotest-go"))
    end,
  },
  {
    "chaozwn/goctl.nvim",
    ft = "goctl",
    enabled = vim.fn.executable "goctl" == 1,
    opts = function()
      local group = vim.api.nvim_create_augroup("GoctlAutocmd", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "goctl",
        callback = function()
          -- set up format keymap
          vim.keymap.set(
            "n",
            "<Leader>lf",
            "<Cmd>GoctlApiFormat<CR>",
            { silent = true, noremap = true, buffer = true, desc = "Format Buffer" }
          )
        end,
      })
    end,
  },
}
