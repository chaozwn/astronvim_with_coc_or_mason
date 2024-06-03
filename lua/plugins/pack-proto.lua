local set_mappings = require("astrocore").set_mappings

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
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        bufls = {
          filetypes = { "proto" },
          single_file_support = true,
        },
      },
      on_attach = function()
        set_mappings({
          n = {
            ["<Leader>lc"] = {
              create_buf_config_file,
              desc = "Create Buf Config File",
            },
          },
        }, { buffer = true })
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "proto" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "bufls" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "buf" })
    end,
  },
}
