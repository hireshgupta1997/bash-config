
# Git Alias
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --staged'
alias gc='git commit'
alias gcm='git commit -m '
alias grh='git reset HEAD'
alias gf='git fetch'
alias gremote='git remote'
alias grebase='git rebase'
alias gclone='git clone'
alias gclean='git reset --hard && git clean -d -f -x'

# Docker Commands
alias dps='docker ps'
alias dr='docker run'
alias dkill='docker kill'
alias drm='docker rm'

# Tmux Commands
alias tmxls='tmux list-session'
alias tmxas='tmux attach'
alias tmxns='tmux new -s'

# Maven Commands
alias mci='mvn clean install'
alias mc='mvn clean'

# Custom Helper Commands
alias catc='pygmentize -g'

# Source .bashrc
source ~/.bashrc

# Helper Methods
parse_git_branch(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set Term Colors
export TERM=xterm-256color
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35;1m\]\$(parse_git_branch)\[\033[m\]\n\$ "

# Set ls colors
export LS_COLORS=$LS_COLORS:"di=1;90:fi=96:ex=1;32"
export PATH=$PATH:~/bin
