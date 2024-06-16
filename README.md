# AstroNvim Template

<!--toc:start-->

- [AstroNvim Template](#astronvim-template)
    - [Support neovim version](#support-neovim-version)
    - [Features](#features)
    - [workflow screenshot](#workflow-screenshot)
    - [other components config](#other-components-config)
    - [🛠️ Installation](#🛠️-installation)
        - [The system should supports commands](#the-system-should-supports-commands)
        - [Recommend install](#recommend-install)
        - [Make a backup of your current nvim and shared folder](#make-a-backup-of-your-current-nvim-and-shared-folder)
        - [Create a new user repository from this template](#create-a-new-user-repository-from-this-template)
        - [Clone the repository](#clone-the-repository)
        - [Start Neovim](#start-neovim)
    - [Tips](#tips)
        - [Use Lazygit](#use-lazygit)
        - [Install unimatrix](#install-unimatrix)
        - [Neovim requirements](#neovim-requirements)
        - [Markdown Image Paste](#markdown-image-paste)
        - [Input Auto Switch](#input-auto-switch)
        - [Support styled-components](#support-styled-components)
        - [Support for neovide](#support-for-neovide)
        - [Support Lazydocker](#support-lazydocker)
    - [General Mappings](#general-mappings)
    - [NOTE](#note) - [_vim.lsp.buf.hover()_ `KK` jump into signature help float window](#vimlspbufhover-kk-jump-into-signature-help-float-window)
  <!--toc:end-->

**NOTE:** This is the latest v4 configuration; everyone can use it with confidence.

In the course of my daily tasks, I have optimized my workflow by integrating several powerful tools. My terminal of choice is `WezTerm`, which offers a blend of performance and features that cater to my needs. Alongside this, I employ `tmux` to efficiently manage multiple terminal sessions within a single window.

Additionally, I utilize `yazi` as my terminal-based file manager, which seamlessly fits into my terminal-centric workflow. It is also worth noting that my configuration is compatible with `neovide`, eliminating the necessity for additional setups.

This streamlined combination of tools significantly enhances my productivity and provides a robust terminal experience.

## Support neovim version

neovim >= `0.10`, recommend `0.10`

## Features

now,this config supports development in `TypeScript`,`Python`,`Go`, `Rust` and `markdown`.

- **_`Typescript`_**: `typescript-tools.nvim`
- **_`Python`_**: `pylance`
- **_`Go`_**: `go.nvim` _-- support go zero framework_
- **_`Markdown`_**: `iamcco/markdown-preview.nvim`,
- **_`Rust`_**: `mrcjkb/rustaceanvim`

## workflow screenshot

`wezterm` + `tmux` + `astronvim`

![homepage](assets/homepage.png)

`wezterm`

![homepage](assets/wezterm.png)

`tmux`

![homepage](assets/tmux.png)

`yazi`

![homepage](assets/yazi.png)

## other components config

`wezterm`: [https://github.com/chaozwn/wezterm]('https://github.com/chaozwn/wezterm')

`tmux`: [https://github.com/chaozwn/tmux]("https://github.com/chaozwn/tmux")

`yazi`: [https://github.com/chaozwn/yazi]("https://github.com/chaozwn/yazi")

## 🛠️ Installation

### The system should supports commands

`npm`,`rustc`,`go`,`tmux` -- if you want to use `tmux-awesome-manager`

### Recommend install

```shell
brew install fzf
brew install luarocks
brew install lazygit
brew install ripgrep
npm install -g tree-sitter-cli
brew install gdu
brew install bottom
brew install protobuf
```

### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

### Clone the repository

```shell
git clone https://github.com/chaozwn/astronvim_with_coc_or_mason ~/.config/nvim
```

### Start Neovim

```shell
nvim
```

## Tips

### Use Lazygit

`<leader>tl`

### Install unimatrix

`<Leader>tm`

```shell
pip install git+https://github.com/will8211/unimatrix.git
```

![unimatrix](assets/unimatrix.png)

### Install TTE

`<Leader>te`

```shell
pip install terminaltexteffects
```

![](./assets/imgs/tte.png)
### Neovim requirements

```
npm install -g neovim
pip install pynvim
```

### Markdown Image Paste

```shell
pip install pillow
```

### Input Auto Switch

```shell
brew tap daipeihust/tap
brew install im-select
im-select
```

run `im-select` & copy result to `im-select.lua`

```lua
-- update your self input method here
Mac.zhCN = "im.rime.inputmethod.Squirrel.Hans" -- there
Mac.en =  "com.apple.keylayout.ABC"
```

### Support styled-components

```shell
npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
```

### Support for neovide

```
brew install neovide
neovide .
```

### Support Lazydocker

tigger command: `<leader>td`

```shell
brew install lazydocker
```

## General Mappings

| Action                      | Mappings            |
| --------------------------- | ------------------- |
| Leader key                  | `Space`             |
| Resize up                   | `Ctrl + Up`         |
| Resize Down                 | `Ctrl + Down`       |
| Resize Left                 | `Ctrl + Left`       |
| Resize Right                | `Ctrl + Right`      |
| Up Window                   | `Ctrl + k`          |
| Down Window                 | `Ctrl + j`          |
| Left Window                 | `Ctrl + h`          |
| Right Window                | `Ctrl + l`          |
| Force Write                 | `Ctrl + s`          |
| Force Quit                  | `Ctrl + q`          |
| New File                    | `Leader + n`        |
| Close Buffer                | `Leader + c`        |
| Next Tab (real vim tab)     | `]t`                |
| Previous Tab (real vim tab) | `[t`                |
| Comment                     | `Leader + /`        |
| Horizontal Split            | `\`                 |
| Vertical Split              | <code>&#124;</code> |

## NOTE

### _vim.lsp.buf.hover()_ `KK` jump into signature help float window

> Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window.
