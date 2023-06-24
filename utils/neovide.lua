local M = {}

function M.init()
  M.config()
  if vim.g.transparent_background then M.background() end
  M.refresh(60, 5)
end

function M.config()
  vim.o.guifont = "JetBrainsMono Nerd Font:h16"
  -- 没有空闲
  vim.g.neovide_no_idle = true
  -- 退出需要确认
  vim.g.neovide_confirm_quit = true
  -- 是否全屏
  vim.g.neovide_fullscreen = false
  -- 记住以前窗口的大小
  vim.g.neovide_remember_window_size = true
  -- 使用super键位,比如<cmd>
  -- vim.g.neovide_input_use_logo = true
  -- 开启Alt和Meta按键
  vim.g.neovide_input_macos_alt_is_meta = true
  -- 触控板死亡地带
  -- vim.g.neovide_touch_deadzone = 6.0
  -- 触控板拖动超时
  -- vim.g.neovide_touch_drag_timeout = 0.17
  -- 开启轨道动画
  vim.g.neovide_cursor_vfx_mode = "railgun"
end

function M.background()
  -- 设置透明背景
  local alpha = function() return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8)) end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.9
  vim.g.neovide_background_color = "#0f1117" .. alpha()
end

-- 设置fps
function M.refresh(run_fps, free_fps)
  -- 设置刷新率
  vim.g.neovide_refresh_rate = run_fps
  -- 空闲刷新率
  vim.g.neovide_refresh_rate_idle = free_fps
end

return M
