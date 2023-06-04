return function(client, bufnr)
  if vim.g.lsp_type ~= "coc" then
    -- TODO: wait nvim update to 0.10, we can upgrade this plugin.
    if client.server_capabilities.inlayHintProvider then
      local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
      if inlayhints_avail then inlayhints.on_attach(client, bufnr, _) end
    end
  end
end
