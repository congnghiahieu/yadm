# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

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
alias c='clear'
alias e='exit'
alias p='nvim ~/.bashrc'
alias sp='. ~/.bashrc'
alias nv='nvim'

# Modern CLI tools
alias l='eza --long --classify --color auto --color-scale size --color-scale-mode gradient --icons --sort name --group --time modified --no-git --time-style "+%Y-%m-%d %H:%M"'
alias ld='l --only-dirs'
alias lf='l --only-files'
alias la='l --all'
alias lad='la --only-dirs'
alias laf='la --only-files'
alias lzg='lazygit'
alias lzd='lazydocker'
