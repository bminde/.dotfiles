" vim:ft=vim foldmethod=marker foldlevel=0
" Basics {{{1
set nocompatible
filetype plugin indent on
syntax on

" Colors {{{1
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors
colorscheme solarized8_light

" Settings {{{1
set encoding=utf-8
set ttyfast
set number
set laststatus=2
set modelines=5
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab
set backspace=indent,eol,start
set incsearch
set ignorecase
set smartcase
set mouse=a
set display+=lastline
set iskeyword+=-
set diffopt+=vertical
set wildmenu
set wildmode=list:longest,list:full
set clipboard^=unnamed    " use system clipboard
set noswapfile
set splitright
set splitbelow
set path+=**              " search down into subfolders
set guicursor+=a:blinkon0 " turn of cursor blinking
set scrolloff=5
set sidescrolloff=5
set fillchars+=vert:┃
set synmaxcol=200         " Only highlight the first 200 columns
set regexpengine=1        " Use old engine to fix slow ruby syntax highlighting

" Cursor shape
set timeoutlen=1000 ttimeoutlen=0
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if v:version >= 800
  set breakindent   " indent wrapped lines if supported
endif

if has('persistent_undo')
  silent !mkdir ~/.vim/undo > /dev/null 2>&1
  set undodir=~/.vim/undo
  set undofile
endif

if has("gui_macvim")
  " no toolbars, menu or scrollbars in the gui
  set guifont=source\ code\ pro\ for\ powerline:h14
  set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m  " no menu
  set guioptions-=t  " no toolbar
  set guioptions-=l  " no left scrollbar
  set guioptions-=L  " no left scrollbar
  set guioptions-=r  " no right scrollbar
  set guioptions-=R  " no right scrollbar
endif

if has("folding")
  set foldmethod=indent   " fold based on indent level
  set foldnestmax=10      " max 10 depth
  set foldenable          " don't fold files by default on open
  set foldlevelstart=10   " start with fold level of 1
"   nnoremap <CR> za
endif

" Mappings {{{1

" Save with sudo
ca w! w !sudo tee "%"

nnoremap 0 ^
nnoremap ^ 0
nnoremap ' `
nnoremap ` '

map q <nop>

vmap <cr> <Plug>(EasyAlign)

" toggle fold
nnoremap <CR> za
" close other folds
map zo zMzv

nnoremap ,w :w<CR>
nnoremap ,q :q<CR>
nnoremap ,x :x<CR>

" NOTE: not needed when using tmux-navigator plugin
" nnoremap <c-h> <c-w>h
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-l> <c-w>l
nnoremap <tab> <c-w><c-w>

if bufwinnr(1)
  nmap ø <C-W><<C-W><
  nmap æ <C-W>><C-W>>
  nmap Æ <C-W>-<C-W>-
  nmap Ø <C-W>+<C-W>+
endif

nnoremap <silent> å :nohlsearch<cr>
nnoremap gb :ls<CR>:b<Space>
nnoremap ,, <c-^>         " toggle between last two files
nnoremap gV `[v`]
nnoremap J mzJ`z          " keep cursor in place while joining
" split line
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

let mapleader=" "
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Minpac {{{1

" Try to load minpac.
silent! packadd minpac
if !exists('*minpac#init')
  " minpac is not available.

  " Settings for plugin-less environment.
else
  call minpac#init()
  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " start
  call minpac#add('SirVer/ultisnips')
  call minpac#add('bronson/vim-trailing-whitespace')
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('ervandew/supertab')
  call minpac#add('haya14busa/is.vim')
  call minpac#add('honza/vim-snippets')
  call minpac#add('janko-m/vim-test')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('mattn/emmet-vim')
  call minpac#add('nelstrom/vim-visual-star-search')
  call minpac#add('pbrisbin/vim-mkdir')
  call minpac#add('sjl/gundo.vim')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-rake')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('vim-ruby/vim-ruby')

  " opt
  call minpac#add('editorconfig/editorconfig-vim', {'type': 'opt'})
  call minpac#add('kristijanhusak/vim-hybrid-material', {'type': 'opt'})
  call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})
  call minpac#add('majutsushi/tagbar', {'type': 'opt'})
  call minpac#add('morhetz/gruvbox', {'type': 'opt'})
  call minpac#add('raimondi/delimitmate', {'type': 'opt'})
  call minpac#add('rakr/vim-one', {'type': 'opt'})
  call minpac#add('rakr/vim-two-firewatch', {'type': 'opt'})
  call minpac#add('scrooloose/nerdtree', {'type': 'opt'})
  call minpac#add('sheerun/vim-polyglot', {'type': 'opt'})
  call minpac#add('tomasr/molokai', {'type': 'opt'})
  call minpac#add('tpope/vim-bundler', {'type': 'opt'})
  call minpac#add('tpope/vim-dispatch', {'type': 'opt'})
  call minpac#add('tpope/vim-ragtag', {'type': 'opt'})
  call minpac#add('tpope/vim-rhubarb', {'type': 'opt'})
  call minpac#add('tpope/vim-unimpaired', {'type': 'opt'})
  call minpac#add('vim-scripts/SyntaxRange', {'type': 'opt'})
  call minpac#add('w0rp/ale', {'type': 'opt'})

  command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
  command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

endif

if has('syntax') && has('eval')
  packadd! matchit
endif

" Plugin config {{{1
" Ale config {{{2
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_statusline_format = ['  ⨉ %d', ' ⚠ %d', '']
" Move between linting errors
noremap <leader>en :ALENextWrap<cr>
noremap <leader>ep :ALEPreviousWrap<cr>

" vim-fugitive config {{{2
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
" nnoremap <silent> <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Git lg<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>

" gundo config - visualize your undo tree {{{2
nnoremap <F6> :GundoToggle<CR>

" Nerdtree config {{{2
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=0
" expand/open with one click
let NERDTreeMouseMode=3
let NERDTreeRespectWildIgnore=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', '_build', '__pycache__', 'node_modules', 'dist']
let g:NERDTreeWinSize = 30

" vim-test config {{{2
nnoremap <silent> <Leader>tt :TestFile<CR>
nnoremap <silent> <Leader>ts :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

let test#strategy = 'vimux'

" Ultisnips config {{{2
let g:UltiSnipsSnippetsDir='~/.vim/snippets'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsExpandTrigger           = '<S-Tab>'
let g:UltiSnipsJumpForwardTrigger      = '<S-Tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-æ>'
nnoremap <leader>ue :UltiSnipsEdit<cr>

" FZF + ripgrep {{{2
if executable('rg')
  let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!.git/*'"
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = "ag --files --no-ignore --hidden --follow --glob '!.git/*'"
endif

nnoremap <leader>p :Files<CR>
" let g:fzf_prefer_vim_terminal = 1
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

" " Likewise, Files command with preview window
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Ctrlp + ripgrep {{{2
" if executable('rg')
"   " let g:ctrlp_user_command = 'rg --files %s'
"   let g:ctrlp_user_command = 'rg %s --files --glob ""'
"   let g:ctrlp_use_caching = 0
"   let g:ctrlp_working_path_mode = 'ra'
"   let g:ctrlp_switch_buffer = 'et'
" endif
" nnoremap <Leader>p :CtrlP<CR>

" Delimitmate config {{{2
let delimitMate_expand_cr = 1
" Local config {{{1
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
