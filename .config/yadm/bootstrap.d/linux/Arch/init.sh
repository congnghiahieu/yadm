#! /bin/env bash

# https://stackoverflow.com/questions/59446321/removing-package-group-except-some-packages

SHELL_FILE="$HOME/.bashrc"
CURRENT_SHELL=$(echo "$SHELL")

if [[ $CURRENT_SHELL == *zsh* ]]; then
	SHELL_FILE="$HOME/.zshrc"
elif [[ $CURRENT_SHELL == *fish* ]]; then
	SHELL_FILE="$HOME/.config/fish/config.fish"
fi

# Required

function setup_git {
	git config --global credential.helper store
	git config --global user.name "congnghiahieu"
	git config --global user.email "2102540@vnu.edu.vn"
}

function install_node {
	if command -v node &> /dev/null; then
		echo "Node $(node --version) is already installed"
	else
		wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
		source "$SHELL_FILE"
		nvm ls-remote --lts
		nvm install --lts
	fi
}

function install_binaries {
	sudo pacman -Syu
	sudo pacman -S flatpak sof-firmware amd-ucode intel-ucode
	sudo pacman -S --needed base-devel

	sudo pacman -S \
		coreutils unrar tar rsync zip unzip gzip \
		git yadm \
		firefox \
		fastfetch htop \
		man-db man-pages tealdeer \
		vim neovim \
		wl-clipboard xclip \
		nmap traceroute net-tools inetutils ufw \
		at cronie
	sudo systemctl enable --now cronie.service

	sudo pacman -S \
		python-pip python-setuptools python-build python-pipx \
		jdk21-openjdk openjdk21-src openjdk21-doc maven gradle \
		dotnet-sdk \
		rustup \
		go
	curl https://pyenv.run | bash
	rustup toolchain install stable
	install_node

	sudo pacman -S \
		git-lfs \
		protobuf

	setup_git
}

function install_apps {
	sudo pacman -S \
		bat fd ripgrep gdu eza zoxide fzf btop \
		tmux zsh starship \
		yazi ffmpeg p7zip jq poppler imagemagick

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	tldr --update

	pipx install --include-deps ansible
	pipx inject --include-apps ansible argcomplete
	pipx install tmuxp
	pipx install hatch
	pipx install poetry

	sudo pacman -S obsidian \
		ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono \
		kde-graphics kde-multimedia kde-network kde-system kde-utilities \
		vlc libreoffice-fresh

	sudo pacm -S docker docker-buildx docker-compose
	sudo systemctl enable docker.service
	sudo systemctl start docker.service
	sudo systemctl enable docker.socket
	sudo systemctl start docker.socket
	sudo groupadd docker
	sudo usermod -aG docker "$USER"

	sudo pacman -S fcitx5-im fcitx5-unikey fcitx5-bamboo fcitx5-breeze kcm-fcitx5

	sudo pacman -S virtualbox
	sudo pacman -S qemu-full libvirt virt-viewer virt-manager
	sudo pacman -S dnsmasq vde2 openbsd-netcat libguestfs
	sudo usermod -aG libvirt "$USER"
	sudo usermod -aG kvm "$USER"
	sudo systemctl enable --now libvirtd.service
	sudo systemctl start libvirtd.service

	paru -S lazygit lazydocker \
		microsoft-edge-stable-bin \
		visual-studio-code-bin \
		cloudflare-warp-bin \
		wezterm-git
	sudo chown -R $(whoami):$(whoami) /opt/visual-studio-code/
	sudo chown $(whoami):$(whoami) /usr/bin/code

	zsh --version
	chsh -s $(which zsh)
}

function install_ohmyzsh {
	if ! command -v zsh &> /dev/null; then
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
	git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
	git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
	cd "$ZSH_CUSTOM/themes/" && curl -LO https://raw.githubusercontent.com/migoa/neo/main/neo.zsh-theme
}

# Optional

function install_deno {
	if command -v deno &> /dev/null; then
		echo "Deno $(deno --version) is already installed"
	else
		curl -fsSL https://deno.land/install.sh | sh
	fi
}

function install_bun {
	if command -v bun &> /dev/null; then
		echo "Bun $(bun --version) is already installed"
	else
		curl -fsSL https://bun.sh/install | bash
	fi
}

function install_scala {
	cd /tmp && curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
}

function install_texlive {
	# sudo pacman -S texlive
	# sudo pacman -S texlive-full

	cd /tmp && wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	TAR_DIR=$(tar -xzvf install-tl-unx.tar.gz | head -n 1 | cut -f1 -d"/")
	cd "$TAR_DIR" && sudo perl ./install-tl --paper=letter --scheme=full --no-doc-install --no-src-install --no-interaction
	sudo chown -R -R $(whoami):$(whoami) /usr/local/texlive/
}
