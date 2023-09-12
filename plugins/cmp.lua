local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
local cmp_kinds = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
  Codeium = "",
}
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
      -- completion = {
      --   -- 自动选中第一条
      --   completeopt = "menu,menuone,noinsert",
      --   winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      --   col_offset = -3,
      --   side_padding = 0,
      -- },
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
      mapping = {
        ["<CR>"] = cmp.config.disable,
        -- ctrl + e关闭补全窗口
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- idea输入方式
          -- if cmp.visible() and has_words_before() then
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              if has_words_before() then
                cmp.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                }
              else
                cmp.confirm {
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = false,
                }
              end
            end
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.config.disable,
      },

      formatting = {
        fields = { "kind", "abbr" },
        format = function(_, vim_item)
          -- local utils = require "astronvim.utils"
          -- utils.notify(_.source.name)
          vim_item.kind = cmp_kinds[vim_item.kind] or ""
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            emoji = "[Emoji]",
            calc = "[Calc]",
            pandoc_references = "[Pandoc]",
            path = "[Path]",
            codeium = "[Codeium]",
          })[_.source.name]
          return vim_item
        end,
      },
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
