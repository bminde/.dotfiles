" Table of Contents
" 1) Plug
"   1.1) Filetypes
"   1.2) Utilities
"   1.3) UI Plugins
"   1.4) Code Navigation
" 2) UI Tweaks
" 3) Keyboard shortcut Setup
" 4) Vim environment handling tweaks
" 5) File navigation
" 6) Auto Commands
"   6.1) Filetypes
"   6.1) Normalization
" 7) Project-Specific items
" 8) Nvim support
" 9) Macvim

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

""""""" Ruby
Plug 'vim-ruby/vim-ruby'

""""""" Elixir
Plug 'elixir-lang/vim-elixir'
" Plug 'slashmili/alchemist.vim'

""""""" Phoenix
Plug 'avdgaag/vim-phoenix'

""""""" Elm
Plug 'lambdatoast/elm.vim'

""""""" JavaScript
Plug 'elzr/vim-json'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'Shutnik/jshint2.vim'
" Plug 'ElmCast/elm-vim'

""""""" Web Development (HTML/CSS/preprocessors/etc)
Plug 'aaronjensen/vim-sass-status'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'lukaszb/vim-web-indent'
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'

""""""" Markdown
" Use fenced code blocks in markdown
Plug 'jtratner/vim-flavored-markdown'
  let g:markdown_fenced_languages=['ruby', 'javascript', 'elixir', 'clojure', 'sh', 'html', 'sass', 'scss', 'haml', 'erlang', 'go']

" .md is markdown, not Modula-2
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd FileType markdown set tw=80

"""""" Taskpaper
Plug 'davidoc/taskpaper.vim'
Plug 'vim-scripts/vim-auto-save'
Plug 'djoshea/vim-autoread'

"""""" TOML
Plug 'cespare/vim-toml'

"""""" Go
Plug 'fatih/vim-go'

""""" End Filetypes ====================

""""" Utilities ========================

" Set leader
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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'mhinz/vim-startify'
Plug 'tomtom/tcomment_vim'  " Line commenting
  " By default, `gc` will toggle comments
Plug 'godlygeek/tabular'
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
  endif

Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)

Plug 'janko-m/vim-test'                " Run tests with varying granularity
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

Plug 'christoomey/vim-tmux-navigator'  " Navigate between tmux panes and vim splits seamlessly
Plug 'tpope/vim-fugitive'              " git support
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gt :Gcommit -v -q %:p<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Git lg<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>

Plug 'DataWraith/auto_mkdir'
Plug 'vim-scripts/gitignore'
Plug 'vim-scripts/SyntaxRange'         " Allow ranges within a file to define different syntax mappings

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  set laststatus=2
  if has("gui_macvim")
    let g:airline_theme='nordisk'
  else
    let g:airline_theme='luna'
  endif
  let g:airline_powerline_fonts = 1
  let g:airline_enable_branch = 1
  let g:airline_enable_syntastic = 1
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
  if !exists('g:airline_powerline_fonts')
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_linecolumn_prefix = '␊ '
    let g:airline_linecolumn_prefix = '␤ '
    let g:airline_linecolumn_prefix = '¶ '
    let g:airline_branch_prefix = '⎇ '
    let g:airline_paste_symbol = 'ρ'
    let g:airline_paste_symbol = 'Þ'
    let g:airline_paste_symbol = '∥'
  endif

Plug 'tomasr/molokai'
  let g:molokai_original = 1
  let g:rehash256 = 1

Plug 'altercation/vim-colors-solarized'
  " set t_Co=16 " 8 | 256
  " g:solarized_termcolors=   16       " |   256
  " g:solarized_termtrans =   0        " |   1
  " g:solarized_degrade   =   0        " |   1
  " g:solarized_bold      =   1        " |   0
  " g:solarized_underline =   1        " |   0
  " g:solarized_italic    =   1        " |   0
  " g:solarized_contrast  =   "normal" " |   "high" or "low"
  " g:solarized_visibility=   "normal" " |   "high" or "low"
  " g:solarized_hitrail   =   0        " |   1
  " g:solarized_menu      =   1        " |   0

Plug 'kamwitsta/nordisk'
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
    \ }
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
  let g:netrw_list_hide = &wildignore
" Plug 'tpope/vim-endwise' " puts closing constructs on <CR>
Plug 'ervandew/supertab'

""""" End Code Navigation ===========

call plug#end() " required for Vundle

""" End setup Vundle ===================

""" UI Tweaks ==========================

" line numbering
set number

" Turn off menu in gui
set guioptions="agimrLt"

" Set GUI font
set guifont=Sauce\ Code\ Powerline:h13

" Enable mouse
if has('mouse')
  set mouse=a
endif

set t_ut= " improve screen clearing by using the background color
set backspace=indent,eol,start  "Allow backspace in insert mode
syntax enable
set background=dark

if has("gui_macvim")
  let macvim_skip_colorscheme=1
  colorscheme nordisk
else
  colorscheme solarized
endif

set enc=utf-8
" set term=screen-256color
" let $TERM='screen-256color'

set cul " highlight current line
set cuc " highlight current column

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

" Clear search highlight
nnoremap å :nohlsearch<cr>

" Search and replace - /something - cs - <Esc> - n.n.n.n.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" More natural split opening
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Buffers
nnoremap <leader>l :ls<CR>:b<Space>
nmap <Leader>n :enew<cr>
nmap <Leader>f :bnext<CR>
nmap <Leader>d :bprevious<CR>

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

" Save session (assortment of windows) - reopen with vim -S
nnoremap <leader>s :mksession<CR>

" Format the entire file
nmap <leader>fef ggVG=

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

" Custom split opening / closing behaviour
map <C-N> :vsp .<CR>
map <C-C> :q<CR>

" Reselect pasted content:
noremap gV `[v`]

" Toggle paste
set pastetoggle=<F5>

" Jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Access system clipboard
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

" Open the alternate file
map ,, <C-^>

" Fast save
nnoremap <Leader>w :w<CR>

" Fast quit
nnoremap <Leader>q :q<CR>

" Fast save and quit
nnoremap <Leader>x :x<CR>

" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>

""" End Keyboard shortcut setup =================

""" Vim environment handling tweaks ====

""""" BACKUP / TMP FILES
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

" Display incomplete commands
set showcmd

" Set encoding
set encoding=utf-8

" Start scrolling 8 lines before the border
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Whitespace
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
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js,*.codekit
set wildignore+=*/bower_components/*,*/node_modules/*,*/_build/*,*/build/*,*/deps/*
set wildignore+=*/.git/*,*/.svn/*,*/log/*,*/tmp/*,*/vendor/*,*/.codekit-cache/*

" Makes foo-bar considered one word
set iskeyword+=-

""" End Vim environment handling tweaks

""" File navigation ====================

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""" End File navigation ================

""" Auto Commands ======================

" Taskpaper auto write/read
autocmd filetype taskpaper let g:auto_save = 1
autocmd filetype taskpaper :WatchForChanges!

""""" Normalization ====================
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * silent call DeleteTrailingWS()
" make Esc happen without waiting for timeoutlen
" fixes airline delay
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END
""""" End Normalization ================

""" End Auto Commands ==================

""" Project-Specific Items =============

" Enable per-project vimrcs
set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

""" End Project-Specific Items =========
