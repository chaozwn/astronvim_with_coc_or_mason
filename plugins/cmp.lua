local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    return require("astronvim.utils").extend_tbl(opts, {
      icons = true,
      lspkind_text = true,
      completion = {
        -- 自动选中第一条
        completeopt = "menu,menuone,noinsert",
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 } (entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp",          priority = 1000 },
        { name = "luasnip",           priority = 900 },
        { name = "copilot",           priority = 800 },
        { name = "path",              priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols",     priority = 700 },
        { name = "emoji",             priority = 700 },
        { name = "calc",              priority = 650 },
        { name = "buffer",            priority = 250 },
      },
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({
          -- this is the important line
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        -- ctrl + e关闭补全窗口
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- idea输入方式
          if cmp.visible() and has_words_before() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              }
            end
          else
            fallback()
          end
          -- 默认不支持tab输入
          -- if luasnip.jumpable(1) then
          --   luasnip.jump(1)
          -- else
          --   fallback()
          -- end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.config.disable,
      },
    })
  end,
}
