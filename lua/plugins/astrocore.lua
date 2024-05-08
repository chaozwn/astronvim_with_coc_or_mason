-- NOTE:: event `AstroLargeBuf` that is triggered when a large buffer is detected.
---@type AstroCoreOpts
-- AstroCore allows you easy access to customize the default options provided in AstroNvim
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = function(_, opts)
    local options = require("astrocore").extend_tbl(opts, {
      -- Configure project root detection, check status with `:AstroRootInfo`
      diagnostics = {
        underline = true,
        update_in_insert = false,
      },
      -- modify core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
      },
      autocmds = {
        auto_turnoff_paste = {
          event = "InsertLeave",
          pattern = "*",
          command = "set nopaste",
        },
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
        auto_hide_tabline = {
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
            callback = function()
              if require("astrocore").is_available "resession.nvim" then
                local resession = require "resession"
                -- Only load the session if nvim was started with no args
                if vim.fn.argc(-1) == 0 then
                  -- Save these to a different directory, so our manual sessions don't get polluted
                  resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
                  vim.cmd.doautoall "BufReadPre"
                end
              end
            end,
          },
        },
        auto_conceallevel_for_json = {
          {
            event = "FileType",
            desc = "Fix conceallevel for json files",
            pattern = { "json", "jsonc" },
            callback = function()
              vim.wo.spell = false
              vim.wo.conceallevel = 0
            end,
          },
        },
        auto_select_virtualenv = {
          {
            event = "VimEnter",
            desc = "Auto select virtualenv Nvim open",
            pattern = "*",
            callback = function()
              local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
              if venv ~= "" then require("venv-selector").retrieve_from_cache() end
            end,
            once = true,
          },
        },
      },
      mappings = require("mappings").mappings(opts.mappings),
    })
    return options
  end,
}
