local utils = require "astrocore"
local set_mappings = utils.set_mappings

local function create_sqlfluff_config_file()
  local source_file = vim.fn.stdpath "config" .. "/.sqlfluff"
  local target_file = vim.fn.getcwd() .. "/.sqlfluff"
  require("utils").copy_file(source_file, target_file)
end

local sql_ft = { "sql", "mysql", "plsql" }

---@type LazySpec
return {
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = "vim-dadbod",
    ft = sql_ft,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = sql_ft,
        callback = function()
          local cmp = require "cmp"

          -- global sources
          ---@param source cmp.SourceConfig
          local sources = vim.tbl_map(function(source) return { name = source.name } end, cmp.get_config().sources)

          -- add vim-dadbod-completion source
          table.insert(sources, { name = "vim-dadbod-completion" })

          -- update sources for the current buffer
          cmp.setup.buffer { sources = sources }
        end,
      })
    end,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = "vim-dadbod",
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      local data_path = vim.fn.stdpath "data"

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        auto_create_sqlfluff_config_file = {
          {
            event = "FileType",
            desc = "create completion",
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
              set_mappings({
                n = {
                  ["<Leader>lc"] = {
                    create_sqlfluff_config_file,
                    desc = "Create sqlfluff config file",
                  },
                },
              }, { buffer = true })
            end,
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
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "sql" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "sqlfluff", "sqlfmt" })

      if not opts.handlers then opts.handlers = {} end

      opts.handlers.sqlfluff = function()
        local null_ls = require "null-ls"
        local buf_diagnostics_buildins = null_ls.builtins.diagnostics.sqlfluff
        table.insert(buf_diagnostics_buildins._opts.args, "--config")
        local system_config = vim.fn.stdpath "config" .. "/.sqlfluff"
        local project_config = vim.fn.getcwd() .. "/.sqlfluff"
        if vim.fn.filereadable(project_config) == 1 then
          table.insert(buf_diagnostics_buildins._opts.args, project_config)
        else
          table.insert(buf_diagnostics_buildins._opts.args, system_config)
        end
        null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with {
          generator_opts = buf_diagnostics_buildins._opts,
          filetypes = { "sql", "dbt" },
        })

        -- format
        local sqlfmt_formatting_buildins = null_ls.builtins.formatting.sqlfmt
        table.insert(sqlfmt_formatting_buildins._opts.args, "--dialect")
        table.insert(sqlfmt_formatting_buildins._opts.args, "polyglot")
        null_ls.register(null_ls.builtins.formatting.sqlfmt.with {
          generator_opts = sqlfmt_formatting_buildins._opts,
          filetypes = { "sql", "dbt" },
        })
      end
    end,
  },
}
