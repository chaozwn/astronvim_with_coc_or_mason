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
require "polish"
require "options"

local timer = require "screen_product"
local utils = require "utils"

local function my_custom_callback()
  local myArray = utils.get_all_cmds()
  math.randomseed(os.time())
  local randomIndex = math.random(1, #myArray)
  local randomElement = myArray[randomIndex]

  utils.tte(
    randomElement,
    function() timer.set_command_in_progress(true) end,
    function() timer.set_command_in_progress(false) end,
    false
  )
end

-- timer.start(120, my_custom_callback)

if vim.g.neovide then require("neovide").init() end
