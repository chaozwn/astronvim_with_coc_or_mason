local utils = require "user.utils.utils"

local function get_filetypes()
  if utils.is_vue_project() then
    return { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
  else
    return { "vue" }
  end
end

return {
  filetypes = get_filetypes(),
  -- on_attach = function(client, bufnr)
  -- if utils.is_vue_project() then
  --   if client.name == "tsserver" then client.stop() end
  -- else
  --   if client.name == "volar" then client.stop() end
  -- end
  -- end,
}
