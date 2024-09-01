# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="neo"

# Key bindings emacs
# Ctrl + f: accept completion
# Ctrl + a: move to begin of line
# Ctrl + e: move to end of line
# Ctrl + u: delete all
# Ctrl + w: delete single word
# Ctrl + p: previous command in history
# Ctrl + n: next command in history
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Disable automatic updates
zstyle ':omz:update' mode disabled

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

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
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

# History
HISTSIZE=16192
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
unsetopt pathdirs

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Alias for python
alias python="python3"
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
alias gk='gitk --all'

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

# Alias for mysql
alias mysql-status='sudo systemctl status mysql.service'
alias mysql-start='sudo systemctl start mysql.service'
alias mysql-stop='sudo systemctl stop mysql.service'
alias mysql-enable='sudo systemctl enable mysql.service'
alias mysql-disable='sudo systemctl disable mysql.service'
alias mysql-wb='mysql-workbench'

# Alias for mongodb
alias mongodb-status='sudo systemctl status mongod.service'
alias mongodb-start='sudo systemctl start mongod.service'
alias mongodb-stop='sudo systemctl stop mongod.service'
alias mongodb-enable='sudo systemctl enable mongod.service'
alias mongodb-disable='sudo systemctl disable mongod.service'
alias mongodb-cp='mongodb-compass'
alias mongodb-sh='mongosh'

# Alias for tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tp='tmuxp'

# Alias for cli
alias c='clear'
alias e='exit'
alias p='nvim ~/.zshrc'
alias sp='. ~/.zshrc'
alias nv='nvim'

# Alias for ansible
alias a='ansible'
alias acf='ansible-config'
alias acs='ansible-console'
alias adc='ansible-doc'
alias agx='ansible-galaxy'
alias ait='ansible-inventory'
alias apb='ansible-playbook'
alias apl='ansible-pull'

# Alias for cloudflare warp-cli
alias warp-con='warp-cli connect'
alias warp-dis='warp-cli disconnect'

# Modern command line tools
alias l='eza --long --classify --color auto --color-scale size --color-scale-mode gradient --icons --sort name --group --time modified --no-git --time-style "+%Y-%m-%d %H:%M"'
alias ld='l --only-dirs'
alias lf='l --only-files'
alias la='l --all'
alias lad='la --only-dirs'
alias laf='la --only-files'
alias lzg='lazygit'
alias lzd='lazydocker'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION || ! $(command -v nvim) ]]; then
	export EDITOR='vi'
else
	export EDITOR='nvim'
fi

export ANDROID_HOME=~/Android/Sdk
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

export PATH=/usr/local/go/bin:~/go/bin:/usr/local/lua/lua/bin:~/.local/share/coursier/bin:/usr/local/lua/luarocks/prod/bin:/usr/local/ffmpeg:~/.dotnet/tools:~/.local/bin:~/.local/share/nvim/mason/bin:/usr/local/nvim-linux64/bin:/usr/local/apache-maven/bin:/usr/local/gradle/bin:/usr/local/yazi:/usr/local/gh-cli/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:${PATH}:$JAVA_HOME/bin
export MANPATH=${MANPATH}:/usr/local/man
export FPATH=${FPATH}:~/.zfunc

export TMUXP_CONFIGDIR="~/.tmux/tmuxp"

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

if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi

if [ -f ~/.fzf.zsh ]; then
	source ~/.fzf.zsh
fi

# Completion for pipx
if command -v pipx &>/dev/null; then
	eval "$(register-python-argcomplete pipx)"
fi

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
