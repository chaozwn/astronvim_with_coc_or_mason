local M = {}

function M.decode_json(filename)
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
  return json
end

function M.check_json_key_exists(json, ...) return vim.tbl_get(json, ...) ~= nil end

function M.is_vue_project(bufnr)
  local lsp_rooter
  if type(bufnr) ~= "number" then bufnr = vim.api.nvim_get_current_buf() end
  local rooter = require "astrocore.rooter"
  if not lsp_rooter then
    lsp_rooter = rooter.resolve("lsp", {
      ignore = {
        servers = function(client)
          return not vim.tbl_contains({ "vtsls", "typescript-tools", "volar", "eslint", "tsserver" }, client.name)
        end,
      },
    })
  end

  local vue_dependency = false
  for _, root in ipairs(require("astrocore").list_insert_unique(lsp_rooter(bufnr), { vim.fn.getcwd() })) do
    local package_json = M.decode_json(root .. "/package.json")
    if
      package_json
      and (
        M.check_json_key_exists(package_json, "dependencies", "vue")
        or M.check_json_key_exists(package_json, "devDependencies", "vue")
      )
    then
      vue_dependency = true
      break
    end
  end

  return vue_dependency
end

function M.is_in_list(value, list)
  for i = 1, #list do
    if list[i] == value then return true end
  end
  return false
end

function M.get_parent_dir(path) return path:match "(.+)/" end

function M.copy_file(source_file, target_file)
  local target_file_parent_path = M.get_parent_dir(target_file)
  local cmd = string.format("mkdir -p %s", vim.fn.shellescape(target_file_parent_path))
  os.execute(cmd)
  cmd = string.format("cp %s %s", vim.fn.shellescape(source_file), vim.fn.shellescape(target_file))
  os.execute(cmd)

  vim.notify("File " .. target_file .. " created success.", vim.log.levels.INFO)
end

function M.get_filename_with_extension_from_path(path) return string.match(path, "([^/]+)$") end

function M.get_launch_json_by_source_file(source_file)
  local target_file = vim.fn.getcwd() .. "/.vscode/launch.json"
  local file_exist = M.file_exists(target_file)
  if file_exist then
    local confirm = vim.fn.confirm("File `.vscode/launch.json` Exist, Overwrite it?", "&Yes\n&No", 1, "Question")
    if confirm == 1 then M.copy_file(source_file, target_file) end
  else
    M.copy_file(source_file, target_file)
  end
end

function M.create_launch_json()
  vim.ui.select({
    "go",
    "node",
    "rust",
  }, { prompt = "Select Language Debug Template", default = "go" }, function(select)
    if not select then return end
    if select == "go" then
      local source_file = vim.fn.stdpath "config" .. "/.vscode/go_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "node" then
      local source_file = vim.fn.stdpath "config" .. "/.vscode/node_launch.json"
      M.get_launch_json_by_source_file(source_file)
    elseif select == "rust" then
      local source_file = vim.fn.stdpath "config" .. "/.vscode/rust_launch.json"
      M.get_launch_json_by_source_file(source_file)
    end
  end)
end

function M.remove_lsp_cwd(path, client_name)
  local cwd = M.get_lsp_root_dir(client_name)

  if cwd == nil then return nil end
  cwd = M.escape_pattern(cwd)

  return path:gsub("^" .. cwd, "")
end

function M.remove_cwd(path)
  local cwd = vim.fn.getcwd()
  cwd = M.escape_pattern(cwd) .. "/"

  return path:gsub("^" .. cwd, "")
end

function M.escape_pattern(text) return text:gsub("([^%w])", "%%%1") end

function M.file_exists(path)
  local file = io.open(path, "r")
  if file then
    io.close(file)
    return true
  else
    return false
  end
end

function M.get_lsp_root_dir(client_name)
  local clients = vim.lsp.get_clients()

  if next(clients) == nil then return nil end

  for _, client in ipairs(clients) do
    if client.name == client_name then
      local root_dir = client.config.root_dir
      if root_dir then return root_dir end
    end
  end

  return nil
end

function M.write_log(file_name, content)
  local file = io.open(file_name, "w")
  if file then
    file:write(vim.inspect(content))
    file:close()
  end
end

function M.save_client(client)
  if client.name then
    local file = io.open(client.name .. ".txt", "w")
    if file then
      file:write(vim.inspect(client))
      file:close()
    end
  end
end

function M.extend(t, key, values)
  local keys = vim.split(key, ".", { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= "table" then return end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

-- This file is automatically ran last in the setup process and is a good place to configure
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
function M.yaml_ft(path, bufnr)
  local buf_text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  if
    -- check if file is in roles, tasks, or handlers folder
    vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
    -- check for known ansible playbook text and if found, return yaml.ansible
    or vim.regex("hosts:\\|tasks:"):match_str(buf_text)
  then
    return "yaml.ansible"
  elseif vim.regex("AWSTemplateFormatVersion:"):match_str(buf_text) then
    return "yaml.cfn"
  else -- return yaml if nothing else
    return "yaml"
  end
end

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

function M.better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end

function M.remove_keymap(mode, key)
  for _, map in pairs(vim.api.nvim_get_keymap(mode)) do
    ---@diagnostic disable-next-line: undefined-field
    if map.lhs == key then vim.api.nvim_del_keymap(mode, key) end
  end
end

function M.toggle_lazy_docker()
  return function()
    require("astrocore").toggle_term_cmd {
      cmd = "lazydocker",
      direction = "float",
      hidden = true,
      on_open = function() M.remove_keymap("t", "<Esc>") end,
      on_close = function() vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true }) end,
      on_exit = function()
        -- For Stop Term Mode
        vim.cmd [[stopinsert]]
      end,
    }
  end
end

function M.toggle_btm()
  return function()
    require("astrocore").toggle_term_cmd {
      cmd = "btm",
      direction = "float",
      hidden = true,
      on_open = function() M.remove_keymap("t", "<Esc>") end,
      on_close = function() vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true }) end,
      on_exit = function()
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
      direction = "float",
      hidden = true,
      on_open = function() M.remove_keymap("t", "<Esc>") end,
      on_close = function() vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { silent = true, noremap = true }) end,
      on_exit = function()
        -- For Stop Term Mode
        vim.cmd [[stopinsert]]
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
  assert(vim.islist(lst), "Provided table is not a list like table")
  if not vim.islist(vals) then vals = { vals } end
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
    end,
    on_exit = function(t, _, _, _)
      if close_callback and type(close_callback) == "function" then close_callback() end
      if vim.api.nvim_buf_is_loaded(t.bufnr) then vim.api.nvim_buf_delete(t.bufnr, { force = true }) end
    end,
  }
end

function M.get_all_cmds()
  return {
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
end

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
            results = M.get_all_cmds(),
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

return M
