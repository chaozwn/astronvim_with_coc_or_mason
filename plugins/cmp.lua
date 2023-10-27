-- <<<<<<< HEAD
-- local function has_words_before()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end
-- local cmp_kinds = {
--   Text = "  ",
--   Method = "  ",
--   Function = "  ",
--   Constructor = "  ",
--   Field = "  ",
--   Variable = "  ",
--   Class = "  ",
--   Interface = "  ",
--   Module = "  ",
--   Property = "  ",
--   Unit = "  ",
--   Value = "  ",
--   Enum = "  ",
--   Keyword = "  ",
--   Snippet = "  ",
--   Color = "  ",
--   File = "  ",
--   Reference = "  ",
--   Folder = "  ",
--   EnumMember = "  ",
--   Constant = "  ",
--   Struct = "  ",
--   Event = "  ",
--   Operator = "  ",
--   TypeParameter = "  ",
--   Codeium = "",
-- }
-- =======
-- >>>>>>> origin/mason
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    -- "jc-doyle/cmp-pandoc-references",
    -- "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
-- <<<<<<< HEAD
--     return require("astronvim.utils").extend_tbl(opts, {
--       window = {
--         completion = {
--           -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
--           col_offset = 50,
--           side_padding = 1,
--           max_width = 350,
--           max_height = 550,
--           max_item_count = 50,
--           column_width = 500,
--         },
--         open = {
--           -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
--           col_offset = 50,
--           side_padding = 1,
--           max_width = 550,
--           max_height = 550,
--           max_item_count = 50,
--           column_width = 500,
--         },
--       },
--       -- completion = {
--       --   -- 自动选中第一条
--       --   completeopt = "menu,menuone,noinsert",
--       --   winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
--       --   col_offset = -3,
--       --   side_padding = 0,
--       -- },
--       sources = cmp.config.sources {
--         { name = "codeium",           priority = 2000, max_item_count = 9 },
--         { name = "nvim_lua",          priority = 1000 , max_item_count = 9 },
--         { name = "nvim_lsp",          priority = 1000 , max_item_count = 4 },
--         { name = "luasnip",           priority = 900 , max_item_count = 9 },
--         { name = "path",              priority = 750 , max_item_count = 7 },
--         -- { name = "pandoc_references", priority = 725 },
--         -- { name = "latex_symbols",     priority = 700 },
--         { name = "buffer",            priority = 950, max_item_count = 6  },
--         { name = "emoji",             priority = 700, max_item_count = 2  },
--         { name = "calc",              priority = 650 },
--       }
-- =======
    local compare = require "cmp.config.compare"
    local luasnip = require "luasnip"

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    return require("astronvim.utils").extend_tbl(opts, {
      window = {
        completion = {
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = 50,
          side_padding = 1,
          max_width = 350,
          max_height = 550,
          max_item_count = 50,
          column_width = 500,
        },
        open = {
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = 50,
          side_padding = 1,
          max_width = 550,
          max_height = 550,
          max_item_count = 50,
          column_width = 500,
        },
      },
      sources = cmp.config.sources {
        { name = "codeium",           priority = 2000, max_item_count = 9 },
        { name = "nvim_lua",          priority = 1000 , max_item_count = 9 },
        { name = "nvim_lsp",          priority = 1000 , max_item_count = 4 },
        { name = "luasnip",           priority = 900 , max_item_count = 9 },
        { name = "path",              priority = 750 , max_item_count = 7 },
        -- { name = "pandoc_references", priority = 725 },
        -- { name = "latex_symbols",     priority = 700 },
        { name = "buffer",            priority = 950, max_item_count = 6  },
        { name = "emoji",             priority = 700, max_item_count = 2  },
        { name = "calc",              priority = 650 },
      },
      formatting = {
        format = function(_, item)
          local icons = require "user.highlights.icons"
          if icons[item.kind] then item.kind = icons[item.kind] .. item.kind end
          return item
        end,
      },
      sorting = {
        comparators = {
          compare.offset,
          compare.exact,
          compare.score,
          compare.recently_used,
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find "^_+"
            local _, entry2_under = entry2.completion_item.label:find "^_+"
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      completion = {
        -- 自动选中第一条
        completeopt = "menu,menuone,noinsert",
      },
      mapping = {
        ["<CR>"] = cmp.config.disable,
        -- ctrl + e关闭补全窗口
        -- <C-n> and <C-p> for navigating snippets
        ["<C-n>"] = cmp.mapping(function()
          if luasnip.jumpable(1) then luasnip.jump(1) end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(
          function() cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } end,
          { "i", "s" }
        ),
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.config.disable,
      },

      -- formatting = {
      --   fields = { "kind", "abbr" },
      --   format = function(_, vim_item)
      --     -- local utils = require "astronvim.utils"
      --     -- utils.notify(_.source.name)
      --     vim_item.kind = cmp_kinds[vim_item.kind] or ""
      --     vim_item.menu = ({
      --       buffer = "[Buffer]",
      --       nvim_lsp = "[LSP]",
      --       luasnip = "[LuaSnip]",
      --       nvim_lua = "[Lua]",
      --       latex_symbols = "[Latex]",
      --       emoji = "[Emoji]",
      --       calc = "[Calc]",
      --       pandoc_references = "[Pandoc]",
      --       path = "[Path]",
      --       codeium = "[Codeium]",
      --     })[_.source.name]
      --     return vim_item
      --   end,
      -- },
      -- view = {
      --   entries = "wildmenu", -- can be "custom", "wildmenu" or "native"
      -- },
      -- view = {
      --   entries = { name = "custom", selection_order = "near_cursor" },
      -- },

      -- formatting = {
      --   format = require("lspkind").cmp_format {
      --     mode = "symbol",
      --     maxwidth = 350,
      --     ellipsis_char = "...",
      --     symbol_map = { Codeium = "" },
      --   },
      -- },
    })
  end,
}
