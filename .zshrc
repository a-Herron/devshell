export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

ZSH_THEME="avit"

plugins=(git fzf)

source $ZSH/oh-my-zsh.sh

set -o vi

source <(fzf --zsh)

alias g="git"

alias tmux="tmux -f $HOME/.config/devshell/tmux/tmux.conf -L devshell"
