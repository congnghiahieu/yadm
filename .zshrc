# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TMUXP_CONFIGDIR="~/.tmux/tmuxp"

export ANDROID_HOME=~/Android/Sdk
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

export PATH=$PATH:/usr/local/go/bin:~/go/bin:/usr/local/lua/lua/bin:~/.local/share/coursier/bin:/usr/local/lua/luarocks/prod/bin:/usr/local/ffmpeg:~/.dotnet/tools:~/.local/bin:~/.local/share/nvim/mason/bin:/usr/local/nvim-linux64/bin:/usr/local/apache-maven/bin:/usr/local/gradle/bin:/usr/local/yazi:/usr/local/gh-cli/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$JAVA_HOME/bin:/usr/local/protobuf/bin
export MANPATH=$MANPATH:/usr/local/man
export FPATH=$FPATH:~/.zfunc

# Path for texlive manually dowload
export MANPATH=$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info
export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux

# Path for pacman -S textlive-full
# export MANPATH=$MANPATH:/home/hieucien/.cache/paru/clone/texlive-full/pkg/texlive-full/opt/texlive/2024/texmf-dist/doc/man
# export INFOPATH=$INFOPATH:/home/hieucien/.cache/paru/clone/texlive-full/pkg/texlive-full/opt/texlive/2024/texmf-dist/doc/info
# export PATH=$PATH:/home/hieucien/.cache/paru/clone/texlive-full/pkg/texlive-full/opt/texlive/2024/bin/x86_64-linux

# FZF options
export FZF_COMPLETION_TRIGGER='**'
# export FZF_DEFAULT_COMMAND='fd --hidden --ignore-case --absolute-path --follow --full-path --exclude .git --exclude node_modules --exclude .venv --exclude venv'
export FZF_DEFAULT_COMMAND='fd --hidden --ignore-case --exclude .git --exclude node_modules --exclude .venv --exclude venv . .'
export FZF_DEFAULT_OPTS='--cycle --keep-right --scroll-off 20 --height ~100% --layout reverse --border rounded --border-label-pos top --info inline-right --marker "m"'
# Find files with Ctrl-R
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_CTRL_T_OPTS="--border-label 'Find files' --preview 'bat --color=always --style=numbers --line-range=:1000 {}' --preview-label 'Preview'"
# Change directory with Ctrl-O
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
export FZF_ALT_C_OPTS="--border-label 'Change directory' --preview 'ls -la {}' --preview-label 'Preview'"
# Search history with Ctrl-H
export FZF_CTRL_R_OPTS="--border-label 'History search'"

# NVM - node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pyenv set up
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  ZSH_THEME="neo"
fi

# Key bindings emacs
# Ctrl + f: accept completion
# Ctrl + a: move to begin of line
# Ctrl + e: move to end of line
# Ctrl + u: delete all
# Ctrl + w: delete single word
# Ctrl + p: previous command in history
# Ctrl + n: next command in history
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Disable automatic updates
zstyle ':omz:update' mode disabled

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files under VCS as dirty. This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)

# History
HISTSIZE=64768
HISTFILE=~/.zsh_history
HISTDUP=erase
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Alias for python
alias pav='source ./venv/bin/activate'
alias pcv='python3 -m venv venv'
alias pdv='deactivate'
alias pfr='pip freeze > requirements.txt'
alias pir='pip install -r requirements.txt'
alias pur='pip uninstall -r requirements.txt -y'

# Alias for git
alias gst='git status'
alias gbl='git blame'
alias gl='git log --color --decorate --all'
alias glo='gl --oneline'
alias glg='gl --graph'
alias glgo='gl --graph --oneline'
alias ga='git add'
alias gcm='git commit'
alias gsh='git show'
alias gd='git diff'
alias gb='git branch'
alias gck='git checkout'
alias gsw='git switch'
alias grm='git remote'
alias gpl='git pull'
alias gcl='git clone'
alias gf='git fetch'
alias gps='git push'
alias gt='git tag'
alias grt='git restore'
alias grs='git reset'
alias grv='git revert'
alias gm='git merge'
alias grb='git rebase'
alias gcp='git cherry-pick'
alias gsh='git stash'
alias gsq='git squash'
alias grl='git reflog'
alias gsm='git submodule'
alias gcf='git config'

# Alias for docker
alias db='docker build'
alias dc='docker container'
alias dcp='docker compose'
alias di='docker image'
alias dn='docker network'
alias dpl='docker pull'
alias dps='docker push'
alias dst='docker system'
alias dt='docker tag'
alias dv='docker volume'
alias docker-status='sudo systemctl status docker'
alias docker-start='sudo systemctl start docker'
alias docker-stop='sudo systemctl stop docker && sudo systemctl stop docker.socket'
alias docker-enable='sudo systemctl enable docker'
alias docker-disable='sudo systemctl disable docker'

# Alias for tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tp='tmuxp'

# Alias for cli
alias nv='nvim'
alias vi='vim'
if command -v nvim &>/dev/null; then
  alias profile='nvim ~/.zshrc'
else
  alias profile='vi ~/.zshrc'
fi

# Alias for ansible
alias a='ansible'
alias acf='ansible-config'
alias acs='ansible-console'
alias adc='ansible-doc'
alias agx='ansible-galaxy'
alias ait='ansible-inventory'
alias apb='ansible-playbook'
alias apl='ansible-pull'

# Modern CLI tools
alias l='eza --long --classify --color auto --color-scale size --color-scale-mode gradient --icons --sort name --group --time modified --no-git --time-style "+%Y-%m-%d %H:%M"'
alias ld='l --only-dirs'
alias lf='l --only-files'
alias la='l --all'
alias lad='la --only-dirs'
alias laf='la --only-files'
alias lzg='lazygit'
alias lzd='lazydocker'

# Deno
if [ -d "$HOME/.deno" ]; then
  source "/home/hieucien/.deno/env"
fi

# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/hieucien/completions:"* ]]; then
  export FPATH="/home/hieucien/completions:$FPATH";
fi

# Add zoxide
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi

# Add fzf
if [ -f ~/.fzf.zsh ]; then
	source ~/.fzf.zsh
fi

# Completion for pipx
if command -v pipx &>/dev/null; then
	eval "$(register-python-argcomplete pipx)"
fi

# Default editor
if command -v nvim &>/dev/null; then
	export EDITOR='nvim'
else
	export EDITOR='vi'
fi

# Setting for zsh-vim-mode
if command -v nvim &>/dev/null; then
	export ZVM_VI_EDITOR='nvim'
else
  export ZVM_VI_EDITOR='vi'
fi
export ZVM_VI_SURROUND_BINDKEY='classic'

# Setting Man pager instead of less
if command -v nvim &>/dev/null; then
  export MANPAGER='nvim +Man!'
else
  export MANPAGER='vi +Man!'
fi

# Sudo editor
export SUDO_EDITOR='vi'

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Completion for ansible
if command -v ansible &>/dev/null; then
	eval $(register-python-argcomplete ansible)
	eval $(register-python-argcomplete ansible-config)
	eval $(register-python-argcomplete ansible-console)
	eval $(register-python-argcomplete ansible-doc)
	eval $(register-python-argcomplete ansible-galaxy)
	eval $(register-python-argcomplete ansible-inventory)
	eval $(register-python-argcomplete ansible-playbook)
	eval $(register-python-argcomplete ansible-pull)
	eval $(register-python-argcomplete ansible-vault)
fi
