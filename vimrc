"================= PLUGINS =========================== {{{
scriptencoding utf-8

" Plug automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin() " }}}

" Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
Plug 'raimondi/delimitmate'
  " {{{
  let g:delimitMate_expand_cr = 1
  let g:delimitMate_expand_space = 1
  let g:delimitMate_smart_quotes = 1
  let g:delimitMate_expand_inside_quotes = 1
  let delimitMate_nesting_quotes = ['"']
  let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

  " FIXME Interfers with enter when pum is visible - do I need it at all?
  " imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
  " }}}
Plug 'lifepillar/vim-solarized8'
Plug 'w0rp/ale'
  " {{{
  let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  let g:ale_lint_on_enter = 0 " to avoid jumping cursor on open
  noremap <leader>en :ALENextWrap<cr>
  noremap <leader>ep :ALEPreviousWrap<cr>
  let g:airline#extensions#ale#enabled = 1
  " }}}
Plug 'sheerun/vim-polyglot'
  " {{{
  let g:polyglot_disabled = ['elm', 'elixir']
  " }}}
Plug 'vim-airline/vim-airline'
  " {{{
  let g:airline#extensions#tmuxline#enabled = 0
  let g:airline_powerline_fonts=1
  let g:airline_mode_map = {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'REPLACE',
        \ 'v' : 'VISUAL',
        \ 'V' : 'V-LINE',
        \ 'c' : 'CMD   ',
        \ '': 'V-BLCK',
        \ }
  " }}}
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise' " puts closing constructs on <CR>
Plug 'tpope/vim-fugitive'
  " {{{
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
  " }}}
Plug 'airblade/vim-gitgutter'
  " {{{
  if exists('&signcolumn')  " Vim 7.4.2201
    set signcolumn=yes
  else
    let g:gitgutter_sign_column_always = 1
  endif
  " }}}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar' " navigate up a directory with '-' in netrw
  " {{{
  let g:netrw_list_hide = &wildignore
  " }}}
Plug 'vimwiki/vimwiki'
  " {{{
  let g:vimwiki_list = [{'path': '~/Dropbox/tekst/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_folding='list'
  " }}}

" }}}
"================= PLUGINS - DEACTIVATED ============= {{{
" Plug 'ElmCast/elm-vim'
  " {{{
  let g:elm_detailed_complete = 1
  let g:elm_syntastic_show_warnings = 1
  let g:elm_format_fail_silently = 1
  let g:elm_browser_command = 'open'
  let g:elm_make_show_warnings = 1
  let g:elm_setup_keybindings = 1
  let elm_format_autosave = 1
  " }}}
" Plug 'ervandew/supertab'
" Plug 'airblade/vim-rooter'   " Change vim working dir to project root
" Plug 'albertorestifo/github.vim'
" Plug 'andyl/vim-projectionist-elixir' "requires vim-projectionist
" Plug 'andyl/vim-textobj-elixir' "requires vim-textobj-user
" Plug 'arcticicestudio/nord-vim'
" Plug 'c-brenn/phoenix.vim'
" Plug 'cocopon/iceberg.vim'
Plug 'ctrlpvim/ctrlp.vim'
  " {{{
  " nnoremap <Leader>p :CtrlP<CR>
  let g:ctrlp_match_window_bottom = 1    " Show at bottom of window
  let g:ctrlp_working_path_mode = 'ra'   " Our working path is our VCS project or the current directory
  let g:ctrlp_mru_files = 1              " Enable Most Recently Used files feature
  let g:ctrlp_jump_to_buffer = 2         " Jump to tab AND buffer if already open
  let g:ctrlp_open_new_file = 'v'        " open selections in a vertical split
  let g:ctrlp_open_multiple_files = 'vr' " opens multiple selections in vertical splits to the right
  let g:ctrlp_arg_map = 0
  let g:ctrlp_dotfiles = 1               " do not show (.) dotfiles in match list
  let g:ctrlp_showhidden = 1             " do not show hidden files in match list
  let g:ctrlp_split_window = 0
  let g:ctrlp_max_height = 30            " restrict match list to a maxheight of 40
  let g:ctrlp_use_caching = 1            " use cache, we want new list immediately each time
  let g:ctrlp_max_files = 500              " no restriction on results/file list
  let g:ctrlp_working_path_mode = 'r'
  let g:ctrlp_dont_split = 'NERD_tree_2' " don't split these buffers
  if executable( 'ag' )
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore out
    \ --ignore _build
    \ --ignore deps
    \ --ignore node_modules
    \ --ignore Session.vim
    \ --ignore .git
    \ --ignore .gitkeep
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore .lock
    \ --ignore .codekit-cache
    \ --ignore .codekit
    \ --ignore "*/*.swp"
    \ --ignore "*/.pyc"
    \ -g ""'
  else
    let g:ctrlp_user_command = {
      \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ }
      \ }
  endif
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

  " Open CtrlP on VimEnter in directory
  function! MaybeCtrlP()
    if argc() == 1 && isdirectory(argv()[0])
      " Uncomment this to remove the Netrw buffer (optional)
      " execute "bdelete"
      execute "FZF"
    endif
  endfunction
  autocmd VimEnter * :call MaybeCtrlP()
  " }}}
" Plug 'davidklsn/vim-sialoquent'
" Plug 'davidoc/taskpaper.vim'
" Plug 'dietsche/vim-lastplace'
" Plug 'djoshea/vim-autoread'
" Plug 'dyng/ctrlsf.vim'
" Plug 'elixir-lang/vim-elixir'
" Plug 'embear/vim-localvimrc'
" Plug 'glts/vim-textobj-comment'
" Plug 'godlygeek/tabular'
  " {{{
  if exists(":Tabularize")
    nmap <Leader>= :Tabularize /=<CR>
    vmap <Leader>= :Tabularize /=<CR>
    nmap <Leader>: :Tabularize /:\zs<CR>
    vmap <Leader>: :Tabularize /:\zs<CR>
  endif
  " }}}
" Plug 'henrik/vim-indexed-search'
" Plug 'honza/vim-snippets'
" Plug 'jacoborus/tender.vim'
" Plug 'janko-m/vim-test'             " Run tests with varying granularity
  " {{{
  nmap <silent> <leader>t :TestFile<CR>
  nmap <silent> <leader>T :TestNearest<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  " nmap <silent> <leader>l :TestLast<CR>
  " nmap <silent> <leader>g :TestVisit<CR>
  if has('nvim')
    " run tests in neovim strategy
    let g:test#strategy = 'neovim'
  endif
  " }}}
" Plug 'kana/vim-textobj-user'
" Plug 'mhinz/vim-startify'
" Plug 'morhetz/gruvbox'
" Plug 'mtth/scratch.vim'
  " {{{
  let g:scratch_insert_autohide = 0
  " }}}
" Plug 'neovim/python-client'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'powerman/vim-plugin-AnsiEsc'
" Plug 'rakr/vim-one'
" Plug 'rakr/vim-two-firewatch'
" Plug 'rizzatti/dash.vim'
" Plug 'romainl/Apprentice'
" Plug 'scrooloose/nerdtree'
  " {{{
  map <leader>n :NERDTreeToggle<CR>
  let NERDTreeHighlightCursorline=1
  let NERDTreeRespectWildIgnore=1
  let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', '_build', '__pycache__', 'node_modules', 'dist']
  let g:NERDTreeWinSize = 30
  " }}}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " {{{
  if has('nvim')
    let g:deoplete#enable_at_startup = 1
    if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
    endif
    " use tab for completion
    inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
    inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"
  endif
  " }}}
" Plug 'SirVer/ultisnips'
  " {{{
  " function! g:UltiSnips_Complete()
  "   call UltiSnips#ExpandSnippet()
  "   if g:ulti_expand_res == 0
  "     if pumvisible()
  "       return "\<C-n>"
  "     else
  "       call UltiSnips#JumpForwards()
  "       if g:ulti_jump_forwards_res == 0
  "         return "\<TAB>"
  "       endif
  "     endif
  "   endif
  "   return ""
  " endfunction

  " function! g:UltiSnips_Reverse()
  "   call UltiSnips#JumpBackwards()
  "   if g:ulti_jump_backwards_res == 0
  "     return "\<C-P>"
  "   endif

  "   return ""
  " endfunction


  " if !exists("g:UltiSnipsJumpForwardTrigger")
  "   let g:UltiSnipsJumpForwardTrigger = "<tab>"
  " endif

  " if !exists("g:UltiSnipsJumpBackwardTrigger")
  "   let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  " endif

  " au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
  " au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
  " let g:UltiSnipsExpandTrigger="<c-l>"
  " let g:UltiSnipsJumpForwardTrigger="<tab>"
  " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  " let g:UltiSnipsJumpBackwardTrigger="<c-h>"

  " If you want :UltiSnipsEdit to split your window.
  " let g:UltiSnipsEditSplit="vertical"
  " }}}
" Plug 'sjl/gundo.vim'
  " {{{ gundo - visualize your undo tree
  nnoremap <F6> :GundoToggle<CR>
  " }}}
" Plug 'slashmili/alchemist.vim'
" Plug 'szw/vim-maximizer'
  " {{{
  nnoremap <silent><F6> :MaximizerToggle<CR>
  vnoremap <silent><F6> :MaximizerToggle<CR>gv
  inoremap <silent><F6> <C-o>:MaximizerToggle<CR>
  " }}}
" Plug 'terryma/vim-expand-region'
  " {{{
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
  " }}}
" Plug 'tomasr/molokai'
" Plug 'tpope/vim-projectionist' " required for some navigation features
" Plug 'trusktr/seti.vim'
" Plug 'tyrannicaltoucan/vim-quantum'
" Plug 'vim-scripts/SyntaxRange' " allow portions of a file to use different syntax
" Plug 'vim-scripts/vim-auto-save'
" Plug 'w0ng/vim-hybrid'
" Plug 'zchee/deoplete-jedi'
"
" " Beta - things I'm testing
" Plug 'jreybert/vimagit'
  " {{{
  nnoremap <silent> <leader>m :MagitOnly<CR>
  " }}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  " {{{
  let g:fzf_layout = { 'window': 'enew' }
  nnoremap <silent> <leader>p :FZF<cr>
  nnoremap <silent> <leader>o :Ag<cr>
  " let $FZF_DEFAULT_COMMAND = 'ag -g ""'
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  augroup localfzf
    autocmd!
    autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
    autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
    autocmd VimEnter * command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)
  augroup END
  " if executable('fzf')
  "   let g:fzf_layout = { 'window': 'enew' }
  "   " let g:fzf_layout = { 'right': '~30%' }
  "   let $FZF_DEFAULT_COMMAND = '
  "     \ (ag --hidden --ignore .git -g "" ||
  "     \ git ls-tree -r --name-only HEAD ||
  "     \ find . -name "*.*" -not \(
  "     \ -name .
  "     \ \)
  "     \ | sed s/^..//) 2> /dev/null'
  "   " let $FZF_DEFAULT_COMMAND = '(git ls-tree -r --name-only HEAD ||
  "   "   \ find . -path "*/\.*" -prune -o -type f -print -o -type l -print
  "   "   \ | sed s/^..//) 2> /dev/null'
  "   " let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  "   command! -bang -nargs=* Ripgrep call fzf#vim#grep('rg --column
  "     \ --line-number --no-heading --fixed-strings --ignore-case --no-ignore
  "     \ --hidden --follow --glob "!.git/*" --color "always"
  "     \ '.shellescape(<q-args>), 1, <bang>0)
  "   command! -bang -nargs=* GGrep
  "     \ call fzf#vim#grep(
  "     \   'git grep --line-number --color=always '.shellescape(<q-args>), 0,
  "     \   <bang>0 ? fzf#vim#with_preview('up:60%')
  "     \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  "     \   <bang>0)
  "   autocmd VimEnter * command! -bang -nargs=* Ag
  "     \ call fzf#vim#ag(<q-args>,
  "     \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  "     \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  "     \                 <bang>0)
  "   command! -bang -nargs=* Rg
  "     \ call fzf#vim#grep(
  "     \   'rg --column --line-number --no-heading --color=always
  "     \ '.shellescape(<q-args>), 1,
  "     \   <bang>0 ? fzf#vim#with_preview('up:60%')
  "     \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  "     \   <bang>0)
  "   nnoremap <silent> <leader>p :FZF<cr>
  "   nnoremap <silent> <leader>o :Ag!<cr>
    nnoremap <silent> <leader>r :Rg!<cr>
    nnoremap <silent> <leader>u :Ripgrep<cr>
    nnoremap <silent> <leader>i :GGrep!<cr>
  "   if has('nvim')
  "     augroup localfzf
  "       autocmd!
  "       autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
  "       autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
  "     augroup END
  "   endif
  " endif
  " }}}
" Plug 'kassio/neoterm' " nicer api for neovim terminal
" Plug 'ludovicchabant/vim-gutentags'
  " {{{ vim-gutentags - easily manage tags files
  if executable('ctags')
    let g:gutentags_cache_dir = '~/.tags_cache'
  endif
  " }}}
" Plug 'roman/golden-ratio'
" Plug 'editorconfig/editorconfig-vim'  " Slows vim start up time, off until needed

call plug#end()

" }}}
"================= SETTINGS ========================== {{{

" Sane defaults for vim (these are default on NeoVim)
if !has('nvim')
  set nocompatible
  filetype off
  filetype plugin indent on

  set ttyfast
  set ttymouse=xterm2
  set ttyscroll=3

  set autoindent
  set autoread                    " Automatically reread changed files without asking me anything
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set encoding=utf-8              " Set default encoding to UTF-8
  set hlsearch                    " Highlight found searches
  set incsearch                   " Shows the match while typing
  set laststatus=2                " Always show statusline
  set mouse=a
endif

set noshowmode               " We show the mode with airline or lightline
set autowrite                " Automatically save before :next, :make etc.
set clipboard^=unnamed
set clipboard^=unnamedplus
set completeopt=menu,menuone
set expandtab
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set fillchars=fold:-,vert:│ " Nicer vertical window delimiter (unicode)
set foldmethod=marker
set formatoptions=tcrq
set gcr=n:blinkon0 " Turn of cursor blinking
set hidden
set ignorecase               " Search case insensitive...
set lazyredraw          " Wait to redraw
set nobackup                 " Don't create annoying backup files
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set noerrorbells             " No beeps
set noshowmatch              " Do not show matching brackets by flickering
set noswapfile               " Don't use swapfile
set nrformats= " Treat 0-padded numbers as decimal, not octal
set number                   " Show line numbers
set omnifunc=syntaxcomplete#complete " enable omni syntax completion
set pumheight=10             " Completion window max size
set scrolloff=8
set shiftwidth=2             " - Indent by 2 spaces by default
set showcmd                  " Show me what I'm typing
set sidescroll=1
set sidescrolloff=15
set smartcase                " ... but not it begins with upper case
set softtabstop=2
set splitbelow               " Split horizontal windows below to the current windows
set splitright               " Split vertical windows right to the current windows
set tabstop=2
" set title " Set the title of the iterm tab
set updatetime=400
set viminfo='200
set wildmode=list:longest,list:full " Tab completion
" set wildignore+=.DS_Store
" set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js,*.codekit
" set wildignore+=*/bower_components/*,*/node_modules/*,*/_build/*,*/build/*,*/deps/*
" set wildignore+=*/.git/*,*/.svn/*,*/log/*,*/tmp/*,*/vendor/*,*/.codekit-cache/*
" set wildignore+=*/__pycache__/*

if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo//
endif

if has("gui_macvim")
  " No toolbars, menu or scrollbars in the GUI
  set guifont=Source\ Code\ Pro:h13
  set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m  "no menu
  set guioptions-=T  "no toolbar
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r  "no scrollbar
  set guioptions-=R
  " set guioptions="agimrLt"

  let macvim_skip_colorscheme=1
else
  if !has('nvim')
    syntax enable
    set t_Co=256
    " set term=ansi
  endif

  let g:rehash256 = 1
endif

set background=light
" if ($TERM_PROGRAM == "iTerm.app" || has("gui_macvim"))
" set termguicolors
let g:solarized_termtrans=1
colorscheme solarized8_light_flat
let g:airline_theme='solarized'
" else
"   colorscheme molokai
" endif

" set t_ut=

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1   " cursor shape
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" change cursor shape in input mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd filetype help wincmd l

" autocmd bufnewfile,bufread *.txt setlocal noet ts=4 sw=4
" autocmd bufnewfile,bufread *.md setlocal noet ts=4 sw=4
" autocmd bufnewfile,bufread *.vim setlocal expandtab shiftwidth=2 tabstop=2

" pyhton
let g:python_host_prog = '/usr/local/bin/python'
let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" django
" autocmd FileType python set ft=python.django " For SnipMate
" autocmd FileType html set ft=htmldjango.html " For SnipMate

augroup elm
  autocmd!
  autocmd BufNewFile,BufRead *.elm setlocal tabstop=4
  autocmd BufNewFile,BufRead *.elm setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.elm setlocal softtabstop=4
augroup END

augroup markdown
  autocmd!
  " .md is markdown, not Modula-2
  autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal formatoptions=tcrq
augroup END

augroup taskpaper
  autocmd!
  autocmd filetype taskpaper let g:auto_save = 1
  autocmd filetype taskpaper :WatchForChanges!
augroup END

augroup viml
  autocmd!
  autocmd FileType vim setlocal textwidth=80
  autocmd FileType vim setlocal formatoptions=tcrq
augroup END

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endfunc

augroup whitespace
  autocmd BufWrite * silent call DeleteTrailingWS()
augroup END

" make Esc happen without waiting for timeoutlen
" fixes airline delay
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

" enter terminal mode when entering window with terminal buffer
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" }}}
"================= MAPPINGS ========================== {{{

let g:mapleader=' ' " use space for leader

" center on screen when searching and scrolling
nnoremap n nzzzv
nnoremap N Nzzzv
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Clear the search buffer when hitting `å`
nnoremap <silent> å :nohlsearch<cr>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

"  use vertical diffs
set diffopt+=vertical

" Buffers
" nnoremap <leader>l :ls<CR>:b<Space>
" nmap <Leader>n :enew<cr>
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
" nnoremap <leader>s :mksession!<CR>

" Format the entire file
" nmap <leader>fef ggVG=

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

" Custom split opening / closing behaviour
map <C-N> :vsp<CR><C-P>
map <C-C> :q<CR>
" Custom tab opening behaviour
" map <leader>n :tabnew .<CR><C-P>

" reselect pasted content:
noremap gV `[v`]

" Toggle paste
set pastetoggle=<F4>

" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Toggle fold
nnoremap <CR> za

" Save with sudo
ca w!! w !sudo tee "%"

" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Open the alternate file
map ,, <C-^>

" Makes foo-bar considered one word
set iskeyword+=-

" Fast save
nnoremap ,w :w<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>fs :w<CR>

" Fast quit
nnoremap <Leader>q :q<CR>
nnoremap ,q :q<CR>

" Fast save and quit
nnoremap <Leader>x :x<CR>
nnoremap ,x :x<CR>

" Edit .vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>

" Navigate terminal with C-h,j,k,l
" Fix <c-h> mapping http://stackoverflow.com/questions/33833642/ctrl-h-mapping-in-neovims-terminal-emulator
if has('nvim')
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif

" Navigate splits with C-h,j,k,l
" Use ctrl-[hjkl] to move focus between splits!
" NOTE: https://github.com/christoomey/vim-tmux-navigator now takes care of this
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l
nnoremap <silent> <BS> <C-w>h
  " Have to add this because hyperterm sends backspace for C-h

" Navigate tabs with leader+h,l
nnoremap <leader>h :tabprev<cr>
nnoremap <leader>l :tabnext<cr>

" }}}
