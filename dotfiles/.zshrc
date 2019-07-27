export TERM="xterm-256color"
export ZSH="/Users/colemar/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Start tmux on startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Aliases
alias dock="killall Dock"
alias gp="git pull"
alias gco="git checkout"
alias gs="git status"
alias grhh="git reset --hard HEAD"
alias gcl="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d" # Removes all local branches that are not in remote
alias gcb="git branch | grep -v 'master' | xargs git branch -D" # Removes all local branches that are not "master"
alias gpnv="git push --no-verify"
alias emacs="emacs -nw"
alias yrms="yarn run monorepo:start:remote"
alias slack="weechat"
alias twitter="rainbowstream"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Auto-run `nvm use` when you cd into a directory that has an .nvmrc file
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

