-- TODO: 增加下面的按键映射
-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- keymap("n", cfg.typescript.keys.ts_organize, ":TypescriptOrganizeImports<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_rename_file, ":TypescriptRenameFile<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_add_missing_import, ":TypescriptAddMissingImports<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_remove_unused, ":TypescriptRemoveUnused<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_fix_all, ":TypescriptFixAll<CR>", bufopts)
-- keymap("n", cfg.typescript.keys.ts_goto_source, ":TypescriptGoToSourceDefinition<CR>", bufopts)
return {
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  settings = {
    javascript = {
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
}
