local is_available = require("astrocore").is_available

return {
  {
    "neoclide/coc.nvim",
    branch = "master",
    build = "npm ci",
    cmd = {
      "CocCommand",
      "CocConfig",
      "CocDiagnostics",
      "CocDisable",
      "CocEnable",
      "CocInfo",
      "CocInstall",
      "CocList",
      "CocLocalConfig",
      "CocOpenLog",
      "CocOutline",
      "CocPrintErrors",
      "CocRestart",
      "CocSearch",
      "CocStart",
      "CocUninstall",
      "CocUpdate",
      "CocUpdateSync",
      "CocWatch",
    },
    event = { "VimEnter" },
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.options then opts.options = {} end
        if not opts.options.g then opts.options.g = {} end
        if not opts.options.opt then opts.options.opt = {} end
        opts.options.opt.cmdheight = 1
        opts.options.g.coc_global_extensions = {
          "coc-json",
          "coc-marketplace",
          "coc-lua",
          "coc-tsserver",
          "coc-emmet",
          "coc-html",
          "coc-css",
          "coc-go",
          "coc-sh",
          "coc-sql",
          "coc-pyright",
          "coc-toml",
          "coc-prettier",
          "coc-snippets",
          "coc-pairs",
          "coc-highlight",
          "coc-eslint",
          "@yaegassy/coc-tailwindcss3",
          "coc-yaml",
        }
        -- Some servers have issues with backup files, see #649
        opts.options.opt.backup = false
        opts.options.opt.writebackup = false

        -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
        -- delays and poor user experience
        opts.options.opt.updatetime = 300
        opts.options.g.coc_snippet_next = "<C-n>"
        opts.options.g.coc_snippet_prev = "<C-p>"

        if not opts.commands then opts.commands = {} end
        opts.commands.Format = { function() vim.fn.CocAction "format" end, desc = "Format file with LSP" }
        if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
        local maps = assert(opts.mappings)
        maps.i["<TAB>"] = {
          'coc#pum#visible() ? coc#pum#confirm() :  "\\<TAB>"',
          expr = true,
          silent = true,
          nowait = true,
        }
        maps.i["<C-j>"] = {
          'coc#pum#visible() ? coc#pum#next(0) : "\\<C-j>"',
          expr = true,
          silent = true,
          nowait = true,
        }
        maps.i["<C-k>"] = {
          'coc#pum#visible() ? coc#pum#prev(0) : "\\<C-k>"',
          expr = true,
          silent = true,
          nowait = true,
        }
        maps.n["<C-d>"] =
        { 'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-d>"', expr = true, silent = true, nowait = true }
        maps.n["<C-u>"] =
        { 'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-u>"', expr = true, silent = true, nowait = true }
        maps.i["<C-d>"] = {
          'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "\\<C-d>"',
          expr = true,
          silent = true,
          nowait = true,
        }
        maps.i["<C-u>"] = {
          'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "\\<C-u>"',
          expr = true,
          silent = true,
          nowait = true,
        }
        maps.v["<C-d>"] =
        { 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-d>"', expr = true, silent = true, nowait = true }
        maps.v["<C-u>"] =
        { 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-u>"', expr = true, silent = true, nowait = true }
        maps.n["[d"] = { "<Plug>(coc-diagnostic-prev)", desc = "Previous diagnostic" }
        maps.n["]d"] = { "<Plug>(coc-diagnostic-next)", desc = "Next diagnostic" }
        maps.n["gD"] = { "<Cmd>Telescope coc declarations<CR>", desc = "Show the declaration of current symbol" }
        maps.n["gI"] = { "<Cmd>Telescope coc implementations<CR>", desc = "Show the implementation of current symbol" }
        maps.n["gT"] = { "<Cmd>Telescope coc type_definitions<CR>", desc = "Show the definition of current type" }
        maps.n["gd"] = { "<Cmd>Telescope coc definitions<CR>", desc = "Show the definition of current symbol" }
        maps.n["gr"] = { "<Cmd>Telescope coc references<CR>", desc = "Show the references of current symbol" }
        maps.n["<Leader>lR"] = maps.n.gr
        maps.n["<Leader>la"] = { "<Cmd>Telescope coc code_actions<CR>", desc = "LSP code action" }
        maps.n["<Leader>lc"] = { "<Cmd>CocConfig<CR>", desc = "Configuration" }
        maps.n["<Leader>lf"] = { function() vim.cmd.Format() end, desc = "Format buffer" }
        maps.n["<Leader>lm"] = { "<Cmd>CocList marketplace<CR>", desc = "Marketplace" }
        maps.n["<Leader>lr"] = { "<Plug>(coc-rename)", desc = "Rename current symbol" }
        maps.n["<Leader>ls"] = { "<Cmd>Telescope coc document_symbols<CR>", desc = "Search symbols" }
        maps.n["<Leader>lS"] = { "<Cmd>CocOutline<CR>", desc = "Symbols outline" }
        -- TODO: add to telescope
        maps.n["<Leader>lL"] = { "<Plug>(coc-codelens-action)", desc = "LSP CodeLens run" }
        maps.n["<Leader>uL"] = { "<Cmd>CocCommand document.toggleCodeLens<CR>", desc = "Toggle CodeLens" }
        maps.n["<Leader>uh"] = { "<Cmd>CocCommand document.toggleInlayHint<CR>", desc = "Toggle LSP inlay hints" }
        maps.x["<Leader>lF"] = { "<Plug>(coc-format-selected)", desc = "Format selection" }
        maps.n["<leader>lW"] = { "<Cmd>Telescope coc workspace_diagnostics<CR>", desc = "Show workspace diagnostics" }
        maps.n["<leader>lG"] = { "<Cmd>Telescope coc workspace_symbols<CR>", desc = "Search workspace symbols" }
        maps.n["K"] = {
          function()
            local cw = vim.fn.expand "<cword>"
            if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
              vim.api.nvim_command("h " .. cw)
            elseif vim.api.nvim_eval "coc#rpc#ready()" then
              vim.fn.CocActionAsync "doHover"
            else
              vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
            end
          end,
          desc = "Hover symbol details",
        }
      end,
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local statusline, status = opts.statusline, require "astroui.status"
      local function coc_diagnostic(coc_type, diagnostic_type)
        return {
          provider = function(self)
            local count = vim.b[self.bufnr or 0].coc_diagnostic_info[coc_type]
            return status.utils.stylize(
              count ~= 0 and tostring(count) or "",
              { icon = { kind = "Diagnostic" .. diagnostic_type, padding = { left = 1, right = 1 } } }
            )
          end,
          hl = { fg = "diag_" .. diagnostic_type:upper() },
        }
      end
      statusline[5] = status.component.builder { -- diagnostics
        coc_diagnostic("error", "Error"),
        coc_diagnostic("warning", "Warn"),
        coc_diagnostic("information", "Info"),
        coc_diagnostic("hint", "Hint"),
        update = { "User", pattern = "CocDiagnosticChange" },
        init = status.init.update_events { "BufEnter" },
        surround = {
          separator = "right",
          condition = function()
            for _, count in pairs(vim.b.coc_diagnostic_info or {}) do
              if type(count) == "number" and count > 0 then return true end
            end
            return false
          end,
        },
        on_click = {
          name = "coc_diagnostic",
          callback = function()
            if is_available "telescope.nvim" then
              if is_available "telescope-coc.nvim" then
                vim.defer_fn(function() require("telescope").extensions.coc.diagnostics() end, 100)
              end
            else
              vim.schedule(vim.cmd.CocDiagnostic)
            end
          end,
        },
      }
      statusline[9] = status.component.builder { -- status
        {
          provider = function() return vim.g.coc_status end,
          on_click = { name = "coc_status", callback = function() vim.schedule(vim.cmd.CocInfo) end },
        },
        {
          provider = function()
            if vim.g.coc_status then
              return status.utils.stylize(" ", { icon = { kind = "ActiveLSP", padding = { left = 1 } } })
            end
          end,
          on_click = {
            name = "coc_services",
            callback = vim.schedule_wrap(function() vim.cmd.CocList "services" end),
          },
        },
        update = {
          "User",
          pattern = "CocStatusChange",
          callback = function() vim.schedule(vim.cmd.redrawstatus) end,
        },
        surround = { separator = "right", condition = function() return vim.g.coc_status ~= nil end },
      }
    end,
  },
  {
    "honza/vim-snippets",
    event = "BufEnter",
  },
  -- disable core lsp plugins
  { "AstroNvim/astrolsp",                enabled = false },
  { "folke/neoconf.nvim",                enabled = false },
  { "folke/neodev.nvim",                 enabled = false },
  { "jay-babu/mason-null-ls.nvim",       enabled = false },
  { "neovim/nvim-lspconfig",             enabled = false },
  { "nvimtools/none-ls.nvim",            enabled = false },
  { "stevearc/aerial.nvim",              enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  -- cmp
  { "hrsh7th/cmp-buffer",                enabled = false },
  { "hrsh7th/cmp-nvim-lsp",              enabled = false },
  { "hrsh7th/cmp-path",                  enabled = false },
  { "hrsh7th/nvim-cmp",                  enabled = false },
  { "rcarriga/cmp-dap",                  enabled = false },
  { "saadparwaiz1/cmp_luasnip",          enabled = false },
  -- luaship
  { "L3MON4D3/LuaSnip",                  enabled = false },
  { "rafamadriz/friendly-snippets",      enabled = false },
  { "folke/neoconf.nvim",                enabled = false }
}
