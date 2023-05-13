return function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if inlayhints_avail then inlayhints.on_attach(client, bufnr, _) end
  end
  if client.name == "copilot" then
    local copilot_cmp_avail, copilot_cmp = pcall(require, "copilot_cmp")
    if copilot_cmp_avail then copilot_cmp._on_insert_enter {} end
  end
end
