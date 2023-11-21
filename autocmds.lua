local utils = require "astronvim.utils"
local is_available = utils.is_available
local augroup = vim.api.nvim_create_augroup

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

if vim.g.neovide then
  local neovide = require "user.utils.neovide"
  neovide.init()
end

if is_available "resession.nvim" then
  local resession = require "resession"

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

if is_available "venv-selector.nvim" then
  vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Auto select virtualenv Nvim open",
    pattern = "*",
    callback = function()
      local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
      if venv ~= "" then require("venv-selector").retrieve_from_cache() end
    end,
    once = true,
  })
end

-- vim.api.nvim_create_user_command("MyLazyGit", require("user.utils.utils").toggle_lazy_git(), {})
