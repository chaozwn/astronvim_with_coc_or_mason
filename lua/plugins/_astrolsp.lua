local methods = vim.lsp.protocol.Methods

local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
local simplify_inlay_hint_handler = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if client then
    if result == nil then return end
    ---@diagnostic disable-next-line: undefined-field

    result = vim
      .iter(result)
      :map(function(hint)
        local label = hint.label
        if not (label ~= nil and #label < 5) then hint.label = {} end
        return hint
      end)
      :filter(function(hint) return #hint.label > 0 end)
      :totable()
  end
  inlay_hint_handler(err, result, ctx, config)
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      -- Configuration table of features provided by AstroLSP
      autoformat = false, -- enable or disable auto formatting on start
      inlay_hints = true, -- nvim >= 0.10
      semantic_tokens = true,
      signature_help = false,
    },
    -- Configuration options for controlling formatting with language servers
    formatting = {
      -- control auto formatting on save
      format_on_save = false,
      -- disable formatting capabilities for specific language servers
      disabled = {},
      -- default format timeout
      timeout_ms = 20000,
    },
    lsp_handlers = {
      [methods.textDocument_inlayHint] = simplify_inlay_hint_handler,
    },
  },
}
