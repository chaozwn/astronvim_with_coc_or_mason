-- TODO: 增加下面的按键映射
-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- keymap("n", cfg.typescript.keys.ts_organize, ":TypescriptOrganizeImports<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_rename_file, ":TypescriptRenameFile<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_add_missing_import, ":TypescriptAddMissingImports<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_remove_unused, ":TypescriptRemoveUnused<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_fix_all, ":TypescriptFixAll<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_goto_source, ":TypescriptGoToSourceDefinition<CR>", bufopts)

local utils = require "user.utils.utils"

local function get_filetypes()
  if utils.is_vue_project() then
    return { "nil" }
  else
    return { "typescript", "javascript", "javascriptreact", "typescriptreact" }
  end
end

return {
  filetypes = get_filetypes(),
}
