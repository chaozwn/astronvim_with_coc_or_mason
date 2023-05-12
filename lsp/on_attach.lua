return function(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if inlayhints_avail then inlayhints.on_attach(client, bufnr, _) end
  end
end
