#! /bin/env bash

SHELL_FILE="$HOME/.bashrc"
CURRENT_SHELL=$(echo $SHELL)

if [[ $CURRENT_SHELL == *zsh* ]]; then
  SHELL_FILE="$HOME/.zshrc"
elif [[ $CURRENT_SHELL == *fish* ]]; then
  SHELL_FILE="$HOME/.config/fish/config.fish"
fi

function install_zsh {
  sudo apt update -y
  sudo apt install zsh -y
  zsh --version
  chsh -s $(which zsh)
}
install_zsh

function install_ohmyzsh {
  if ! command -v zsh &>/dev/null; then
    echo "Zsh is not installed"
    exit 1
  fi

  if [[ $CURRENT_SHELL != *zsh* ]]; then
    echo "Zsh is not configured as the default shell"
    exit 1
  fi

  ZSH_CUSTOM="$HOME/.oh-my-zsh"

  if [ -d $ZSH_CUSTOM ]; then
    echo "Oh My Zsh is already installed"
    return
  fi

  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  cd $ZSH_CUSTOM/themes/
  curl -LO https://raw.githubusercontent.com/migoa/neo/main/neo.zsh-theme
}
install_ohmyzsh

function install_eza {
  sudo apt update -y
  sudo apt install -y gpg
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
}
install_eza

function install_bat {
  sudo apt install bat -y
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
}
install_bat

function install_zoxide {
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}
install_zoxide

function install_btop {
  cd /tmp
  curl -LO https://github.com/aristocratos/btop/releases/download/v1.3.2/btop-x86_64-linux-musl.tbz
  tar -xvjf /tmp/btop-x86_64-linux-musl.tbz
  cd /tmp/btop
  sudo make install PREFIX=/usr/local
}
install_btop

function install_htop {
  sudo apt install htop -y
}
install_htop

function install_tmux {
  sudo apt install tmux -y
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_fzf {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}
install_fzf

function install_fd {
  sudo apt install fd-find -y
  ln -s $(which fdfind) ~/.local/bin/fd
}
install_fd

function install_rg {
  cd /tmp
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
  sudo dpkg -i ./ripgrep_14.1.0-1_amd64.deb
}
install_rg

function install_gdu {
  go install github.com/dundee/gdu/v5/cmd/gdu@latest
}
install_gdu

function install_pipx_utils {
  pipx install --include-deps ansible
  pipx inject --include-apps ansible argcomplete
  pipx install tldr
  pipx install tmuxp
  pipx install ranger-fm
}
install_pipx_utils

function install_lazygit {
  go install github.com/jesseduffield/lazygit@latest
}
install_lazygit

function install_lazydocker {
  go install github.com/jesseduffield/lazydocker@latest
}
install_lazydocker

function install_nvim {
  cd /tmp
  curl -LO https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
  sudo tar -C /usr/local -xzvf /tmp/nvim-linux64.tar.gz
}
install_nvim
