# AstroNvim User Configuration Example

A user configuration template for [AstroNvim](https://github.com/AstroNvim/AstroNvim)

now this config can support `Coc` or `Mason`, you can modify in `options.lua`

```
vim.g.lsp_type = "coc" -- use coc as lsp server
vim.g.lsp_type = "lsp" -- use mason as lsp server
```
if you use coc.nvim, please run
```shell
ln -s ~/.config/nvim/lua/user/coc-settings.json ~/.config/nvim
```

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clone AstroNvim

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim/lua/user
```

#### Start Neovim

```shell
nvim
```
