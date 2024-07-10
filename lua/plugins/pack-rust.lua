--WARNING: now rust-analyzer is can't use in neovim, because this issue
-- https://github.com/rust-lang/rust-analyzer/issues/17289
-- https://github.com/williamboman/mason.nvim/issues/1741
local utils = require "astrocore"

local set_mappings = require("astrocore").set_mappings

local function preview_stack_trace()
  local current_line = vim.api.nvim_get_current_line()
  local patterns_list = {
    "--> ([^:]+):(%d+):(%d+)",
    "at ([^:]+):(%d+):(%d+)",
  }

  local function try_patterns(patterns, line)
    for _, pattern in ipairs(patterns) do
      local filepath, line_nr, column_nr = string.match(line, pattern)
      if filepath and line_nr then return filepath, tonumber(line_nr), tonumber(column_nr or 0) end
    end
    return nil, nil, nil
  end

  local filepath, line_nr, column_nr = try_patterns(patterns_list, current_line)
  if filepath then
    vim.cmd ":wincmd k"
    vim.cmd("e " .. filepath)
    vim.api.nvim_win_set_cursor(0, { line_nr, column_nr })
  end
end

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      handlers = { rust_analyzer = false },
      config = {
        rust_analyzer = {
          on_attach = function()
            vim.api.nvim_create_autocmd({ "TermClose", "BufEnter" }, {
              pattern = "*cargo*",
              desc = "Jump to error line",
              callback = function()
                set_mappings({
                  n = {
                    ["gd"] = {
                      preview_stack_trace,
                      desc = "Jump to error line",
                    },
                  },
                }, { buffer = true })
              end,
            })
          end,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust.
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              -- Add clippy lints for Rust.
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              completion = {
                autoimport = {
                  enable = true,
                },
                enableSnippets = true,
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
              cachePriming = {
                enable = true,
                numThreads = 2,
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "rust", "toml", "ron" })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      -- dap
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      -- lsp
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "rust_analyzer" })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    specs = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@param opts AstroLSPOpts
        opts = {
          handlers = { rust_analyzer = false }, -- disable setup of `rust_analyzer`
        },
      },
    },
    opts = function()
      local adapter
      local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
      local cfg = require "rustaceanvim.config"
      if success then
        local package_path = package:get_install_path()
        local codelldb_path = package_path .. "/codelldb"
        local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
        local this_os = vim.loop.os_uname().sysname

        -- The path in windows is different
        if this_os:find "Windows" then
          codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
          liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
        else
          -- The liblldb extension is .so for linux and .dylib for macOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      else
        adapter = cfg.get_codelldb_adapter()
      end

      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts "rust_analyzer") or {}
      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table) -- The rust-analyzer settings or a function that creates them.
        settings = function(project_root, default_settings)
          local astrolsp_settings = astrolsp_opts.settings or {}

          local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require "rustaceanvim.config.server"
          -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
          return ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = "rust-analyzer.json",
            default_settings = merge_table,
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
      return { server = final_server, dap = { adapter = adapter }, tools = { enable_clippy = false } }
    end,
    config = function(_, opts) vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim) end,
  },
  {
    "Saecki/crates.nvim",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          CmpSourceCargo = {
            {
              event = "BufRead",
              desc = "Load crates.nvim into Cargo buffers",
              pattern = "Cargo.toml",
              callback = function()
                require("cmp").setup.buffer { sources = { { name = "crates" } } }
                require "crates"
              end,
            },
          },
        },
      },
    },
    opts = {
      completion = {
        cmp = { enabled = true },
        crates = {
          enabled = true,
        },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      local rustaceanvim_avail, rustaceanvim = pcall(require, "rustaceanvim.neotest")
      if rustaceanvim_avail then table.insert(opts.adapters, rustaceanvim) end
    end,
  },
}
