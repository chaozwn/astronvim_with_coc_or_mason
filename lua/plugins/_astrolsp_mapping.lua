return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
    local maps = opts.mappings
    if maps then
      maps.i["<C-l>"] = {
        function() vim.lsp.buf.signature_help() end,
        desc = "Signature help",
        cond = "textDocument/signatureHelp",
      }
    end

    opts.mappings = maps
  end,
}
