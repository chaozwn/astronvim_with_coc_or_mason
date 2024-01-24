local utils = require "astrocore"

return {
  ---@type LazySpec
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    ---@diagnostic disable: missing-fields
    opts = {
      handlers = { tsserver = false }, -- disable tsserver setup, this plugin does it
      config = {
        ["typescript-tools"] = { -- enable inlay hints by default for `typescript-tools`
          settings = {
            separate_diagnostic_server = true,
            -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
            -- memory limit in megabytes or "auto"(basically no limit)
            tsserver_max_memory = "auto",
            tsserver_file_preferences = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
              includeCompletionsForModuleExports = true,
              quotePreference = "auto",
            },
            tsserver_format_options = {
              allowIncompleteCompletions = false,
              allowRenameOfImportPath = false,
            },
            tsserver_plugins = {
              "@styled/typescript-styled-plugin",
            },
            expose_as_code_action = "all",
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
          utils.list_insert_unique(opts.ensure_installed, "javascript", "typescript", "tsx", "jsdoc")
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "tsserver", "eslint")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("eslint_fix_creator", { clear = true }),
        desc = "Create autocommand in buffers where eslint attaches",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              desc = "Fix all eslint errors",
              buffer = args.buf,
              group = vim.api.nvim_create_augroup(("eslint_fix_%d"):format(args.buf), { clear = true }),
              callback = function()
                if vim.fn.exists ":EslintFixAll" > 0 then vim.cmd.EslintFixAll() end
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      -- format
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "prettierd")
      -- lsp
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "eslint-lsp")
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "js") end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    -- get AstroLSP provided options like `on_attach` and `capabilities`
    opts = function() return require("astrolsp").lsp_opts "typescript-tools" end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
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
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typescriptreact = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        javascript = { "prettierd" },
      },
    },
  },
}
