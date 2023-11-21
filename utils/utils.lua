local M = {}

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astronvim.utils").notify(error, vim.log.levels.ERROR) end
  end
end

function M.is_mac()
  return function()
    local system = vim.loop.os_uname().sysname
    if system == "Darwin" then
      return true
    else
      return false
    end
  end
end

function M.get_os()
  -- NOTE: mac system both return 1 in ('mac','unix')
  -- get the current OS
  local os
  if vim.fn.has "mac" == 1 then
    os = "mac"
  elseif vim.fn.has "unix" == 1 then
    os = "linux"
  elseif vim.fn.has "win32" == 1 then
    os = "win"
  else
    require("astronvim.utils").notify("not valid os", vim.log.levels.ERROR)
  end
  return os
end

function M.is_vue_project()
  local package_json_path = vim.fn.getcwd() .. "/package.json"
  local file = io.open(package_json_path, "r")

  if file then
    local package_json_content = file:read "*a"
    file:close()

    local package_json = vim.fn.json_decode(package_json_content)

    if package_json and package_json.dependencies and package_json.dependencies.vue then return true end
  end

  return false
end

function M.remove_keymap(mode, key)
  for _, map in pairs(vim.api.nvim_get_keymap(mode)) do
    if map.lhs == key then vim.api.nvim_del_keymap(mode, key) end
  end
end

function M.toggle_lazy_git()
  return function()
    local worktree = require("astronvim.utils.git").file_worktree()
    local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
    require("astronvim.utils").toggle_term_cmd {
      cmd = "lazygit " .. flags,
      hidden = true,
      on_open = function()
        M.remove_keymap("t", "<C-H>")
        M.remove_keymap("t", "<C-J>")
        M.remove_keymap("t", "<C-K>")
        M.remove_keymap("t", "<C-L>")
      end,
      on_close = function()
        vim.api.nvim_set_keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { silent = true, noremap = true })
      end,
      on_exit = function(t, job, code, event)
        -- For Stop Term Mode
        vim.cmd [[stopinsert]]
      end,
    }
  end
end

function M.toggle_joshuto(path)
  return function()
    local output_path = "/tmp/joshuto_filechosen"
    os.remove(output_path)
    path = vim.fn.expand "%:p:h"
    local cmd = string.format('joshuto --file-chooser --output-file "%s" "%s"', output_path, path)
    require("astronvim.utils").toggle_term_cmd {
      cmd = cmd,
      hidden = true,
      on_open = function()
        M.remove_keymap("t", "<C-H>")
        M.remove_keymap("t", "<C-J>")
        M.remove_keymap("t", "<C-K>")
        M.remove_keymap("t", "<C-L>")
      end,
      on_close = function()
        vim.api.nvim_set_keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { silent = true, noremap = true })
      end,
      on_exit = function(t, job, code, event)
        if code == 102 then
          local open_path = vim.fn.readfile(output_path)[1]
          vim.cmd "silent! :checktime"
          vim.loop.new_timer():start(
            0,
            0,
            vim.schedule_wrap(function()
              if open_path then vim.cmd(string.format("edit %s", open_path)) end
            end)
          )
        end
      end,
    }
  end
end

function M.removeValueFromTable(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      table.remove(tbl, i)
      return true
    end
  end
  return false
end

function M.list_remove_unique(lst, vals)
  if not lst then lst = {} end
  assert(vim.tbl_islist(lst), "Provided table is not a list like table")
  if not vim.tbl_islist(vals) then vals = { vals } end
  local added = {}
  vim.tbl_map(function(v) added[v] = true end, lst)
  for _, val in ipairs(vals) do
    if added[val] then
      M.removeValueFromTable(lst, val)
      added[val] = false
    end
  end
  return lst
end

return M
