# Path to your oh-my-zsh installation.
export ZSH=/Users/bjarte/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="bpure"

export NVM_LAZY_LOAD=true

# For Python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(bundler zsh-nvm zshmarks zsh-autosuggestions zsh-syntax-highlighting)
plugins=(bundler zsh-nvm zshmarks zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=default"

# chruby with auto switching
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# User configuration

# vi mode
bindkey -v

# Path
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# ymse
alias c="clear"
alias ..='cd ..'

alias ssh='TERM=xterm-256color ssh'

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

alias vimin='vim -u ~/.vimin -N --noplugin'
alias vimed='vim -u ~/.vimed -N --noplugin'
alias vimax='vim -u ~/.vimax -N --noplugin'
alias vi='vim -u ~/.vimax -N --noplugin'

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

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/bjarte/.nvm/versions/node/v10.3.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/bjarte/.nvm/versions/node/v10.3.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/bjarte/.nvm/versions/node/v10.3.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/bjarte/.nvm/versions/node/v10.3.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
