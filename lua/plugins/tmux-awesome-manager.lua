if not vim.fn.executable "tmux" then return {} end

return {
  "otavioschwanck/tmux-awesome-manager.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim",
  },
  config = function()
    local tmux = require "tmux-awesome-manager"
    tmux.setup {
      per_project_commands = { -- Configure your per project servers with
        -- project name = { { cmd, name } }
        front = { { cmd = "yarn", name = "init front project" } },
      },
      session_name = "Neovim Terminals",
      use_icon = false, -- use prefix icon
      icon = " ", -- Prefix icon to use
      -- project_open_as = "window", -- Open per_project_commands as.  Default: separated_session
      default_size = "30%", -- on panes, the default size
      open_new_as = "pane", -- open new command as.  options: pane, window, separated_session.
    }
    
    -- commands
    tmux.run_wk {
      cmd = "yarn test",
      name = "Vitest test",
      session_name = "Vitest test Window",
      open_as = 'pane',
      size = '30%',
      orientation = 'horizontal',
    }

    tmux.run_wk {
      cmd = "yarn dev",
      name = "Yarn Dev",
      session_name = "Yarn Dev Window",
    }

    tmux.run_wk {
      cmd = "cd %1 && go mod init %2",
      name = "Go mod init",
      questions = { { question = "path: " }, { question = "module name: ", required = true } },
      use_cwd = true,
      session_name = "Go mod init Window",
    }

    tmux.run_wk {
      cmd = "go mod tidy",
      name = "Go mod tidy",
      use_cwd = true,
      session_name = "Go mod tidy",
    }

    tmux.run_wk {
      cmd = "gf run main.go",
      name = "GoFrame run",
      session_name = "Goframe run",
    }

    -- keymap
    vim.keymap.set("v", "<leader>t", tmux.send_text_to, { desc = "Send text to a open terminal" }) -- Send text to a open terminal?
    vim.keymap.set("n", "<leader>tk", tmux.kill_all_terms, { desc = "Kill all open terms" }) -- Kill all open terms.
    vim.keymap.set("n", "<leader>t!", tmux.run_project_terms, { desc = "Run the per project commands" }) -- Run the per project commands
    vim.keymap.set(
      "n",
      "<leader>tt",
      function() vim.cmd ":Telescope tmux-awesome-manager list_terms" end,
      { desc = "List all terminals" }
    ) -- List all terminals
    vim.keymap.set(
      "n",
      "<leader>to",
      function() vim.cmd ":Telescope tmux-awesome-manager list_open_terms" end,
      { desc = "List open terminals" }
    ) -- List open terminals

    -- Toggle tmux-awesome-manager
    vim.keymap.set("n", "<leader>uo", tmux.switch_orientation, { desc = "Open new panes as vertical / horizontal" }) -- Open new panes as vertical / horizontal?
    vim.keymap.set("n", "<leader>uP", tmux.switch_open_as, { desc = "Open new terminals as panes or windows" }) -- Open new terminals as panes or windows?
  end,
}
