local ScreenMonitor = {
  timeout_seconds = 300, -- 5 minutes
  timer_id = nil,
  last_action_time = os.time(),
  timeout_callback = nil,
  augroup_name = "ScreenIdleGroup",
  command_in_progress = false,
}

function ScreenMonitor:new(timeout_seconds, timeout_callback)
  local obj = { timeout_seconds = timeout_seconds, timeout_callback = timeout_callback }
  setmetatable(obj, self)
  self.__index = self
  self.command_in_progress = false
  self.timer_id = nil
  self.last_action_time = os.time()
  self.augroup_name = "ScreenIdleGroup"
  return obj
end

function ScreenMonitor:update_time() self.last_action_time = os.time() end

function ScreenMonitor:check_idle_time()
  local current_time = os.time()
  local idle_duration = current_time - self.last_action_time
  -- print(idle_duration, " ..out.. ", self.command_in_progress)
  if idle_duration >= self.timeout_seconds and not self.command_in_progress then
    -- print(idle_duration, " ..in.. ", self.command_in_progress)
    if self.timeout_callback and type(self.timeout_callback) == "function" then self.timeout_callback() end
  end
end

function ScreenMonitor:augroup_exists(group_name) return vim.api.nvim_exec("augroup " .. group_name, true) ~= "" end

function ScreenMonitor:create_behavior_monitor()
  if not self:augroup_exists(self.augroup_name) then
    vim.api.nvim_create_augroup(self.augroup_name, { clear = true })
  end

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI" }, {
    callback = function() self:update_time() end,
    group = self.augroup_name,
  })
end

function ScreenMonitor:create_idle_monitor()
  if self.timer_id then vim.fn.timer_stop(self.timer_id) end
  self.timer_id = vim.fn.timer_start(3000, function() self:check_idle_time() end, { ["repeat"] = -1 })
end

function ScreenMonitor:start_monitor()
  self:create_behavior_monitor()
  self:create_idle_monitor()
end

function ScreenMonitor:stop_monitor()
  if self.timer_id then
    vim.fn.timer_stop(self.timer_id)
    self.timer_id = nil
  end
  if vim.api.nvim_call_function("augroup_exists", { self.augroup_name }) == 1 then
    vim.api.nvim_del_augroup_by_name(self.augroup_name)
  end
end

function ScreenMonitor:update_state(state) self.command_in_progress = state end

return ScreenMonitor
