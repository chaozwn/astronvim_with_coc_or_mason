local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function mapping(is_cmdline)
  if is_cmdline == nil then is_cmdline = false end
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  return {
    ["<CR>"] = cmp.config.disable,
    -- ctrl + e关闭补全窗口
    -- <C-n> and <C-p> for navigating snippets
    ["<C-N>"] = cmp.mapping(function()
      if luasnip.jumpable(1) then luasnip.jump(1) end
    end, { "i", "c" }),
    ["<C-P>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then luasnip.jump(-1) end
    end, { "i", "c" }),
    ["<C-K>"] = cmp.mapping(function() cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } end, { "i", "c" }),
    ["<C-J>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if is_cmdline then
        if cmp.visible() then
          cmp.confirm()
        else
          fallback()
        end
      else
        if cmp.visible() and has_words_before() then
          cmp.confirm { select = true }
        else
          fallback()
        end
      end
    end, { "i", "c" }),
    ["<S-Tab>"] = cmp.config.disable,
  }
end

local function trim(s)
  if s == nil then return "" end
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function truncateString(s, maxLength)
  if #s > maxLength then
    return string.sub(s, 1, maxLength) .. "..."
  else
    return s
  end
end

local formatting_style = {
  fields = { "kind", "abbr", "menu" },
  format = function(_, item)
    local icons = require "icons.lspkind"
    local icon = icons[item.kind] or ""
    item.kind = string.format("%s", icon)
    item.abbr = trim(item.abbr)
    item.menu = truncateString(trim(item.menu), 20)
    return item
  end,
}

---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "hrsh7th/cmp-cmdline",
      keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
      dependencies = { "hrsh7th/nvim-cmp" },
      opts = function()
        local cmp = require "cmp"
        return {
          {
            type = "/",
            mapping = mapping(true),
            sources = {
              { name = "buffer" },
            },
          },
          {
            type = ":",
            mapping = mapping(true),
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              {
                name = "cmdline",
                option = {
                  ignore_cmds = { "Man", "!" },
                },
              },
            }),
          },
        }
      end,
      config = function(_, opts)
        local cmp = require "cmp"
        vim.tbl_map(function(val) cmp.setup.cmdline(val.type, val) end, opts)
      end,
    },
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local compare = require "cmp.config.compare"

    return require("astrocore").extend_tbl(opts, {
      window = {
        completion = {
          col_offset = 1,
          side_padding = 0,
        },
      },
      formatting = formatting_style,
      sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
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
        completeopt = "menu,menuone,preview,noinsert",
      },
      mapping = mapping(),
    })
  end,
}
