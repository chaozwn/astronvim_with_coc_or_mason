-- if vim.g.neovide then return {} end
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    lsp = {
      cmdline = {
        view = "cmdline",
      },
      messages = { view_search = false },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = { enabled = false },
      signature = { enabled = false },
      notify = {
        enabled = true,
        view = "notify",
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "notify",
        opts = {},
      },
    },
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true,            -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      { filter = { event = "msg_show", find = "%d+L,%s%d+B" },          opts = { skip = true } }, -- skip save notifications
      { filter = { event = "msg_show", find = "^%d+ more lines$" },     opts = { skip = true } }, -- skip paste notifications
      { filter = { event = "msg_show", find = "^%d+ fewer lines$" },    opts = { skip = true } }, -- skip delete notifications
      { filter = { event = "msg_show", find = "^%d+ lines yanked$" },   opts = { skip = true } }, -- skip yank notifications
      { filter = { event = "msg_show", find = "AutoSave: saved at%s" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "The only match" },       opts = { skip = true } },
    },
  },
  init = function() vim.g.lsp_handlers_enabled = false end,
}
