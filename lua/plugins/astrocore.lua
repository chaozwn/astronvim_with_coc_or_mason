-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  ---@diagnostic disable-next-line: assign-type-mismatch
  opts = function(_, opts)
    local mappings = require("mapping").core_mappings(opts.mappings)

    return require("astrocore").extend_tbl(opts, {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
      },
      -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = true,
        update_in_insert = false,
        underline = true,
      },
      sessions = {
        autosave = {
          last = true, -- auto save last session
          cwd = true, -- auto save session for each working directory
        },
        ignore = {
          dirs = {}, -- working directories to ignore sessions in
          filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
          buftypes = {}, -- buffer types to ignore sessions
        },
      },
      autocmds = {
        auto_turnoff_paste = {
          event = "InsertLeave",
          pattern = "*",
          command = "set nopaste",
        },
      },
      -- vim options can be configured here
      options = {
        opt = {
          conceallevel = 2,
          list = false,
          listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
          showbreak = "↪ ",
          splitkeep = "screen",
          swapfile = false,
          wrap = true,
          scrolloff = 5,
        },
        g = {
          -- resession_enabled = true,
        },
      },
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = mappings,
    })
  end,
}
