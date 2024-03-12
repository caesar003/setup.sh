#!/bin/bash

# Install Git, curl, and moc
sudo apt update

sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install nodejs -y

sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl moc gh

git config --global user.name "caesar003"
git config --global user.email "caesarmuksid@gmail.com"

# Install additional packages
sudo apt install -y ripgrep  python3 tmux kitty build-essential gettext
# Update package list and install essential build tools

sudo apt-get build-dep vim

# Install dependencies for building neovim
sudo apt install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

mkdir -p ~/.vim/init

# Clone tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/caesar003/tmux-config.git ~/.config/tmux

# Clone neovim configurations
# git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# git clone https://github.com/caesar003/astro-nvim-config ~/.config/nvim/lua/user
git clone https://github.com/caesar003/kitty.conf.git ~/.config/kitty
git clone https://github.com/caesar003/vimrc ~/.vim/init

# Install Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

# Clone neovim from its official repository
git clone https://github.com/neovim/neovim.git ~/neovim-repo

# Navigate into the neovim directory
cd ~/neovim-repo

# Checkout to branch 0.9.5
git checkout v0.9.5

# Build and install neovim
make CMAKE_BUILD_TYPE=Release
sudo make install


git clone https://github.com/vim/vim ~/vim-repo

cd ~/vim-repo

./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
  --enable-python3interp --with-python-config-dir=/usr/lib/python3.9/config-3.9-x86_64-linux-gnu \
  --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope \
  --prefix=/usr

make VMRUNTIMEDIR=/usr/share/vim/vim9
sudo make install

echo "Installation completed successfully!"



