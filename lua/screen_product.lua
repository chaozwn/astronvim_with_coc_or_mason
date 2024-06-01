-- inactivity_timer.lua
local M = {}

-- 默认的不活动时间阈值（单位：秒）
local default_timeout_seconds = 300 -- 5分钟

-- 定时器 ID
local timer_id = nil

-- 用户操作的时间戳
local last_action_time = os.time()

-- 是否有命令正在执行
local command_in_progress = false

-- 更新时间戳的函数
local function update_time()
  last_action_time = os.time()
end

-- 定时器回调函数
local function check_inactivity(callback, timeout)
  local current_time = os.time()
  local inactivity_duration = current_time - last_action_time
  if inactivity_duration >= timeout and not command_in_progress then
    -- 如果设置了回调函数，执行它
    if callback and type(callback) == "function" then callback() end
  end
end

-- 启动不活动监听器
function M.start(timeout, callback)
  local timeout_seconds = timeout or default_timeout_seconds

  -- 创建或更新自动命令组
  local augroup_name = "InactivityTimerGroup"
  local augroup_exists = vim.fn.exists("#" .. augroup_name) == 1
  if not augroup_exists then vim.api.nvim_create_augroup(augroup_name, { clear = true }) end

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI" }, {
    callback = update_time,
    group = augroup_name,
  })

  -- 创建或重新设置定时器
  if timer_id then vim.fn.timer_stop(timer_id) end
  timer_id = vim.fn.timer_start(1000, function() check_inactivity(callback, timeout_seconds) end, { ["repeat"] = -1 })
end

-- 停止不活动监听器
function M.stop()
  if timer_id then
    vim.fn.timer_stop(timer_id)
    timer_id = nil
  end
  local augroup_name = "InactivityTimerGroup"
  local augroup_exists = vim.api.nvim_call_function("augroup_exists", { augroup_name }) == 1
  if augroup_exists then vim.api.nvim_del_augroup_by_name(augroup_name) end
end

-- 设置命令执行状态
function M.set_command_in_progress(state) command_in_progress = state end

return M
