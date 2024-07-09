local prefix_diff_view = "<Leader>g"

---@type LazySpec
return {
  {
    ---@type AstroCoreOpts
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      if vim.fn.executable "git" == 1 then
        maps.n[prefix_diff_view .. "s"] =
          { function() require("telescope.builtin").git_stash { use_file_path = true } end, desc = "Git stash" }
        maps.n[prefix_diff_view .. "g"] = {
          function() vim.cmd [[DiffviewOpen]] end,
          desc = "Open Git Diffview",
        }
        maps.n[prefix_diff_view .. "d"] = {
          function() vim.cmd [[DiffviewClose]] end,
          desc = "Close Git Diffview",
        }
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function() end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        event = "User AstroGitFile",
        cmd = { "DiffviewOpen" },
        opts = function(_, opts)
          require("astrocore").extend_tbl(opts, {
            enhanced_diff_hl = true,
            view = {
              default = { winbar_info = true },
              file_history = { winbar_info = true },
            },
            hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
          })
        end,
      },
    },
    opts = function(_, opts)
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"
      local utils = require "telescope.utils"

      local diffview = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection == nil then
          utils.__warn_no_selection "extensions.diffviewer.diffview"
          return
        end

        actions.close(prompt_bufnr)

        vim.cmd.DiffviewOpen { selection.value }
      end

      return require("astrocore").extend_tbl(opts, {
        pickers = {
          git_commits = {
            mappings = {
              n = { ["<C-r>d"] = diffview },
              i = { ["<C-r>d"] = diffview },
            },
          },
          git_bcommits = {
            mappings = {
              n = { ["<C-r>d"] = diffview },
              i = { ["<C-r>d"] = diffview },
            },
          },
          git_branches = {
            mappings = {
              n = { ["<C-r>d"] = diffview },
              i = { ["<C-r>d"] = diffview },
            },
          },
          git_stash = {
            mappings = {
              n = { ["<C-r>d"] = diffview },
              i = { ["<C-r>d"] = diffview },
            },
          },
        },
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    optional = true,
    opts = { integrations = { diffview = true } },
  },
}
