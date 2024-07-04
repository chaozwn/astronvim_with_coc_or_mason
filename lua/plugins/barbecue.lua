return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  --NOTE: https://github.com/utilyre/barbecue.nvim/pull/93
  commit = "aae71aebec4429a8e1e3e5a8e8220f8dc48ec06d",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        autocmds = {
          auto_attach_navic = {
            {
              event = "LspAttach",
              desc = "Auto attach navic when lsp start",
              callback = function(a)
                local navic = require "nvim-navic"
                local client = vim.lsp.get_client_by_id(a.data.client_id)
                local exclude_clients = { "volar" }
                if client then
                  if client.server_capabilities["documentSymbolProvider"] then
                    if not exclude_clients[client.name] then navic.attach(client, a.buf) end
                  end
                end
              end,
            },
          },
        },
      },
    },
  },
  opts = {
    attach_navic = false,
    show_modified = true,
    exclude_filetypes = { "netrw", "toggleterm" },
  },
}
