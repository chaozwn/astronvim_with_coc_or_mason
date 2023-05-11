return {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
        require("lspsaga").setup({
            preview = {
                lines_above = 0,
                lines_below = 10,
            },
            scroll_preview = {
                scroll_down = "<C-f>",
                scroll_up = "<C-b>",
            },
            request_timeout = 2000,
            ui = {
                title = true,
                border = "single", -- Border type can be single, double, rounded, solid, shadow.
                winblend = 0,
                expand = "",
                collapse = "",
                code_action = "💡",
                incoming = " ",
                outgoing = " ",
                hover = ' ',
                kind = {},
            },
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                keys = {
                    jump_to = 'p',
                    expand_or_jump = '<cr>',
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    tabnew = 'r',
                    quit = { 'q', '<ESC>' },
                    close_in_preview = '<ESC>',
                },
            },
            lightbulb = {
                enable = true,
                enable_in_insert = true,
                sign = true,
                sign_priority = 40,
                virtual_text = false,
            },
            symbol_in_winbar = {
                enable = true,
                separator = " > ",
                ignore_patterns = {},
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
        })

        vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
        -- Use <C-t> to jump back
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
        vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

        vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
        vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

        vim.keymap.set("n", "[E", function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end)
        vim.keymap.set("n", "]E", function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end)

        vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

        -- Call hierarchy
        vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
        vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    end
}