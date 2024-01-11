---@type AstroCoreOpts
-- AstroCore allows you easy access to customize the default options provided in AstroNvim
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local resession = require "resession"
    local augroup = vim.api.nvim_create_augroup

    return require("astrocore").extend_tbl(opts, {
      -- modify core features of AstroNvim
      features = {
        max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
      },
      -- Configure diagnostics options (`:h vim.diagnostic.config()`)
      diagnostics = {
        update_in_insert = false,
      },
      -- Configuration options for controlling formatting with language servers
      formatting = {
        -- control auto formatting on save
        format_on_save = {
          -- enable or disable format on save globally
          enabled = false,
          -- enable format on save for specified filetypes only
          allow_filetypes = {},
          -- disable format on save for specified filetypes
          ignore_filetypes = {},
        },
        -- disable formatting capabilities for specific language servers
        disabled = {},
        -- default format timeout
        timeout_ms = 10000,
        -- fully override the default formatting function
        filter = function(client) return true end,
      },
      autocmds = {
        auto_spell = {
          {
            event = "FileType",
            desc = "Enable wrap and spell for text like documents",
            pattern = { "gitcommit", "markdown", "text", "plaintex" },
            callback = function()
              vim.opt_local.wrap = true
              vim.opt_local.spell = true
            end,
          },
        },
        autohide_tabline = {
          {
            event = "User",
            desc = "Auto hide tabline",
            pattern = "AstroBufsUpdated",
            callback = function()
              local new_showtabline = #vim.t.bufs > 1 and 2 or 1
              if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
            end,
          },
        },
        auto_resession = {
          {
            event = "VimEnter",
            desc = "Restore session on open",
            group = augroup("resession_auto_open", { clear = true }),
            callback = function()
              -- Only load the session if nvim was started with no args
              if vim.fn.argc(-1) == 0 then
                -- Save these to a different directory, so our manual sessions don't get polluted
                resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
              end
            end,
          },
        },
      },
      mappings = require("mappings").mappings(opts.mappings),
    })
  end,
}
