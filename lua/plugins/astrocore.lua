---@type AstroCoreOpts
-- AstroCore allows you easy access to customize the default options provided in AstroNvim
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local resession = require "resession"
    local augroup = vim.api.nvim_create_augroup

    return require("astrocore").extend_tbl(opts, {
      -- Configuration options for controlling formatting with language servers
      formatting = {
        -- control auto formatting on save
        format_on_save = false,
        -- disable formatting capabilities for specific language servers
        disabled = {},
        -- default format timeout
        timeout_ms = 10000,
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
        auto_update_neotree_after_lazygit_close = {
          {
            event = "TermClose",
            desc = "Refresh Neo-Tree when closing lazygit",
            group = augroup("neotree_refresh", { clear = true }),
            callback = function()
              local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
              if manager_avail then
                for _, source in ipairs { "filesystem", "git_status", "document_symbols" } do
                  local module = "neo-tree.sources." .. source
                  if package.loaded[module] then manager.refresh(require(module).name) end
                end
              end
            end,
          },
        },
      },
      mappings = require("mappings").mappings(opts.mappings),
    })
  end,
}
