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
sudo apt install -y ripgrep  python3 tmux kitty build-essential gettext xclip python3-pip
# Update package list and install essential build tools

sudo pip3 install pynvim --break-system-packages

sudo npm install -g neovim

cd ~
# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit*.gz

# Gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
sudo mv gdu_linux_amd64 /usr/bin/gdu


# Bottom
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_0.9.6_amd64.deb
sudo dpkg -i bottom_0.9.6_amd64.deb
rm bottom*.deb

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

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.11/config-3.11-x86_64-linux-gnu/ \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-cscope \
            --enable-gtk2-check \
            --with-x \
            --with-compiledby="caesar003" \
            --prefix=$PREFIX

make VMRUNTIMEDIR=/usr/share/vim/vim9
sudo make install

echo "Installation completed successfully!"



