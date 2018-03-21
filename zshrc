# Path to your oh-my-zsh installation.
export ZSH=/Users/bjarte/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vim zshmarks zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=default"

# chruby with auto switching
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# User configuration

# vi mode
bindkey -v

# history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down


# Path
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/node@6/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# ymse
alias c="clear"
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

alias vimin='vim -u ~/.vimin'
alias vimed='vim -u ~/.vimed'
alias vimax='vim -u ~/.vimax -N'

# vim
alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -la'

alias note='jrnl'

# ruby
alias r="ruby --version"

# zsh
alias reload="source ~/.zshrc"
alias zsh="vim ~/.zshrc"
alias omz="vim ~/.oh-my-zsh"

# homebrew
alias bubu="brew update && brew upgrade"

# lynx
alias hints='tmp_f(){ URL_PARAM=$(echo "$@" | sed "s/ /-/g"); lynx -accept_all_cookies https://devhints.io/"$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias abbr='tmp_f(){ URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies https://www.acronymfinder.com/"$URL_PARAM".html; unset -f tmp_f; }; tmp_f'
alias dict='tmp_f(){ URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies http://www.dictionary.com/browse/"$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias ddg='tmp_f(){ URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies https://duckduckgo.com/lite/?q="$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias duck='ddg'
alias wiki='tmp_f(){ URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies https://en.wikipedia.org/w/index.php?search="$URL_PARAM"; unset -f tmp_f; }; tmp_f'

# zshmarks like bashmarks
alias g="jump"
alias s="bookmark"
alias d="deletemark"
alias p="showmarks"
alias l="showmarks"

# IP addresses
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Get week number
alias week='date +%V'

# file browser
sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

# tmux session browser
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --reverse --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
