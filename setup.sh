#!/bin/bash

mv ~/.config/nvim ~/.config/nvim.bak
rm -rf ~/.local/share/nvim
rm -rf mv ~/.local/state/nvim
rm -rf mv ~/.cache/nvim

# clone code
git clone https://github.com/chaozwn/astronvim_with_coc_or_mason ~/.config/nvim

brew install fzf
brew install fd
brew install luarocks
brew install lazygit
brew install ripgrep
npm install -g tree-sitter-cli
brew install gdu
brew install bottom
brew install protobuf
brew install gnu-sed

pip install notebook nbclassic jupyter-console
pip install git+https://github.com/will8211/unimatrix.git
npm install -g neovim
pip install pynvim
pip install terminaltexteffects

brew tap daipeihust/tap
brew install im-select

brew install neovide
brew install lazydocker
brew install mercurial
rustup component add rust-analyzer
