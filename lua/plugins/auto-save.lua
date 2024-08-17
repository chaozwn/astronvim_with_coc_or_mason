local function is_ju_py_file(buf)
  if not buf then return end

  local bufname = vim.api.nvim_buf_get_name(buf)

  if bufname:match "%.ju%.py$" then
    return true
  else
    return false
  end
end

---@type LazySpec
return {
  "chaozwn/auto-save.nvim",
  event = { "User AstroFile", "InsertEnter" },
  opts = {
    debounce_delay = 3000,
    print_enabled = false,
    trigger_events = { "TextChanged" },
    condition = function(buf)
      local fn = vim.fn
      local utils = require "auto-save.utils.data"

      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        -- check weather not in normal mode
        if fn.mode() ~= "n" then
          return false
        else
          if is_ju_py_file(buf) then
            return false
          else
            return true
          end
        end
      end
      return false -- can't save
    end,
  },
}
