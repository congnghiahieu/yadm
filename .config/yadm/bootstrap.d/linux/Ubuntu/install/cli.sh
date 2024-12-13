#! /bin/env bash

SHELL_FILE="$HOME/.bashrc"
CURRENT_SHELL=$(echo $SHELL)

if [[ $CURRENT_SHELL == *zsh* ]]; then
	SHELL_FILE="$HOME/.zshrc"
elif [[ $CURRENT_SHELL == *fish* ]]; then
	SHELL_FILE="$HOME/.config/fish/config.fish"
fi

function install_ibusbamboo {
	sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
	sudo apt-get update -y
	sudo apt-get install ibus ibus-bamboo --install-recommends -y
	ibus restart
	# Đặt ibus-bamboo làm bộ gõ mặc định
	env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
}
install_ibusbamboo

function install_yadm {
	sudo apt update -y
	sudo apt install yadm -y
}
install_yadm

function install_docker {
	# Uninstall all conflicting packages
	for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

	# Add Docker's official GPG key:
	sudo apt-get update -y
	sudo apt-get install ca-certificates curl -y
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
		sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
	sudo apt-get update -y

	# Install docker
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	sudo groupadd docker
	sudo usermod -aG docker $USER
}
install_docker

function install_zsh {
	sudo apt update -y
	sudo apt install zsh -y
	zsh --version
	chsh -s $(which zsh)
}
install_zsh

function install_wezterm {
	curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	sudo apt update -y
	sudo apt install wezterm -y
}
install_wezterm

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
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
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
install_tmux

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

function install_warp {
	curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
	sudo apt-get update -y && sudo apt-get install cloudflare-warp -y
}
install_warp
