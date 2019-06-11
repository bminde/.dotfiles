set -o vi
export EDITOR=vim
export VISUAL=vim

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# Aliases
alias c='clear'
alias ..='cd ..'

alias vimin='vim -u ~/.vim/vimrc_minimal -N'

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

alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit --all"

# https://rehn.me/posts/using-vim-as-a-note-taking-app.html
alias note="vim '+normal G' /Users/bjarte/Library/Mobile\ Documents/com~apple~CloudDocs/notes.md"
alias notes="vim '+normal G' /Users/bjarte/Library/Mobile\ Documents/com~apple~CloudDocs/notes.md"
alias t='cd ~/Dropbox/tekst;vim +FZF'
alias cl='cd ~/Dropbox/changelog;vim +FZF'

alias be='bundle exec'

alias b='buffalo'

alias r='ruby --version'
alias p='python --version'

# homebrew
alias bubu="brew update && brew upgrade"

alias reload="source ~/.zshrc"
alias relaod="source ~/.zshrc"

# history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%{%F{blue}%9c%}%{%F{green}%}$(parse_git_branch)%{%F{none}%} $ '

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

# For Python
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
