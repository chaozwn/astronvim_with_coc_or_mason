local utils = require "astronvim.utils"
local is_available = utils.is_available
local augroup = vim.api.nvim_create_augroup
local im_select = require "user.utils.im-select"

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_augroup("im-select", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = "im-select",
  callback = im_select.macInsertLeave,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "im-select",
  callback = im_select.macInsertEnter,
})
vim.api.nvim_create_autocmd("FocusGained", {
  group = "im-select",
  callback = im_select.macFocusGained,
})
vim.api.nvim_create_autocmd("FocusLost", {
  group = "im-select",
  callback = im_select.macFocusLost,
})

if vim.g.neovide then
  local neovide = require "user.utils.neovide"
  neovide.init()
end

if is_available "resession.nvim" then
  local resession = require "resession"
  vim.api.nvim_del_augroup_by_name "alpha_autostart" -- disable alpha auto start

  vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Restore session on open",
    group = augroup("resession_auto_open", { clear = true }),
    callback = function()
      -- Only load the session if nvim was started with no args
      if vim.fn.argc(-1) == 0 then
        -- Save these to a different directory, so our manual sessions don't get polluted
        resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
      end
    end,
  })
end
