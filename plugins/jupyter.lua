-- Basic jukit options
-- NOTE: debug :lua print(vim.inspect(vim.api.nvim_get_var("jukit")))
vim.g.jukit_mappings = 0
vim.g.jukit_shell_cmd = "/Users/mac/miniconda3/envs/python38/bin/ipython3"
-- Specifies the command used to start a shell in the output split. Can also be an absolute path. Can also be any other shell command, e.g. `R`, `julia`, etc. (note that output saving is only possible for ipython)
vim.g.jukit_terminal = "tmux"
-- Terminal to use. Can be one of '', 'kitty', 'vimterm', 'nvimterm' or 'tmux'. If '' is given then will try to detect terminal (though this might fail, in which case it simply defaults to 'vimterm' or 'nvimterm' - depending on the output of `has("nvim")`)
vim.g.jukit_auto_output_hist = 1
-- If set to 1, will create an autocmd with event `CursorHold` to show saved ipython output of current cell in output-history split. Might slow down (n)vim significantly, you can use `set updatetime=<number of milliseconds>` to control the time to wait until CursorHold events are triggered, which might improve performance if set to a higher number (e.g. `set updatetime=1000`).
vim.g.jukit_use_tcomment = 0
-- Whether to use tcomment plugin (https://github.com/tomtom/tcomment_vim) to comment out cell markers. If not, then cell markers will simply be prepended with `g:jukit_comment_mark`
vim.g.jukit_comment_mark = "#"
-- See description of `g:jukit_use_tcomment` above vim.g.jukit_mappings = 1
-- If set to 0, none of the default function mappings (as specified further down) will be applied
vim.g.jukit_mappings_ext_enabled = "*"
-- String or list of strings specifying extensions for which the mappings will be created. For example, `let g:jukit_mappings_ext_enabled=['py', 'ipynb']` will enable the mappings only in `.py` and `.ipynb` files. Use `let g:jukit_mappings_ext_enabled='*'` to enable them for all files.
vim.g.jukit_notebook_viewer = "jupyter-notebook"
-- Command to open .ipynb files, by default jupyter-notebook is used. To use e.g. vs code instead, you could set this to `let g:jukit_notebook_viewer = 'code'`
vim.g.jukit_convert_overwrite_default = -1
-- Default setting when converting from .ipynb to .py or vice versa and a file of the same name already exists. Can be of [-1, 0, 1], where -1 means no default (i.e. you'll be prompted to specify what to do), 0 means never overwrite, 1 means always overwrite
vim.g.jukit_convert_open_default = -1
-- Default setting for whether the notebook should be opened after converting from .py to .ipynb. Can be of [-1, 0, 1], where -1 means no default (i.e. you'll be prompted to specify what to do), 0 means never open, 1 means always open
vim.g.jukit_file_encodings = "utf-8"
-- Default encoding for reading and writing to files in the python helper functions
vim.g.jukit_venv_in_output_hist = 1
-- Whether to also use the provided terminal command for the output history split when starting the splits using the JukitOUtHist command. If 0, the provided terminal command is only used in the output split, not in the output

-- cell highlighting/syntax
vim.g.jukit_highlight_markers = 1
-- Whether to highlight cell markers or not. You can specify the colors of cell markers by putting e.g. `highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22` with your desired colors in your (neo)vim config. Make sure to define this highlight *after* loading a colorscheme in your (neo)vim config
vim.g.jukit_enable_textcell_bg_hl = 1
-- Whether to highlight background of textcells. You can specify the color by putting `highlight jukit_textcell_bg_colors guibg=#131628 ctermbg=0` with your desired colors in your (neo)vim config. Make sure to define this highlight group *after* loading a colorscheme in your (neo)vim config.
vim.g.jukit_enable_textcell_syntax = 1
-- Whether to enable markdown syntax highlighting in textcells
vim.g.jukit_text_syntax_file = vim.fn.expand "$VIMRUNTIME" .. "/syntax/markdown.vim"
-- Syntax file to use for textcells. If you want to define your own syntax matches inside of text cells, make sure to include `containedin=textcell`.
vim.g.jukit_hl_ext_enabled = "*"
-- String or list of strings specifying extensions for which the relevant highlighting autocmds regarding marker-highlighting, textcell-highlighting, etc. will be created. For example, `let g:jukit_hl_extensions=['py', 'R']` will enable the defined highlighting options for `.py` and `.R` files. Use `let g:jukit_hl_extensions='*'` to enable them for all files and `let g:jukit_hl_extensions=''` to disable them completely

-- Ipython
vim.g.jukit_in_style = 2
-- Number between 0 and 4. Defines how the input-code should be represented in the IPython shell. One of 5 different styles can be chosen, where style 0 is the default IPython style for the IPython-`%paste` command
vim.g.jukit_max_size = 20
-- Max Size of json containing saved output in MiB. When the output history json gets too large, certain jukit operations can get slow, thus a max size is specified. Once the max size is reached, you'll be asked to delete some of the saved outputs (using e.g. jukit#cells#delete_outputs - see function explanation further down) before further output can be saved.
vim.g.jukit_show_prompt = 0
-- Whether to show (1) or hide (0) the previous ipython prompt after code is sent to the ipython shell

-- IF AN IPYTHON SHELL COMMAND IS USED:
vim.g.jukit_save_output = 1
-- Whether to save ipython output or not. This is the default value if an ipython shell command is used.

vim.g.jukit_clean_outhist_freq = 60 * 10
-- Frequency in seconds with which to delete saved ipython output (including cached überzug images) of cells which are not present anymore. (After executing a cell of a buffer for the first time in a session, a CursorHold autocmd is created for this buffer which checks whether the last time obsolete output got deleted was more than `g:jukit_clean_outhist_freq` seconds ago, and if so, deletes all saved output of cells which are not present in the buffer anymore from the output-history-json)

-- Matplotlib
vim.g.jukit_savefig_dpi = 150
-- Value for `dpi` argument for matplotlibs `savefig` function
vim.g.jukit_mpl_block = 1
-- If set to 0, then `plt.show()` will by default be executed as if `plt.show(block=False)` was specified
vim.g.jukit_custom_backend = -1
-- Custom matplotlib backend to use

-- IF KITTY OR TMUX IS USED:
vim.g.jukit_inline_plotting = 0
-- Enable in-terminal-plotting. Only supported for kitty or tmux+iTerm2 -> BE SURE TO SPECIFY THE TERMINAL VIA `g:jukit_terminal`! (see variables in section 'Basic jukit options')

-- split window
vim.g.jukit_layout = {
  split = "horizontal",
  p1 = 0.6,
  val = {
    "file_content",
    {
      split = "vertical",
      p1 = 0.6,
      val = { "output", "output_history" },
    },
  },
}

vim.g.jukit_hist_use_ueberzug = 0
vim.g.jukit_ueberzug_use_cached = 1
vim.g.jukit_kill_ueberzug_on_focus_lost = 1

vim.g.jukit_ueberzug_theme = "dark"
vim.g.jukit_ueberzug_term_hw_ratio = -1
vim.g.jukit_ueberzug_python_cmd = "python3"
vim.g.jukit_ueberzug_jupyter_cmd = "jupyter"
vim.g.jukit_ueberzug_cutycapt_cmd = "cutycapt"
vim.g.jukit_ueberzug_imagemagick_cmd = "convert"

return {
  "luk400/vim-jukit",
  config = function() end,
  event = "UIEnter",
}
