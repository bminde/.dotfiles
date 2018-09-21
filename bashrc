# Settings

# Use vi mode
set -o vi

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

# Aliases
alias c='clear'
alias ..='cd ..'

alias gs='git status'
alias gss='git status -s'

alias tmux='tmux -u'
alias t='tmux'
alias ts='tmux new-session -s'
alias tns='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias tad='tmux attach-session -dt' # detach elsewhere

alias tree='tree -C'

alias vime='vim -u ~/.vime -N --noplugin'
alias vimin='vim -u ~/.vimin -N --noplugin'
alias vimed='vim -u ~/.vimed -N --noplugin'
alias vimax='vim -u ~/.vimax -N --noplugin +"runtime plugin/netrwPlugin.vim"'
alias vi='vim -u ~/.vimax -N --noplugin +"runtime plugin/netrwPlugin.vim"'

alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'

alias note='jrnl'

alias be="bundle exec"

alias r='ruby --version'
alias p='python --version'

# homebrew
alias bubu="brew update && brew upgrade"

# Reload .bashrc
alias reload='. ~/.bash_profile'

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Get week number
alias week='date +%V'

# Completion
# http://stackoverflow.com/a/15009611/128850
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# cd to current Finder path
function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}
function cdf() {
  cd "$(pfd)"
}

function ps1_branch {
  b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$b" ]; then echo " ($b)"; fi
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
export PS1="${yellow}$blue\W$green\$(ps1_branch) $reset\$ "

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

source ~/.local/bin/bashmarks.sh

export PATH=~/.local/bin:$PATH

export PATH="/Applications/Postgres.app/Contents/Versions/9.6/bin:$PATH"

# Go environment
export GOPATH="$HOME/go"
# Expose the Go binaries in the PATH
export PATH="$GOPATH/bin:$PATH"

# swiftenv
# export SWIFTENV_ROOT="$HOME/.swiftenv"
# export PATH="$SWIFTENV_ROOT/bin:$PATH"
# eval "$(swiftenv init -)"

# chruby with auto switching
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# For Python
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export PATH="/usr/local/opt/node@6/bin:$PATH"
