return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = false,
    },
    -- Configuration options for controlling formatting with language servers
    formatting = {
      -- control auto formatting on save
      format_on_save = false,
      -- disable formatting capabilities for specific language servers
      disabled = {},
      -- default format timeout
      timeout_ms = 600000,
    },
    capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = false } } },
    diagnostics = {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity_limit = "Warning",
      },
      update_in_insert = false,
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
      i = {
        ["<C-l>"] = {
          function ()
            vim.lsp.buf.signature_help()
          end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp"
        }
      }
    },
  },
}
