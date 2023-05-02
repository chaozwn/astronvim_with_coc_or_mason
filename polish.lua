-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  -- Set up custom filetypes
  -- vim.filetype.add {
  --   extension = {
  --     foo = "fooscript",
  --   },
  --   filename = {
  --     ["Foofile"] = "fooscript",
  --   },
  --   pattern = {
  --     ["~/%.config/foo/.*"] = "fooscript",
  --   },
  --
  vim.api.nvim_create_augroup("im-select", { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = "im-select",
    callback = require("user.utils.im-select").macInsertLeave,
  })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = "im-select",
    callback = require("user.utils.im-select").macInsertEnter,
  })
  vim.api.nvim_create_autocmd("FocusGained", {
    group = "im-select",
    callback = require("user.utils.im-select").macFocusGained,
  })
  vim.api.nvim_create_autocmd("FocusLost", {
    group = "im-select",
    callback = require("user.utils.im-select").macFocusLost,
  })

  if vim.g.neovide then
    local neovide = require "user.utils.neovide"
    neovide.init()
  end
end
