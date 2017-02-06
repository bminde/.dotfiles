scriptencoding utf-8

" Plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
Plug 'andyl/vim-projectionist-elixir' "requires vim-projectionist
Plug 'andyl/vim-textobj-elixir' "requires vim-textobj-user
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'c-brenn/phoenix.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'ElmCast/elm-vim'
Plug 'davidoc/taskpaper.vim'
Plug 'vim-scripts/vim-auto-save'
Plug 'djoshea/vim-autoread'
Plug 'raimondi/delimitmate'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-rooter'       " Change vim working directory to project root
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-expand-region'
Plug 'janko-m/vim-test'                " Run tests with varying granularity
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'szw/vim-maximizer'
Plug 'henrik/vim-indexed-search'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-two-firewatch'
Plug 'albertorestifo/github.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'w0ng/vim-hybrid'
Plug 'rakr/vim-one'
Plug 'kamwitsta/nordisk'
Plug 'airblade/vim-gitgutter'
Plug 'roman/golden-ratio'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'dietsche/vim-lastplace'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-vinegar'

" Beta - things I'm testing
Plug 'jreybert/vimagit'
Plug 'neomake/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
" Plug 'AndrewRadev/splitjoin.vim' " multiline <--> single-line code
" Plug 'tpope/vim-endwise' " puts closing constructs on <CR>
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'tpope/vim-rhubarb'
" Plug 'mattn/webapi-vim'
" Plug 'mattn/gist-vim'
" Plug 'editorconfig/editorconfig-vim'  " Slows vim start up time, off until needed
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'jiangmiao/auto-pairs'

call plug#end()

"=====================================================
"===================== SETTINGS ======================

" Sane defaults for vim (these are default on NeoVim)
if !has('nvim')
  set nocompatible
  filetype off
  filetype plugin indent on

  set ttyfast
  set ttymouse=xterm2
  set ttyscroll=3

  set laststatus=2                " Always show statusline
  set encoding=utf-8              " Set default encoding to UTF-8
  set autoread                    " Automatically reread changed files without asking me anything
  set autoindent
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set incsearch                   " Shows the match while typing
  set hlsearch                    " Highlight found searches
  set mouse=a
endif

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
" set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=400
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2             " - Indent by 2 spaces by default
set formatoptions=tcrq
" set textwidth=80
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set pumheight=10             " Completion window max size
set clipboard^=unnamed
set clipboard^=unnamedplus
set viminfo='200
set lazyredraw          " Wait to redraw
set nrformats= " Treat 0-padded numbers as decimal, not octal
set title " Set the title of the iterm tab
set fillchars=fold:-,vert:│ " Nicer vertical window delimiter (unicode)
set omnifunc=syntaxcomplete#complete " enable omni syntax completion
set gcr=n:blinkon0 " Turn of cursor blinking
set wildmode=list:longest,list:full " Tab completion
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js,*.codekit
set wildignore+=*/bower_components/*,*/node_modules/*,*/_build/*,*/build/*,*/deps/*
set wildignore+=*/.git/*,*/.svn/*,*/log/*,*/tmp/*,*/vendor/*,*/.codekit-cache/*

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
  if has('!nvim')
    syntax enable
    set t_Co=256
    set term=ansi
  endif

  let g:rehash256 = 1
endif

if (has('termguicolors'))
  set termguicolors
endif

set background=dark
if has("nvim") || has("gui_macvim")
  colorscheme two-firewatch
else
  colorscheme molokai
endif

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1   " cursor shape
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd filetype help wincmd l

" .md is markdown, not Modula-2
autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
autocmd FileType markdown set tw=80

" autocmd bufnewfile,bufread *.txt setlocal noet ts=4 sw=4
" autocmd bufnewfile,bufread *.md setlocal noet ts=4 sw=4
" autocmd bufnewfile,bufread *.vim setlocal expandtab shiftwidth=2 tabstop=2

augroup elm
  autocmd!
  autocmd BufNewFile,BufRead *.elm setlocal tabstop=4
  autocmd BufNewFile,BufRead *.elm setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.elm setlocal softtabstop=4
augroup END

augroup markdown
  autocmd!
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

"=====================================================
"===================== mappings ======================

let g:mapleader=' ' " use space for leader

" center on screen when searching and scrolling
nnoremap n nzzzv
nnoremap N Nzzzv
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Clear the search buffer when hitting return
nnoremap <silent> å :nohlsearch<cr>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Search and replace - /something - cs - <Esc> - n.n.n.n.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Always use vertical diffs
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
nnoremap <leader>s :mksession!<CR>

" Format the entire file
" nmap <leader>fef ggVG=

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

" Custom split opening / closing behaviour
map <C-N> :vsp<CR><C-P>
map <C-C> :q<CR>
" Custom tab opening behaviour
map <leader>n :tabnew .<CR><C-P>

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

" 45<Enter> to go to line 45
nnoremap <CR> G
nnoremap <BS> gg

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
nnoremap <Leader>w :w<CR>

" Fast quit
nnoremap <Leader>q :q<CR>

" Fast save and quit
nnoremap <Leader>x :x<CR>

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <BS> <C-w>h
  " Have to add this because hyperterm sends backspace for C-h

" Navigate tabs with leader+h,l
nnoremap <leader>h :tabprev<cr>
nnoremap <leader>l :tabnext<cr>

"=====================================================
"===================== STATUSLINE ====================

" https://github.com/blaenk/dots/blob/master/vim/.vimrc

" Status Function: {{{2
function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let stat = ''

  " this function just outputs the content colored by the
  " supplied colorgroup number, e.g. num = 2 -> User2
  " it only colors the input if the window is the currently
  " focused one

  function! Color(active, group, content)
    if a:active
      return '%#' . a:group . '#' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " this handles alternative statuslines
  let usealt = 0

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  let altstat = ''

  if type ==# 'help'
    let altstat .= '%#SLHelp# HELP %* ' . fnamemodify(name, ':t:r')
    let usealt = 1
  elseif name ==# '__Gundo__'
    let altstat .= ' Gundo'
    let usealt = 1
  elseif name ==# '__Gundo_Preview__'
    let altstat .= ' Gundo Preview'
    let usealt = 1
  endif

  if usealt
    return altstat
  endif

  " column
  "   this might seem a bit complicated but all it amounts to is
  "   a calculation to see how much padding should be used for the
  "   column number, so that it lines up nicely with the line numbers

  "   an expression is needed because expressions are evaluated within
  "   the context of the window for which the statusline is being prepared
  "   this is crucial because the line and virtcol functions otherwise
  "   operate on the currently focused window

  function! Column()
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)]) + &l:foldcolumn
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''

    if padding <= 0
      let column .= vc
    else
      " + 1 because for some reason vim eats one of the spaces
      let column .= repeat(' ', padding + 1) . vc
    endif

    return column . ' '
  endfunction

  let stat .= '%#SLColumn#'
  let stat .= '%{Column()}'
  let stat .= '%*'

  if getwinvar(a:winnum, 'statusline_progress', 0)
    let stat .= Color(active, 'SLProgress', ' %p ')
  endif

  " file name
  " let stat .= Color(active, 'SLArrows', active ? ' »' : ' «')
  let stat .= ' %<'
  let stat .= '%f'
  " let stat .= ' ' . Color(active, 'SLArrows', active ? '«' : '»')

  " file modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= Color(active, 'SLLineNr', modified ? ' +' : '')

  " read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= Color(active, 'SLLineNR', readonly ? ' ‼' : '')

  " paste
  if active
    if getwinvar(a:winnum, '&spell')
      let stat .= Color(active, 'SLLineNr', ' S')
    endif

    if getwinvar(a:winnum, '&paste')
      let stat .= Color(active, 'SLLineNr', ' P')
    endif
  endif

  " right side
  let stat .= '%='

  " git branch
  if exists('*fugitive#head')
    let head = fugitive#head()

    if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
      call fugitive#detect(getcwd())
      let head = fugitive#head()
    endif
  endif

  if !empty(head)
    let stat .= Color(active, 'SLBranch', ' ← ') . head . ' '
  endif

  return stat
endfunction
" }}}

" Status AutoCMD: {{{
function! s:ToggleStatusProgress()
  if !exists('w:statusline_progress')
    let w:statusline_progress = 0
  endif

  let w:statusline_progress = !w:statusline_progress
endfunction

command! ToggleStatusProgress :call s:ToggleStatusProgress()

nnoremap <silent> ,p :ToggleStatusProgress<CR>

function! s:IsDiff()
  let result = 0

  for nr in range(1, winnr('$'))
    let result = result || getwinvar(nr, '&diff')

    if result
      return result
    endif
  endfor

  return result
endfunction

function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

command! RefreshStatus :call <SID>RefreshStatus()

augroup status
  autocmd!
  autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * :RefreshStatus
augroup END

" }}}

" vim-airline
"   set laststatus=2
"   let g:airline_theme='nordisk'
"   let g:bufferline_echo = 0
"   let g:airline_powerline_fonts=0
"   let g:airline_enable_branch=1
"   let g:airline_enable_syntastic=1
"   let g:airline_branch_prefix = '⎇ '
"   let g:airline_paste_symbol = '∥'
"   let g:airline#extensions#tabline#enabled = 0
"   let g:airline_mode_map = {
"         \ 'n' : 'N',
"         \ 'i' : 'I',
"         \ 'R' : 'REPLACE',
"         \ 'v' : 'VISUAL',
"         \ 'V' : 'V-LINE',
"         \ 'c' : 'CMD   ',
"         \ '': 'V-BLCK',
"         \ }
"   let g:airline_left_sep = ''
"   let g:airline_right_sep = ''
"   let g:airline_left_alt_sep = '|'
"   let g:airline_right_alt_sep = '|'
"   if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
"   endif
"   let g:airline_symbols.linenr = '␊'
"   let g:airline_symbols.linenr = '␤'
"   let g:airline_symbols.linenr = '¶'
"   let g:airline_symbols.branch = '⎇ '
"   let g:airline_symbols.paste = 'Þ'
"   let g:airline_symbols.paste = '∥'
"   let g:airline_symbols.paste = 'ρ'
"   let g:airline_symbols.whitespace = 'Ξ'

"=====================================================
"===================== PLUGINS =======================

" Polyglot
let g:polyglot_disabled = ['elm']

" Elm
let g:elm_format_autosave = 1

" Markdown - Use fenced code blocks in markdown
let g:markdown_fenced_languages=['ruby', 'javascript', 'elixir', 'sh', 'html']

" Deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  " inoremap <expr><c-j> pumvisible() ? "\<c-n>" : "\<Tab>"
  " inoremap <expr><c-k> pumvisible() ? "\<c-p>" : "\<S-Tab>"
  " use tab for completion
  inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"
endif

" Delimitmate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 1
let delimitMate_nesting_quotes = ['"']
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" Ultisnips
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" let g:UltiSnipsExpandTrigger="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" " let g:UltiSnipsExpandTrigger="<c-l>"
" " let g:UltiSnipsJumpForwardTrigger="<tab>"
" " let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Neosnippet
" " Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" " Tell Neosnippet about the other snippets
" let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" imap <C-l>  <Plug>(neosnippet_expand_or_jump)
" imap <S-Tab>  <Plug>(neosnippet_expand_or_jump)

" Tabular
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>: :Tabularize /:\zs<CR>
  vmap <Leader>: :Tabularize /:\zs<CR>
endif

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>
if has('nvim')
  " run tests in neovim strategy
  let g:test#strategy = 'neovim'
endif

" vim-fugitive
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

" vimagit
nnoremap <silent> <leader>m :Magit<CR>

" gundo.vim - visualize your undo tree
nnoremap <F6> :GundoToggle<CR>

"vim-maximizer
nnoremap <silent><F6> :MaximizerToggle<CR>
vnoremap <silent><F6> :MaximizerToggle<CR>gv
inoremap <silent><F6> <C-o>:MaximizerToggle<CR>

" vim-hybrid
let g:hybrid_reduced_contrast = 1

" fzf
if executable('fzf')
  let g:fzf_layout = { 'window': 'enew' }
  " let g:fzf_layout = { 'right': '~30%' }
  let $FZF_DEFAULT_COMMAND = '
    \ (ag --hidden --ignore .git -g "" ||
    \ git ls-tree -r --name-only HEAD ||
    \ find . -name "*.*" -not \(
    \ -path "*_build*" -o
    \ -path "*/node_modules/*" -o
    \ -path "*deps*" -o
    \ -path "*.lock" -o
    \ -name .
    \ \)
    \ | sed s/^..//) 2> /dev/null'
  " let $FZF_DEFAULT_COMMAND = '(git ls-tree -r --name-only HEAD ||
  "   \ find . -path "*/\.*" -prune -o -type f -print -o -type l -print
  "   \ | sed s/^..//) 2> /dev/null'
  " let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  command! -bang -nargs=* Ripgrep call fzf#vim#grep('rg --column
    \ --line-number --no-heading --fixed-strings --ignore-case --no-ignore
    \ --hidden --follow --glob "!.git/*" --color "always"
    \ '.shellescape(<q-args>), 1, <bang>0)
  command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number --color=always '.shellescape(<q-args>), 0,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
  autocmd VimEnter * command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always
    \ '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
  " nnoremap <silent> <leader>p :FZF<cr>
  nnoremap <silent> <leader>o :Ag!<cr>
  nnoremap <silent> <leader>r :Rg!<cr>
  nnoremap <silent> <leader>u :Ripgrep<cr>
  nnoremap <silent> <leader>i :GGrep!<cr>
  if has('nvim')
    augroup localfzf
      autocmd!
      autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
      autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
    augroup END
  endif
endif

" Ctrlp
nnoremap <Leader>p :CtrlP<CR>
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
let g:ctrlp_use_caching = 0            " don't cache, we want new list immediately each time
let g:ctrlp_max_files = 0              " no restriction on results/file list
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
    execute "CtrlP"
  endif
endfunction
autocmd VimEnter * :call MaybeCtrlP()

" ctrlsf - search project
let g:ctrlsf_default_root = 'project'
nnoremap <c-s> :CtrlSF<space>

" Neomake - Execute code checks, find mistakes, in the background
" Run Neomake when I save any buffer
augroup localneomake
  autocmd! BufWritePost * Neomake
augroup END
" Don't tell me to use smartquotes in markdown
let g:neomake_markdown_enabled_makers = []

" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
function! NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'      " Refactoring opportunities
    let l:type = 'W'
  elseif a:entry.type ==# 'D'  " Software design suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'W'  " Warnings
    let l:type = 'W'
  elseif a:entry.type ==# 'R'  " Readability suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'C'  " Convention violation
    let l:type = 'W'
  else
    let l:type = 'M'           " Everything else is a message
  endif
  let a:entry.type = l:type
endfunction

let g:neomake_elixir_mycredo_maker = {
  \ 'exe': 'mix',
  \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
  \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
  \ 'postprocess': function('NeomakeCredoErrorType')
  \ }

" vim-gutentags - easily manage tags files
if executable('ctags')
  let g:gutentags_cache_dir = '~/.tags_cache'
endif

" vim-vinegar - navigate up a directory with '-' in netrw, among other things
let g:netrw_list_hide = &wildignore

"=====================================================
"================= PROJECT SETTINGS ==================

set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
