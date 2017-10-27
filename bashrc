# Settings

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Better arrow up/down history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'
# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

shopt -s histappend   # append history to ~\.bash_history when exiting shell

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Bookmarks - l g s d
source ~/.local/bin/bashmarks.sh

# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

# Aliases
alias c='clear'
alias ..='cd ..'

alias t='tmux'
alias tmux='TERM=screen-256color-bce tmux'
alias ts='tmux new-session -s'
alias tns='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias tad='tmux attach-session -dt' # detach elsewhere

alias tree='tree -C'

alias vimin='vim -u ~/.vimin'
alias vimed='vim -u ~/.vimed'
alias vimax='vim -u ~/.vimax -N'

alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'

# Reload .bashrc
alias reload='. ~/.bashrc'

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Get week number
alias week='date +%V'

# Completion
# http://stackoverflow.com/a/15009611/128850
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function ps1_branch {
  b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$b" ]; then echo " $b"; fi
}

black="\[\e[30m\]"
red="\[\e[31m\]"
green="\[\e[32m\]"
yellow="\[\e[33m\]"
blue="\[\e[34m\]"
magenta="\[\e[35m\]"
cyan="\[\e[36m\]"
white="\[\e[37m\]"
reset="\[\e[0m\]"

# export PS1="${yellow}» $blue\W$magenta\$(ps1_branch)\n$yellow\$$reset "
export PS1="${yellow}» $blue\W$green\$(ps1_branch)\n$yellow\$$reset "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"

# Path
export dotfiles="$HOME/.dotfiles"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/node@6/bin:$PATH"
