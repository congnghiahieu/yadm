#! /bin/env bash

SHELL_FILE="$HOME/.bashrc"
CURRENT_SHELL=$(echo $SHELL)

if [[ $CURRENT_SHELL == *zsh* ]]; then
	SHELL_FILE="$HOME/.zshrc"
elif [[ $CURRENT_SHELL == *fish* ]]; then
	SHELL_FILE="$HOME/.config/fish/config.fish"
fi

# Required

function install_essentials {
	sudo apt update -y
	sudo apt install coreutils build-essential
	\ curl wget git unzip vim at
	\ wl-clipboard xclip
	\ nmap net-tools traceroute -y
}
install_essentials

function install_python {
	sudo apt update -y
	sudo apt install python3 python3-pip python3-venv -y

	if command -v pipx &> /dev/null; then
		echo "Pipx is already installed"
	else
		sudo apt update -y
		sudo apt install pipx -y
		pipx ensurepath
	fi
}
install_python

function install_node {
	sudo apt update -y
	if command -v node &> /dev/null; then
		echo "Node $(node --version) is already installed"
	else
		wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
		source $SHELL_FILE
		nvm ls-remote --lts
		nvm install --lts
	fi
}
install_node

function install_dotnet {
	sudo apt remove dotnet* aspnetcore* netstandard* -y
	sudo mkdir -p /etc/apt/preferences.d
	sudo tee /etc/apt/preferences.d/99microsoft-dotnet > /dev/null << EOF
Package: *
Pin: origin "microsoft.com"
Pin-Priority: 1001
EOF

	sudo apt-get update -y
	sudo apt install ca-certificates libc6 libgcc-s1 libicu74 liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g -y
	sudo apt-get install dotnet-sdk-8.0 -y
}
install_dotnet

function install_java {
	sudo apt update -y
	sudo apt install openjdk-21-jdk openjdk-21-jre openjdk-21-dbg openjdk-21-doc openjdk-21-source openjdk-21-testsupport -y
	# echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))' >>$SHELL_FILE
}
install_java

function install_maven {
	cd /tmp
	curl -LO https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
	sudo tar -C /usr/local/ -xzvf apache-maven-3.9.9-bin.tar.gz
	sudo mv /usr/local/apache-maven-3.9.9 /usr/local/apache-maven

	# sudo apt update -y
	# sudo apt install maven -y
}
install_maven

function install_gradle {
	cd /tmp
	curl -LO https://services.gradle.org/distributions/gradle-8.11.1-bin.zip
	sudo unzip gradle-8.11.1-bin.zip -d /usr/local/
	sudo mv /usr/local/gradle-8.11.1 /usr/local/gradle

	# sudo apt update -y
	# sudo apt install gradle -y
}
install_gradle

function install_go {
	if command -v go &> /dev/null; then
		echo "Go $(go version) is already installed"
		return
	fi

	sudo apt update -y
	cd /tmp
	curl -LO https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xvzf go1.23.0.linux-amd64.tar.gz
	echo 'export PATH=$PATH:/usr/local/go/bin' >> $SHELL_FILE
	source $SHELL_FILE
	go version
}
install_go

function install_rust {
	if command -v cargo &> /dev/null; then
		echo "Rust $(cargo --version) is already installed"
		return
	fi

	sudo apt update -y
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $SHELL_FILE
	rustup update
}
install_rust

# Optional

function install_scala {
	cd /tmp
	curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup
}

function install_deno {
	sudo apt update -y
	if command -v deno &> /dev/null; then
		echo "Deno $(deno --version) is already installed"
	else
		curl -fsSL https://deno.land/install.sh | sh
	fi
}
