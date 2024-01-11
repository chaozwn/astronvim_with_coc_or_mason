return {
  "onsails/lspkind.nvim",
  opts = function(_, opts)
    opts.preset = "codicons"
    opts.symbol_map = {
      Namespace = "󰌗",
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰆧",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "󰑭",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈚",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
      Table = "",
      Object = "󰅩",
      Tag = "",
      Array = "[]",
      Boolean = "",
      Number = "",
      Null = "󰟢",
      String = "󰉿",
      Calendar = "",
      Watch = "󰥔",
      Package = "",
      Copilot = "",
      Codeium = "",
      TabNine = "",
    }
    opts.before = function(_, vim_item)
      local max_width = math.floor(0.25 * vim.o.columns)
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, max_width)
      if truncated_label ~= label then vim_item.abbr = truncated_label .. "…" end
      return vim_item
    end
    return opts
  end,
}
