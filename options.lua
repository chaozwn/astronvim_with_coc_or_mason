-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    conceallevel = 2, -- enable conceal
    list = true,      -- show whitespace characters
    listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
    showbreak = "↪ ",
    -- showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
    spellfile = vim.fn.expand "~/.config/nvim/lua/user/spell/en.utf-8.add",
    thesaurus = vim.fn.expand "~/.config/nvim/lua/user/spell/mthesaur.txt",
    swapfile = false,
    wrap = true, -- soft wrap lines
    termguicolors = true,
    -- set to true or false etc.
    --   relativenumber = true, -- sets vim.opt.relativenumber
    --   number = true,         -- sets vim.opt.number
    --   spell = false,         -- sets vim.opt.spell
    --   signcolumn = "auto",   -- sets vim.opt.signcolumn to auto
    --   wrap = false,          -- sets vim.opt.wrap
    --   -- jayce
    --   -- hjkl 移动时光标周围保留8行,这边我不需要,我使用zz,zt,zb来控制窗口
    --   scrolloff = 8,
    --   sidescrolloff = 8,
    --   -- 高亮所在行
    --   cursorline = true,
    --   -- 缩进2个空格等于一个tab
    --   tabstop = 2,
    --   softtabstop = 2,
    --   -- >> <<时移动的长度
    --   shiftround = true,
    --   shiftwidth = 2,
    --   -- 空格代替tab
    --   expandtab = true,
    --   -- 新行对齐当前行
    --   autoindent = true,
    --   smartindent = true,
    --   -- 搜索大小写不敏感,除非包含大写
    --   ignorecase = true,
    --   smartcase = true,
    --   -- 边输入边搜索
    --   incsearch = true,
    --   -- 当文件被外部文件修改时,自动加载
    --   autoread = true,
    --   -- 增加鼠标支持
    --   mouse = "a",
    --   -- 光标在行尾时<left><right>可以跳到下一行
    --   whichwrap = "<,>,[,]",
    --   -- 允许隐藏被修改过的buffer
    --   hidden = true,
    --   -- 禁止创建备份文件
    --   backup = false,
    --   writebackup = false,
    --   swapfile = false,
    --   -- 设置缓冲区更新时间
    --   -- updatetime = 300,
    --   -- 设置timeoutlen 为等待键盘快捷键连击时间500毫秒,当你组合按键的时候生效
    --   -- 遇到问题详见：https://github.com/nshen/learn-neovim-lua/issues/1
    --   -- timeoutlen = 1000,
    --   -- split window 从下边和右边出现
    --   splitbelow = true,
    --   splitright = true,
    --   -- 是否显示不可见字符
    --   list = false,
    --   -- 不可见字符的显示,这里只把空格显示为一个点
    --   listchars = "space:·,tab:··",
    --   -- 补全增强
    --   wildmenu = true,
    --   -- Dont' pass messages to |ins-completin menu|
    --   shortmess = vim.o.shortmess .. "c",
    --   -- 补全最多显示10行
    --   pumheight = 10,
    --   -- 配置剪切板
    --   clipboard = "unnamed,unnamedplus",
    --   -- 文件格式为utf-8
    --   fileencoding = "utf-8",
  },
  g = {
    resession_enabled = true,
    --   mapleader = " ",                 -- sets vim.g.mapleader
    --   autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    --   cmp_enabled = true,              -- enable completion at start
    --   autopairs_enabled = true,        -- enable autopairs at start
    --   diagnostics_mode = 3,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    --   icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    --   ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    --   -- jayce
    --   encoding = "utf-8",
    --   -- 自动补全不自动选中
    --   completeopt = "menu,menuone,noselect,noinsert",
  },
  wo = {
    spell = false,
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
-- end
-- end
