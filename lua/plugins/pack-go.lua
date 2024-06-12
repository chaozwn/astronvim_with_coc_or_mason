if true then return {} end

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
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
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
              analyses = {
                fieldalignment = false,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              buildFlags = { "-tags", "integration" },
              matcher = "Fuzzy",
              symbolMatcher = "fuzzy",
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
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
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "gomodifytags",
        "gofumpt",
        "iferr",
        "impl",
        "goimports",
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
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      disable_defaults = true,
      trouble = true,
      run_in_floaterm = true,
      luasnip = true,
      capabilities = {
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = true },
        },
      },
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- Prevents Neovim from freezing on plugin installation/update.
    -- See: <https://github.com/ray-x/go.nvim/issues/433>
    build = function() require("go.install").update_all() end,
  },
  {
    "chaozwn/goctl.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },
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
          vim.keymap.set(
            "n",
            "<Leader>fg",
            "<cmd>Telescope goctl<CR>",
            { silent = true, noremap = true, buffer = true, desc = "Jump to error line" }
          )
        end,
      })
    end,
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
}
