-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     event = "InsertEnter",
--     opts = function(_, config)
--       local cmp = require "cmp"
--
--       -- 使用idea的tab逻辑
--       config.mapping["<Tab>"] = cmp.mapping(function(fallback)
--         -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
--         if cmp.visible() then
--           local entry = cmp.get_selected_entry()
--           if not entry then
--             cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
--           else
--             cmp.confirm()
--           end
--         else
--           fallback()
--         end
--       end, { "i", "s", "c" })
--       return config -- return final config table
--     end,
--   },
-- }

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
      window = {
        completion = {
          border = "rounded",
          col_offset = -1,
          side_padding = 0,
        },
      },
      completion = {
        -- 自动选中第一条
        completeopt = "menu,menuone,noinsert",
      },
      sources = cmp.config.sources {
        -- Copilot Source
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 900 },
        { name = "copilot", priority = 800 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      mapping = {
        -- ctrl + e关闭补全窗口
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- idea输入方式
          if cmp.visible() then
            local entry = cmp.get_selected_entry()

            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.confirm()
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
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", "c" }),
      },
    })
  end,
}
