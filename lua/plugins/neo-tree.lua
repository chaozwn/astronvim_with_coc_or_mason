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

---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- dependencies = { "miversen33/netman.nvim" },
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        event_handlers = {
          {
            event = "file_opened",
            handler = function() require("neo-tree.command").execute { action = "close" } end,
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
