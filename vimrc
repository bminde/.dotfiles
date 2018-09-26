" xvim:ft=vim foldmethod=marker foldlevel=0

" Basics {{{1
set nocompatible
filetype plugin indent on
syntax on

" Colors {{{1
if has('termguicolors') && $COLORTERM ==# 'truecolor'
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum" " Needed in tmux
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum" " Ditto
  set termguicolors
endif

let g:solarized_statusline = 'low'

let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_comment_brightness = 8
let g:nord_uniform_diff_background = 1
" let g:nord_uniform_status_lines = 1

" set bg=light
colorscheme solarized8

" Settings {{{1
set encoding=utf-8
set ttyfast
set number
set laststatus=2
" set showtabline=2
set modelines=5
set vb t_vb=
set ts=2 sts=2 sw=2 expandtab
set backspace=indent,eol,start
set incsearch
set hlsearch
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
set noshowmode            " hide mode, e.g. --INSERT--
set splitright
set splitbelow
" set path+=**              " search down into subfolders
set guicursor+=a:blinkon0 " turn of cursor blinking
set scrolloff=5
set sidescrolloff=5
" set fillchars+=vert:┃
" set fillchars=vert:\│
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
set fillchars=vert:│,fold:·
" set fillchars+=vert:\ " space
set synmaxcol=200         " Only highlight the first 200 columns
set regexpengine=1        " Use old engine to fix slow ruby syntax highlighting
set title                 " set iTerm window title to file name and path

set wildignore+=*.pyc,tags,__pycache__,.git,.cache,Session.vim
set wildignore+=node_modules,bin,.vscode,*.db,*.sqlite3
set wildignore+=*.log,.DS_Store

" use italics for comments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic

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
  let s:vim_cache = expand('$HOME/.vim/undo')
  if filewritable(s:vim_cache) == 0 && exists("*mkdir")
    call mkdir(s:vim_cache, "p", 0700)
  endif
  set undodir=~/.vim/undo
  set undofile
endif

set guifont=Fura\ Code\ Retina\ Nerd\ Font\ Complete:h12

if has("gui_macvim")
  " no toolbars, menu or scrollbars in the gui
  " set guifont=SF\ Mono:h15
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
endif

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

" Mappings {{{1

" Save with sudo
ca w! w !sudo tee "%"

nnoremap 0 ^
nnoremap ^ 0
nnoremap ' `
nnoremap ` '

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

map q <nop>

vmap <cr> <Plug>(EasyAlign)

" toggle fold
" nnoremap <CR> za
" close other folds
map zo zMzv

nnoremap ,w :w<CR>
nnoremap ,q :q<CR>
nnoremap ,x :x<CR>

" NOTE: not needed when using tmux-navigator plugin
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <tab> <c-w><c-w>
tnoremap <c-h> <c-w>h
tnoremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l

" two escapes fixed problem with E21 modifiable off
tnoremap <esc><esc> <C-\><C-n>

if has('nvim')
  tnoremap <c-j> <c-\><c-n><c-w>j
  tnoremap <c-k> <c-\><c-n><c-w>k
  tnoremap <c-h> <c-\><c-n><c-w>h
  tnoremap <c-l> <c-\><c-n><c-w>l
  autocmd BufWinEnter,WinEnter term://* startinsert
endif

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
nnoremap ,e :e **/*
nnoremap ,f :e **/*
nnoremap ,s :sp **/*
nnoremap ,v :vsp **/*
nnoremap ,t :tabe **/*
" split line
" nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Go to tab by number
nnoremap ,1 1gt
nnoremap ,2 2gt
nnoremap ,3 3gt
nnoremap ,4 4gt
nnoremap ,5 5gt
nnoremap ,6 6gt
nnoremap ,7 7gt
nnoremap ,8 8gt
nnoremap ,9 9gt

let mapleader=" "
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Color swap {{{1
" https://superuser.com/a/1246650

function! Solar_swap()
  if &background ==? 'dark'
    set background=light
    colorscheme solarized8_light
  else
    set background=dark
    colorscheme solarized8_dark
  endif
  silent !osascript -e 'tell app "System Events" to keystroke "i" using {shift down,  command down}'
endfunction

command! SolarSwap call Solar_swap()

" Auto commands {{{1

" Don't continue comment on new line
augroup Format-Options
  autocmd!
  au FileType * set fo-=c fo-=r fo-=o
augroup END

if !has('nvim')
  augroup CursorLineOnlyInActiveWindow
    au TerminalOpen * set nonu
  augroup END
endif


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
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('benmills/vimux')
  " call minpac#add('bronson/vim-trailing-whitespace')
  call minpac#add('chrisbra/Colorizer') " :ColorToggle
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('ctrlpvim/ctrlp.vim')
  " call minpac#add('easymotion/vim-easymotion')
  call minpac#add('ervandew/supertab')
  call minpac#add('haya14busa/is.vim')
  call minpac#add('honza/vim-snippets')
  call minpac#add('janko-m/vim-test')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/goyo.vim')
  call minpac#add('junegunn/gv.vim')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('kopischke/vim-fetch')
  call minpac#add('lifepillar/vim-gruvbox8')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('majutsushi/tagbar')
  call minpac#add('mattn/emmet-vim')
  call minpac#add('morhetz/gruvbox')
  call minpac#add('nelstrom/vim-visual-star-search')
  call minpac#add('pbrisbin/vim-mkdir')
  call minpac#add('raimondi/delimitmate')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('sgur/vim-editorconfig')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('sjl/gundo.vim')
  call minpac#add('sunaku/vim-dasht')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-obsession')
  call minpac#add('tpope/vim-projectionist')
  call minpac#add('tpope/vim-rails')
  call minpac#add('tpope/vim-rake')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('w0rp/ale')

  " opt
  call minpac#add('arcticicestudio/nord-vim',       {'type': 'opt'})
  call minpac#add('chriskempson/base16-vim',        {'type': 'opt'})
  call minpac#add('fenetikm/falcon',                {'type': 'opt'})
  call minpac#add('fxn/vim-monochrome',             {'type': 'opt'})
  call minpac#add('khatiba/ayu-vim',                {'type': 'opt'})
  call minpac#add('lifepillar/vim-solarized8',      {'type': 'opt'})
  call minpac#add('lifepillar/vim-wwdc16-theme',    {'type': 'opt'})
  call minpac#add('lifepillar/vim-wwdc17-theme',    {'type': 'opt'})
  call minpac#add('Lokaltog/vim-monotone',          {'type': 'opt'})
  call minpac#add('mhartington/oceanic-next',       {'type': 'opt'})
  call minpac#add('rakr/vim-one',                   {'type': 'opt'})
  call minpac#add('rakr/vim-two-firewatch',         {'type': 'opt'})
  call minpac#add('tpope/vim-bundler',              {'type': 'opt'})
  call minpac#add('tpope/vim-dispatch',             {'type': 'opt'})
  call minpac#add('tpope/vim-ragtag',               {'type': 'opt'})
  call minpac#add('tpope/vim-rhubarb',              {'type': 'opt'})
  call minpac#add('tpope/vim-unimpaired',           {'type': 'opt'})
  call minpac#add('vim-scripts/SyntaxRange',        {'type': 'opt'})
  call minpac#add('whatyouhide/vim-gotham',         {'type': 'opt'})
  call minpac#add('wolverian/minimal',              {'type': 'opt'})
  call minpac#add('w0ng/vim-hybrid',                {'type': 'opt'})

  command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
  command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

endif

if has('syntax') && has('eval') && !exists('loaded_matchit')
  source $VIMRUNTIME/macros/matchit.vim
endif

" Theme config {{{1

" Oceanic next {{{2
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" ayu {{{2
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme

" two-firwatch {{{2
hi CursorLine   cterm=NONE

" wwdc 16/17 {{{2
let g:wwdc16_term_italics = 0
let g:wwdc17_term_italics = 0
let g:wwdc17_frame_color = 4

" Plugin config {{{1

" Airline {{{2
let g:airline_powerline_fonts = 1
" remove section y - only works when devicon for file format is removed
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
" fixes trunctation of file type
let g:airline_section_x = '%{&filetype}'
let g:airline_section_y=''
" hide function name
let g:airline#extensions#tagbar#enabled = 0
" only show %
let g:airline_section_z = '%3p%%'
let g:airline_skip_empty_sections = 1
let g:airline_right_sep = ""
let g:airline_left_sep = ""
let g:airline_right_alt_sep = "|"
let g:airline_left_alt_sep = "|"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#show_splits = 0
let g:airline_section_z ="%3l/%L:%2v"
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#left_sep = ""
let g:airline#extensions#bufferline#right_sep = ""
let g:airline#extensions#bufferline#left_alt_sep = ""
let g:airline#extensions#bufferline#right_alt_sep = ""
let g:airline#extensions#tabline#left_sep = " "
let g:airline#extensions#tabline#right_sep = ""
let g:airline#extensions#tabline#left_alt_sep = ""
let g:airline#extensions#tabline#right_alt_sep = ""
" let g:airline_theme='gruvbox'
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ 't'  : 'T',
\ }

" Ale config {{{2
let g:ale_enabled = 1 " Off by default
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_statusline_format = ['  ⨉ %d', ' ⚠ %d', '']
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
let g:ale_sign_warning='●'
hi ALEErrorSign ctermfg=red ctermbg=none
let g:ale_sign_error='●'
hi ALEWarningSign ctermfg=yellow ctermbg=none
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_fix_on_save = 1
" let g:ale_open_list = 1
" Check Python files with flake8 and pylint.
" let g:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let g:ale_fixers = ['black', 'autopep8', 'yapf']
" Move between linting errors
noremap <leader>an :ALENextWrap<cr>
noremap <leader>ap :ALEPreviousWrap<cr>
noremap <leader>at :ALEToggle<cr>
noremap <leader>ad :ALEDetail<cr>

" dasht config {{{2
" search related docsets
nnoremap <silent> <Leader>k :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>

" search ALL the docsets
nnoremap <silent> <Leader><Leader>k :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>

" easy align {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" easymotion config {{{2
nmap <leader>f <Plug>(easymotion-bd-w)
let g:EasyMotion_keys='qwertyuiopåasdfghjkløæcvbnm'

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

" gitgutter {{{2
let g:gitgutter_enabled = 0

" vim-go config {{{2
let g:go_fmt_command = "goimports"

" gundo config - visualize your undo tree {{{2
nnoremap <F6> :GundoToggle<CR>

" nerdtree config {{{2
map <leader>n :NERDTreeToggle<CR>
" let NERDTreeHighlightCursorline=0
" expand/open with one click
let NERDTreeMouseMode=3
let NERDTreeRespectWildIgnore=1
let g:NERDTreeWinSize = 30
let NERDTreeHijackNetrw=0

" polyglot {{{2
let g:python_highlight_space_errors = 0

" vim-test config {{{2
nnoremap <silent> <Leader>tt :TestFile<CR>
nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

let test#strategy = 'basic'
" let test#strategy = 'vimterminal'

" Ultisnips config {{{2
let g:UltiSnipsSnippetsDir='~/.vim/snippets'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
let g:UltiSnipsExpandTrigger           = '<S-Tab>'
let g:UltiSnipsJumpForwardTrigger      = '<S-Tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<C-æ>'
nnoremap <leader>ue :UltiSnipsEdit<cr>

" Vimux config {{{2
nnoremap <leader>r :VimuxInterruptRunner<cr>:VimuxRunCommand("clear; go run " . bufname("%"))<CR>
nnoremap <leader>c :VimuxInterruptRunner<cr>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vm :VimuxPromptCommand("make ")<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vs :VimuxInterruptRunner<CR>

" FZF + ripgrep {{{2
if executable('rg')
  let $FZF_DEFAULT_COMMAND = "rg --files --ignore-file ~/.agignore --follow --glob '!.git/*'"
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = "ag --hidden --ignore .git -l ''"
else
  let $FZF_DEFAULT_COMMAND = "find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
endif

" let g:fzf_layout = { 'down': '~20%' }
" let g:fzf_layout = { 'window': '10split' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': 'enew' }

" Try highlight, coderay, rougify in turn, then fall back to cat
" let g:fzf_file_options = '--preview "[[ \$(file --mime {2..-1}) =~ binary ]] && echo {2..-1} is a binary file || (highlight -O ansi -l {2..-1} || coderay {2..-1} || rougify {2..-1} || cat {2..-1}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_files_options =
   \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" let g:fzf_layout = { 'window': '15split enew' }
" let g:fzf_layout = { 'window': '-tabnew' }

nnoremap <leader>p :call Fzf_dev()<CR>
nnoremap <Leader>i :call Fzf_dev_preview()<CR>

" Files + devicons
function! Fzf_dev()
  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run(fzf#wrap('devicons',{
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ',
        \ 'down':    '40%' }))
endfunction

" FIXME: refactor
function! Fzf_dev_preview()
  let l:fzf_files_options = '--preview "cat {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run(fzf#wrap('devicon_preview',{
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' }))
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --color=always
  \   -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \   -g "!{.git,.DS_Store,dist,node_modules,vendor}/*"
  \   '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>o :Rg<cr>

" Ctrlp + ripgrep {{{2
if executable('rg')
  let g:ctrlp_user_command = 'Rg %s --files --glob ""'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
endif
" nnoremap <Leader>p :CtrlP<CR>

" Delimitmate config {{{2
let delimitMate_expand_cr = 1

" Devicons
" if exists("g:loaded_webdevicons")
"   call webdevicons#refresh()
" endif

" Local config {{{1
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
