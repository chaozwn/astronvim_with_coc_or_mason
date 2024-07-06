-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"

-- local screen_monitor = require "screen_monitor"
-- local utils = require "utils"
--
-- local function timeout_callback()
--   local tte_id = nil
--   return function()
--     local tte_array = utils.get_all_cmds()
--     local tte_count = #tte_array
--     if tte_id == nil then tte_id = 1 end
--     if tte_id > tte_count then tte_id = 1 end
--     utils.tte(
--       tte_array[tte_id],
--       function() screen_monitor:update_state(true) end,
--       function() screen_monitor:update_state(false) end,
--       false
--     )
--     tte_id = tte_id + 1
--   end
-- end
--
-- local my_screen = screen_monitor:new(300, timeout_callback())
-- my_screen:start_monitor()
