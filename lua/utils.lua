local M = {}

function M.write_to_file(content, file_path)
  local file = io.open(file_path, "a")
  if not file then
    print("Unable to open file: " .. file_path)
    return
  end
  file:write(vim.inspect(content))
  file:write "\n"
  file:close()
end

function M.check_json_key_exists(filename, key)
  -- Open the file in read mode
  local file = io.open(filename, "r")
  if not file then
    return false -- File doesn't exist or cannot be opened
  end

  -- Read the contents of the file
  local content = file:read "*all"
  file:close()

  -- Parse the JSON content
  local json_parsed, json = pcall(vim.fn.json_decode, content)
  if not json_parsed or type(json) ~= "table" then
    return false -- Invalid JSON format
  end

  -- Check if the key exists in the JSON object
  return json[key] ~= nil
end

function M.is_vue_project()
  local package_path = vim.fn.getcwd() .. "/package.json"
  local file = io.open(package_path, "r")

  if not file then
    return false -- File doesn't exist or cannot be opened
  end

  -- Read the contents of the file
  local content = file:read "*all"
  file:close()

  -- Parse the JSON content
  local json_parsed, json = pcall(vim.fn.json_decode, content)
  if not json_parsed or type(json) ~= "table" then
    return false -- Invalid JSON format
  end

  -- Check if the key exists in the JSON object
  if json and json.dependencies and json.dependencies.vue then
    return true
  else
    return false
  end
end

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end

function M.remove_keymap(mode, key)
  for _, map in pairs(vim.api.nvim_get_keymap(mode)) do
    if map.lhs == key then vim.api.nvim_del_keymap(mode, key) end
  end
end

function M.toggle_unicmatrix()
  return function()
    require("astrocore").toggle_term_cmd {
      cmd = "unimatrix -s 96 -o -b",
      hidden = false,
      direction = "float",
      float_opts = {
        -- Enable full screen
        width = vim.o.columns,
        height = vim.o.lines,
        border = "none",
      },
    }
  end
end

function M.tte(selection, open_callback, close_callback, flag)
  local current_path = vim.fn.expand "%:p" -- get current file path
  local cmd = "tte --input-file " .. current_path .. " --xterm-colors " .. selection
  require("astrocore").toggle_term_cmd {
    cmd = cmd,
    hidden = false,
    direction = "float",
    close_on_exit = false,
    float_opts = {
      width = vim.o.columns,
      height = vim.o.lines,
      border = "none",
    },
    on_open = function()
      if open_callback and type(open_callback) == "function" then open_callback() end
    end,
    on_close = function(t)
      if flag then t:send "\x03" end
      if close_callback and type(close_callback) == "function" then close_callback() end
    end,
    on_exit = function(t, _, _, _)
      if close_callback and type(close_callback) == "function" then close_callback() end
      if vim.api.nvim_buf_is_loaded(t.bufnr) then vim.api.nvim_buf_delete(t.bufnr, { force = true }) end
    end,
  }
end

local cmds = {
  "beams",
  "binarypath",
  "blackhole",
  "bouncyballs",
  "bubbles",
  "burn",
  "colorshift",
  "crumble",
  "decrypt",
  "errorcorrect",
  "expand",
  "fireworks",
  "middleout",
  "orbittingvolley",
  "overflow",
  "pour",
  "print",
  "rain",
  "randomsequence",
  "rings",
  "scattered",
  "slice",
  "slide",
  "spotlights",
  "spray",
  "swarm",
  "synthgrid",
  "unstable",
  "vhstape",
  "waves",
  "wipe",
}

function M.get_all_cmds() return cmds end

function M.toggle_tte()
  if require("astrocore").is_available "telescope.nvim" then
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values

    return function()
      pickers
        .new({}, {
          prompt_title = "Select TTE Effect",
          finder = finders.new_table {
            results = cmds,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry,
                ordinal = entry,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              M.tte(selection.value, nil, nil, true)
            end)
            return true
          end,
        })
        :find()
    end
  end
end

function M.toggle_lazy_docker()
  return function()
    require("astrocore").toggle_term_cmd {
      cmd = "lazydocker",
      hidden = true,
      on_open = function()
        M.remove_keymap("t", "<C-H>")
        M.remove_keymap("t", "<C-J>")
        M.remove_keymap("t", "<C-K>")
        M.remove_keymap("t", "<C-L>")
      end,
      on_close = function()
        vim.api.nvim_set_keymap("t", "<C-H>", "<cmd>wincmd h<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-J>", "<cmd>wincmd j<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-K>", "<cmd>wincmd k<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-L>", "<cmd>wincmd l<cr>", { silent = true, noremap = true })
      end,
      on_exit = function(t, job, code, event)
        -- For Stop Term Mode
        vim.cmd [[stopinsert]]
      end,
    }
  end
end

function M.toggle_lazy_git()
  return function()
    local worktree = require("astrocore").file_worktree()
    local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
    require("astrocore").toggle_term_cmd {
      cmd = "lazygit " .. flags,
      hidden = true,
      on_open = function()
        M.remove_keymap("t", "<C-H>")
        M.remove_keymap("t", "<C-J>")
        M.remove_keymap("t", "<C-K>")
        M.remove_keymap("t", "<C-L>")
      end,
      on_close = function()
        vim.api.nvim_set_keymap("t", "<C-H>", "<cmd>wincmd h<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-J>", "<cmd>wincmd j<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-K>", "<cmd>wincmd k<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-L>", "<cmd>wincmd l<cr>", { silent = true, noremap = true })
      end,
      on_exit = function(t, job, code, event)
        -- For Stop Term Mode
        vim.cmd [[stopinsert]]
      end,
    }
  end
end

local function file_exists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
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
