return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    if not opts.mappings then opts.mappings = require("astrocore").empty_map_table() end
    local maps = opts.mappings
    if maps then
      maps.i["<C-p>"] = {
        function() vim.lsp.buf.signature_help() end,
        desc = "Signature help",
        cond = "textDocument/signatureHelp",
      }
      maps.n["gK"] = false
      maps.n["gk"] = maps.n["<Leader>lh"]
    end

    opts.mappings = maps
  end,
}
