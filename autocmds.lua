-- auto stop auto-compiler if its running
vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Stop running auto compiler",
  group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
  pattern = "*",
  callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
})

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- auto hide tabline
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroBufsUpdated",
  group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
  callback = function()
    local new_showtabline = #vim.t.bufs > 1 and 2 or 1
    if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
  end,
})

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

