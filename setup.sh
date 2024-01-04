#!/bin/bash

# Install Git, curl, and moc
sudo apt update
sudo apt install -y git curl moc gh

git config --global user.name "caesar003"
git config --global user.email "caesarmuksid@gmail.com"

# Install additional packages
sudo apt install -y ripgrep nodejs python3 tmux kitty
# Update package list and install essential build tools
sudo apt update
sudo apt install -y build-essential gettext


# Checkout to branch 0.9.5
git checkout tags/v0.9.5

# Install dependencies for building neovim
sudo apt install -y libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Build and install neovim


# Clone tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/caesar003/tmux-config.git ~/.config/tmux

# Clone neovim configurations
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone https://github.com/caesar003/astro-nvim-config ~/.config/nvim/lua/user
git clone https://github.com/caesar003/kitty.conf.git ~/.config/kitty

# Install Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

# Clone neovim from its official repository
git clone https://github.com/neovim/neovim.git

# Navigate into the neovim directory
cd neovim

make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Installation completed successfully!"
