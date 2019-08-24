# Settings

export VISUAL=vim
export EDITOR="$VISUAL"

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

# Aliases
alias c='clear'
alias ..='cd ..'

alias vimin='vim -u ~/.vim/vimrc_minimal -N --noplugin +"runtime plugin/netrwPlugin.vim" +"runtime plugin/matchparen.vim"'

alias gs='git status'
alias gss='git status -s'

alias tmux='tmux -u'
alias ts='tmux new-session -s'
alias tns='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias tad='tmux attach-session -dt' # detach elsewhere
alias tk='tmux kill-session -t'
alias mux='tmuxinator'

alias tree='tree -C'

alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'

# docker
alias dc='docker-compose'
alias dd='docker-compose down'
alias du='docker-compose up -d --build'
alias dr='dd && du'
alias de='docker-compose exec web'
alias dp='docker-compose exec web python manage.py'

alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit --all"

# https://rehn.me/posts/using-vim-as-a-note-taking-app.html
alias note="vim '+normal G' ~/Library/Mobile\ Documents/N39PJFAFEV~com~metaclassy~byword/Documents/notes.md"
alias notes="vim '+normal G' ~/Library/Mobile\ Documents/N39PJFAFEV~com~metaclassy~byword/Documents/notes.md"
alias t='cd ~/Dropbox/tekst;vim +FZF'
alias cl='cd ~/Dropbox/changelog;vim +FZF'

alias be='bundle exec'

alias b='buffalo'

alias r='ruby --version'
alias p='python --version'

# homebrew
alias bubu="brew update && brew upgrade"

# Reload .bashrc
alias reload='. ~/.bash_profile'
alias relaod='. ~/.bash_profile'

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Get week number
alias week='date +%V'

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

# For Python
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
