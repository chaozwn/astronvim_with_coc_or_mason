---@type LazySpec
return {
  "f-person/git-blame.nvim",
  event = "User AstroGitFile",
  cmd = {
    "GitBlameToggle",
    "GitBlameEnable",
    "GitBlameOpenCommitURL",
    "GitBlameCopyCommitURL",
    "GitBlameOpenFileURL",
    "GitBlameCopyFileURL",
    "GitBlameCopySHA",
  },
  -- NOTE: if you want to improve performance, you can change the event to CursorHold
  -- init = function()
  -- vim.g.gitblame_schedule_event = "CursorHold"
  -- vim.g.gitblame_clear_event = "CursorHoldI"
  -- end,
  opts = {
    enabled = true,
    date_format = "%r",
    message_template = "  <author> 󰔠 <date> 󰈚 <summary>  <sha>",
    message_when_not_committed = "  Not Committed Yet",
  },
  keys = {
    { "<Leader>gB", mode = { "n" }, desc = "Git Blame Functions" },
    {
      "<Leader>gBc",
      mode = { "n" },
      function() vim.cmd [[GitBlameOpenCommitURL]] end,
      desc = "Git Blame Open Commit URL",
    },
    {
      "<Leader>gBs",
      mode = { "n" },
      function() vim.cmd [[GitBlameCopySHA]] end,
      desc = "Git Blame Copy SHA",
    },
    {
      "<Leader>gBo",
      mode = { "n" },
      function() vim.cmd [[GitBlameOpenFileURL]] end,
      desc = "Git Blame Open File URL",
    },
    {
      "<Leader>gBy",
      mode = { "n" },
      function() vim.cmd [[GitBlameCopyFileURL]] end,
      desc = "Git Blame Copy File URL",
    },
  },
}
