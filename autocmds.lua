-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- auto hide tabline
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroBufsUpdated",
  group = vim.api.nvim_create_augroup("autohidetabline", { clear = true }),
  callback = function()
    local new_showtabline = #vim.t.bufs > 1 and 2 or 1
    if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
  end,
})

vim.api.nvim_create_augroup("im-select", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = "im-select",
  callback = require("user.utils.im-select").macInsertLeave,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "im-select",
  callback = require("user.utils.im-select").macInsertEnter,
})
vim.api.nvim_create_autocmd("FocusGained", {
  group = "im-select",
  callback = require("user.utils.im-select").macFocusGained,
})
vim.api.nvim_create_autocmd("FocusLost", {
  group = "im-select",
  callback = require("user.utils.im-select").macFocusLost,
})

if vim.g.neovide then
  local neovide = require "user.utils.neovide"
  neovide.init()
end

local lsp_type = require("user.config.lsp_type").lsp_type
if lsp_type == 'coc' then
  vim.api.nvim_create_augroup("CocGroup", {})

  vim.cmd("command! -nargs=? Fold :call CocAction('fold', <f-args>)")
  vim.cmd("hi CocFloating ctermbg=235 guibg=#13354A")
  -- vim.cmd("hi CocMenuSel ctermbg=237 guibg=#13354A")
  vim.cmd("highlight CocHighlightText guibg=#545c7e")
  vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
  })

  -- Setup formatexpr specified filetype(s)
  vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
  })

  -- Update signature help on jump placeholder
  vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
  })

  -- Add `:Format` command to format current buffer
  vim.api.nvim_create_user_command("Format", "call CocActionAsync('format')", {})

  -- " Add `:Fold` command to fold current buffer
  vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

  -- Add `:OR` command for organize imports of the current buffer
  vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
end
