local function get_buffer_by_name(buf_name)
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match(buf_name) then return buf end
  end
  return nil
end

local function trash(state)
  local inputs = require "neo-tree.ui.inputs"
  local cmds = require "neo-tree.sources.manager"
  local utils = require "neo-tree.utils"
  local tree = state.tree
  local node = tree:get_node()

  if node.type == "message" then return end
  local _, name = utils.split_path(node.path)
  local msg = string.format("Are you sure you want to trash '%s'?", name)
  inputs.confirm(msg, function(confirmed)
    if not confirmed then return end
    vim.api.nvim_command("silent !trash -F " .. node.path)
    local buf_id = get_buffer_by_name(node.path)
    if buf_id and buf_id ~= 0 then require("astrocore.buffer").close(buf_id, true) end
    cmds.refresh(state)
  end)
end

local function trash_visual(state, selected_nodes)
  local inputs = require "neo-tree.ui.inputs"
  local cmds = require "neo-tree.sources.manager"

  local paths_to_trash = {}
  for _, node in ipairs(selected_nodes) do
    if node.type ~= "message" then table.insert(paths_to_trash, node.path) end
  end
  local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
  inputs.confirm(msg, function(confirmed)
    if not confirmed then return end
    for _, path in ipairs(paths_to_trash) do
      vim.api.nvim_command("silent !trash -F " .. path)
      local buf_id = get_buffer_by_name(path)
      if buf_id and buf_id ~= 0 then require("astrocore.buffer").close(buf_id, true) end
    end
    cmds.refresh(state)
  end)
end

local function get_filename_from_path(path)
  local name = path:match "([^/]+)$" or path
  return (name:match "(.+)%..+" or name)
end

local function get_filetype_from_path(path)
  local match = string.match(path, "%.([^%.\\/]*)$")

  if match then
    local ext = string.lower(match)
    -- NOTE: go
    if ext == "go" then
      return "go"
    elseif ext == "api" then
      return "api"
    elseif ext == "proto" then
      return "proto"
    elseif ext == "rs" then
      return "rust"
    else
      return "unknown"
    end
  else
    return "unknown"
  end
end

local function get_parent_dir(path)
  if not path then return nil end

  local parent_path = path:match "(.+)/"

  if parent_path then
    local name = parent_path:match "([^/]+)$"
    return name
  else
    return "root"
  end
end

local function get_lsp_root_dir(client_name)
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

local function is_file(path)
  if path:sub(-1) == "/" then
    return false
  else
    return true
  end
end

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    io.close(file)
    return true
  else
    return false
  end
end

local function escape_pattern(text) return text:gsub("([^%w])", "%%%1") end

local function remove_lsp_cwd(path, client_name)
  local cwd = get_lsp_root_dir(client_name)

  if cwd == nil then return nil end
  cwd = escape_pattern(cwd)

  return path:gsub("^" .. cwd, "")
end

local function get_filename_without_extension_from_path(path, client_name)
  local relative_path = remove_lsp_cwd(path, client_name)
  if relative_path == nil then return nil end
  return get_parent_dir(relative_path)
end

local function get_parent_directory(path) return path:match "(.*/)" end

local function insert_to_file_first_line(path, content)
  local original_file = io.open(path, "r")
  if not original_file then return end

  local original_content = original_file:read "*a"
  original_file:close()

  local file = io.open(path, "w")
  if file then
    file:write(content)
    file:write(original_content)
    file:close()
  end
end

local filetype_mapping = {
  go = function(path)
    local file = io.open(path, "w")
    if file then
      local parent_name = get_filename_without_extension_from_path(path, "gopls")
      if parent_name ~= nil then
        if parent_name == "root" then parent_name = "main" end
        file:write("package " .. parent_name .. "\n")
      end
      file:close()
    end
  end,
  api = function(path)
    local file = io.open(path, "w")
    if file then
      file:write 'syntax = "v1"'
      file:close()
    end
  end,
  proto = function(path)
    local file = io.open(path, "w")
    if file then
      file:write 'syntax = "proto3";'
      file:close()
    end
  end,
  rust = function(path)
    local parent_name = get_filename_without_extension_from_path(path, "rust-analyzer")
    local relative_path = remove_lsp_cwd(path, "rust-analyzer")

    if relative_path and string.find(relative_path, "^/src/") and parent_name == "src" then
      local root_dir = get_lsp_root_dir "rust-analyzer"
      if root_dir ~= nil then
        local lib_path = root_dir .. "/src/lib.rs"
        local main_path = root_dir .. "/src/main.rs"
        local filename = get_filename_from_path(path)
        if filename ~= "lib" and filename ~= "main" then
          vim.ui.select({
            "src/lib.rs",
            "src/main.rs",
          }, { prompt = "Attach File to Module:", default = "src/main.rs" }, function(select)
            if not select then return end
            if select == "src/lib.rs" then
              if not file_exists(lib_path) then
                local confirm = vim.fn.confirm("File `src/lib.rs` Not Exist, Create it?", "&Yes\n&No", 1, "Question")
                if confirm == 1 then
                  local file = io.open(lib_path, "w")
                  if file then
                    local filename = get_filename_from_path(path)
                    if filename then file:write("mod " .. filename .. ";\n") end
                    file:close()
                  end
                else
                  return
                end
              else
                insert_to_file_first_line(lib_path, "mod " .. get_filename_from_path(path) .. ";\n")
              end
            elseif select == "src/main.rs" then
              if not file_exists(main_path) then
                local choice = vim.fn.confirm("File `src/main.rs` Not Exist, Create it?", "&Yes\n&No", 2)
                if choice and choice == 1 then
                  local file = io.open(main_path, "w")
                  if file then
                    local filename = get_filename_from_path(path)
                    if filename then file:write("mod " .. filename .. ";\n") end
                    file:close()
                  end
                end
              else
                insert_to_file_first_line(main_path, "mod " .. get_filename_from_path(path) .. ";\n")
              end
            end
          end)
        end
      end
    elseif relative_path and string.find(relative_path, "^/src/") then
      local confirm = vim.fn.confirm("Attach file to `mod.rs`?", "&Yes\n&No", 1, "Question")
      if confirm == 1 then
        local mod_path = get_parent_directory(path) .. "/mod.rs"
        if not file_exists(mod_path) then
          confirm = vim.fn.confirm("File `mod.rs` Not Exist, Create it?", "&Yes\n&No", 1, "Question")
          if confirm == 1 then
            local file = io.open(mod_path, "w")
            if file then
              local filename = get_filename_from_path(path)
              if filename then file:write("mod " .. filename .. ";\n") end
              file:close()
            end
          else
            return
          end
        else
          insert_to_file_first_line(mod_path, "mod " .. get_filename_from_path(path) .. ";\n")
        end
      else
        return
      end
    end
  end,
  unknown = function() end,
}

---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local neo_tree_events = require "neo-tree.events"

      return require("astrocore").extend_tbl(opts, {
        event_handlers = {
          {
            event = neo_tree_events.FILE_OPENED,
            handler = function() require("neo-tree.command").execute { action = "close" } end,
          },
          {
            event = neo_tree_events.FILE_ADDED,
            handler = function(path)
              if is_file(path) then
                -- match file_type
                local file_type = get_filetype_from_path(path)
                filetype_mapping[file_type](path)
              else
                -- match dir
              end
            end,
          },
        },
        close_if_last_window = true,
        enable_diagnostics = true,
        popup_border_style = "rounded",
        sources = {
          "filesystem",
        },
        source_selector = {
          winbar = false,
        },
        filesystem = {
          commands = {
            delete = trash,
            delete_visual = trash_visual,
          },
          use_libuv_file_watcher = true,
          bind_to_cwd = false,
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            always_show = { ".github", ".gitignore" },
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              ".git",
              -- "node_modules",
            },
            never_show = {
              ".DS_Store",
              "thumbs.db",
            },
          },
        },
      })
    end,
  },
}
