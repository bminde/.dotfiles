" Table of Contents
" 1) Plug
"   1.1) Filetypes
"   1.2) Utilities
"   1.3) UI Plugins
"   1.4) Code Navigation
" 2) UI Tweaks
" 3) Keyboard shortcut Setup
" 4) vim environment handling tweaks (needs work / renaming)
" 5) File navigation
" 6) Auto Commands
"   6.1) Filetypes
"   6.1) Normalization
" 7) Project-Specific items
" 8) nvim support

""" Plug =======================
" PlugInstall       - install plugins
" PlugUpdate        - install or update plugins
" PlugClean[!]      - remove unused direcotories (! = without prompt)
" PlugUpgrade       - upgrade vim-plug itself
" PlugStatus        - check the status of plugins
" PlugDiff          - examine changes from the previous update and the pending changes

" Plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Initialize plug
call plug#begin('~/.vim/plugged')

""""" Filetypes ========================

Plug 'sheerun/vim-polyglot'
  " let g:polyglot_disabled = ['css']

" """"""" Ruby
" Plug 'vim-ruby/vim-ruby'
"
" """"""" Elixir
" Plug 'elixir-lang/vim-elixir'
" " Plug 'slashmili/alchemist.vim'
"
" """"""" Phoenix
" Plug 'avdgaag/vim-phoenix'
"
" """"""" Elm
" " Plug 'lambdatoast/elm.vim'
"
" """"""" JavaScript
" " Plug 'claco/jasmine.vim'
" Plug 'elzr/vim-json'
" Plug 'jelera/vim-javascript-syntax'
" " Plug 'mxw/vim-jsx'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'Shutnik/jshint2.vim'
" " Plug 'burnettk/vim-angular'
" " Plug 'mtscout6/vim-cjsx'
" " Plug 'ElmCast/elm-vim'
"
" """"""" Web Development (HTML/CSS/preprocessors/etc)
" Plug 'aaronjensen/vim-sass-status'
" Plug 'cakebaker/scss-syntax.vim'
" Plug 'groenewege/vim-less'
" Plug 'hail2u/vim-css3-syntax'
" Plug 'lukaszb/vim-web-indent'
" Plug 'othree/html5.vim'
" Plug 'tpope/vim-haml'
" Plug 'slim-template/vim-slim'

" """"""" Markdown
" " Use fenced code blocks in markdown
" Plug 'jtratner/vim-flavored-markdown'
  " let g:markdown_fenced_languages=['ruby', 'javascript', 'elixir', 'clojure', 'sh', 'html', 'sass', 'scss', 'haml', 'erlang', 'go']
" Markdown is now included in vim, but by default .md is read as Modula-2
" files.  This fixes that, because I don't ever edit Modula-2 files :)
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd FileType markdown set tw=80

""""""" TOML
" Plug 'cespare/vim-toml'

""""""" CoffeeScript
" Plug 'kchmck/vim-coffee-script'

""""""" Go
" Plug 'fatih/vim-go'

""""" End Filetypes ====================

""""" Utilities ========================

" Set leader
" let mapleader=","
let mapleader = "\<Space>"
let maplocalleader="\\"

" Treat 0-padded numbers as decimal, not octal
set nrformats=

" Plug 'editorconfig/editorconfig-vim' " EditorConfig support

" Plug 'scrooloose/syntastic' " Syntax highlighting
"   let g:syntastic_mode_map = { "mode": "passive",
"                              \ "passive_filetypes": ["elixir", "java", "html", "css", "scss"] }
"   set statusline+=%#warningmsg#
"   set statusline+=%{SyntasticStatuslineFlag()}
"   set statusline+=%*
"   let g:syntastic_always_populate_loc_list = 1
"   let g:syntastic_auto_loc_list = 1
"   let g:syntastic_check_on_open = 1
"   let g:syntastic_check_on_wq = 0

Plug 'tpope/vim-surround'
" temporary fix for ultisnips macvim crashing bug
if !has("gui_macvim")
  Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'mhinz/vim-startify'
Plug 'tomtom/tcomment_vim'  " Line commenting
  " By default, `gc` will toggle comments

Plug 'janko-m/vim-test'                " Run tests with varying granularity
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

Plug 'christoomey/vim-tmux-navigator'  " Navigate between tmux panes and vim splits seamlessly
Plug 'tpope/vim-fugitive'              " git support from dat tpope
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gt :Gcommit -v -q %:p<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  " nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gl :Git lg<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
" Plug 'scrooloose/nerdtree'
  " map <leader>n :NERDTreeToggle<CR>
  " let NERDTreeHighlightCursorline=1
  " let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', '_build']
  " let g:NERDTreeWinSize = 40
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'DataWraith/auto_mkdir'
Plug 'vim-scripts/gitignore'
Plug 'vim-scripts/SyntaxRange'         " Allow ranges within a file to define different syntax mappings
Plug 'mattn/webapi-vim'                " vim interface to web apis.  Required for gist-vim
Plug 'mattn/gist-vim'                  " create gists trivially from buffer, selection, etc.
  let g:gist_open_browser_after_post = 1
  let g:gist_detect_filetype = 2
  let g:gist_post_private = 1
  if has('macunix')
    let g:gist_clip_command = 'pbcopy'
  endif

Plug 'sjl/gundo.vim'
  nnoremap <F7> :GundoToggle<CR>

Plug 'szw/vim-maximizer'
  nnoremap <silent><F6> :MaximizerToggle<CR>
  vnoremap <silent><F6> :MaximizerToggle<CR>gv
  inoremap <silent><F6> <C-o>:MaximizerToggle<CR>

" Indexed search
Plug 'henrik/vim-indexed-search'

""""" End Utilities ====================

""""" UI Plugins =======================
Plug 'vim-airline/vim-airline'       " UI statusbar niceties
Plug 'vim-airline/vim-airline-themes'
  set laststatus=2               " enable airline even if no splits
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
  let g:airline_powerline_fonts=1
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_symbols.linenr = '␊ '
  let g:airline_symbols.linenr = '␤ '
  let g:airline_symbols.linenr = '¶ '
  let g:airline_symbols.branch = '⎇ '
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline#extensions#tabline#enabled = 0
  let g:airline_mode_map = {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'REPLACE',
        \ 'v' : 'VISUAL',
        \ 'V' : 'V-LINE',
        \ 'c' : 'CMD   ',
        \ '': 'V-BLCK',
        \ }
" Plug 'tomasr/molokai'
"   let g:molokai_original = 1
"   let g:rehash256 = 1

Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'rakr/vim-one'
Plug 'mkarmona/colorsbox'

" Plugin 'roman/golden-ratio'
Plug 'airblade/vim-gitgutter'
""""" End UI Plugins ===================

""""" Code Navigation ===============
Plug 'ctrlpvim/ctrlp.vim'
  nnoremap <Leader>p :CtrlP<CR>
  let g:ctrlp_match_window_bottom = 1    " Show at bottom of window
  let g:ctrlp_working_path_mode = 'ra'   " Our working path is our VCS project or the current directory
  let g:ctrlp_mru_files = 1              " Enable Most Recently Used files feature
  let g:ctrlp_jump_to_buffer = 2         " Jump to tab AND buffer if already open
  let g:ctrlp_open_new_file = 'v'        " open selections in a vertical split
  let g:ctrlp_open_multiple_files = 'vr' " opens multiple selections in vertical splits to the right
  let g:ctrlp_arg_map = 0
  let g:ctrlp_dotfiles = 0               " do not show (.) dotfiles in match list
  let g:ctrlp_showhidden = 0             " do not show hidden files in match list
  let g:ctrlp_split_window = 0
  let g:ctrlp_max_height = 40            " restrict match list to a maxheight of 40
  let g:ctrlp_use_caching = 0            " don't cache, we want new list immediately each time
  let g:ctrlp_max_files = 0              " no restriction on results/file list
  let g:ctrlp_working_path_mode = 'r'
  let g:ctrlp_dont_split = 'NERD_tree_2' " don't split these buffers
  let g:ctrlp_user_command = {
    \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore out
    \ --ignore _build
    \ --ignore deps
    \ --ignore node_modules
    \ --ignore .git
    \ --ignore .gitkeep
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore .codekit-cache
    \ --ignore .codekit
    \ --ignore "*/.pyc"
    \ -g ""'
    \ }
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-e>', '<c-space>'],
    \ 'AcceptSelection("h")': ['<c-h>', '<c-x>', '<c-cr>', '<c-s>'],
    \ 'AcceptSelection("v")': ['<c-v>'],
    \ 'AcceptSelection("t")': ['<c-t>'],
    \ 'AcceptSelection("r")': ['<cr>'],
    \ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
    \ 'PrtHistory(-1)':       ['<c-n>'],
    \ 'PrtHistory(1)':        ['<c-p>'],
    \ 'ToggleFocus()':        ['<c-tab>'],
    \}

Plug 'tpope/vim-vinegar' " navigate up a directory with '-' in netrw, among other things
" Plug 'tpope/vim-endwise' " puts closing constructs on <CR>
Plug 'ervandew/supertab'

""""" End Code Navigation ===========

call plug#end() " required for Vundle

""" End setup Vundle ===================

""" UI Tweaks ==========================
set number " line numbering
set t_Co=256 " Force 256 colors

" Turn off menu in gui
set guioptions="agimrLt"

" Set GUI font
set guifont=Source\ Code\ Pro\ for\ Powerline:h13

" Turn off mouse click in gui
" set mouse=""
" Enable mouse
if has('mouse')
  set mouse=a
endif

" in case t_Co alone doesn't work, add this as well:
" i.e. Force 256 colors harder
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set t_ut= " improve screen clearing by using the background color
set backspace=indent,eol,start  "Allow backspace in insert mode
set background=dark
syntax enable

colorscheme gruvbox
let g:airline_theme='gruvbox'
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

set enc=utf-8
" set term=screen-256color
let $TERM='screen-256color'

" Highlighting line or number follows....
set cul " highlight current line
" If you want to just highlight the line number:
" hi clear CursorLine
" augroup CLClear
"   autocmd! ColorScheme * hi clear CursorLine
" augroup END
" hi CursorLineNR cterm=bold
" augroup CLNRSet
"   autocmd! ColorScheme * hi CursorLineNR cterm=bold
" augroup END

" Highlight current column
set cuc

" change vim cursor depending on the mode
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " OS X iTerm 2 settings
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  else
    if has("autocmd")
      au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
      au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
      au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
      au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    endif
  endif
endif

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Open files where we left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
""" End UI Tweaks ======================

""" Keyboard shortcut setup =====================
" Remove highlights
" Clear the search buffer when hitting return
nnoremap å :nohlsearch<cr>

" Search and replace - /something - cs - <Esc> - n.n.n.n.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" NO ARROW KEYS COME ON
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" Escape keys
:imap jk <Esc>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" More natural split opening
set splitbelow
set splitright

" Resize buffers
if bufwinnr(1)
  nmap ø <C-W><<C-W><
  nmap æ <C-W>><C-W>>
  nmap Æ <C-W>-<C-W>-
  nmap Ø <C-W>+<C-W>+
endif

" Close the current buffer
map <leader>bd :bd<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" save session (assortment of windows) - reopen with vim -S
nnoremap <leader>s :mksession<CR>

" format the entire file
nmap <leader>fef ggVG=

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

" Custom split opening / closing behaviour
map <C-N> :vsp .<CR>
map <C-C> :q<CR>

" reselect pasted content:
noremap gV `[v`]

set pastetoggle=<F5>

" jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" access system clipboard
set clipboard=unnamed

" 45<Enter> to go to line 45
nnoremap <CR> G
nnoremap <BS> gg

" Save with sudo
ca w!! w !sudo tee "%"

" Redraw my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
" nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Open the alternate file
map ,, <C-^>

" Fast save
nnoremap <Leader>w :w<CR>

" Fast quit
nnoremap <Leader>q :q<CR>

" Fast save and quit
nnoremap <Leader>x :x<CR>

" Edit .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>

""" End Keyboard shortcut setup =================

""" Vim environment handling tweaks ====
""""" BACKUP / TMP FILES
" taken from
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory=~/.vim/swap
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" display incomplete commands
set showcmd

" Set encoding
set encoding=utf-8

" Start scrolling 8 lines before the border
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,_build/*,.git/*,.codekit-cache/*,*.codekit,.DS_Store,*/deps/*,*/node_modules/*

" Makes foo-bar considered one word
set iskeyword+=-
""" End Vim environment handling tweaks

""" File navigation ====================
" case insensitive highlight matches in normal/visual mode
nnoremap / /\v
vnoremap / /\v

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""" End File navigation ================

""" Auto Commands ======================
""""" Filetypes ========================
augroup erlang
  au!
  au BufNewFile,BufRead *.erl setlocal tabstop=4
  au BufNewFile,BufRead *.erl setlocal shiftwidth=4
  au BufNewFile,BufRead *.erl setlocal softtabstop=4
  au BufNewFile,BufRead relx.config setlocal filetype=erlang
augroup END

augroup dotenv
  au!
  au BufNewFile,BufRead *.envrc setlocal filetype=sh
augroup END
""""" End Filetypes ====================

""""" Normalization ====================
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * silent call DeleteTrailingWS()
""""" End Normalization ================
""" End Auto Commands ==================

""" Project-Specific Items =============
" Enable per-project vimrcs
set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
""" End Project-Specific Items =========

""" nvim support =======================
if has('nvim')
  set unnamedclip
endif
""" end nvim support ===================
