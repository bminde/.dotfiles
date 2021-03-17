" vim
set encoding=utf-8
filetype plugin indent on
syntax on
runtime macros/matchit.vim
set autoindent                 " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Proper backspace behavior.
set hidden                     " Possibility to have more than one unsaved buffers.
set incsearch                  " Incremental search, hit `<CR>` to stop.
set ruler                      " Shows the current line number at the bottom-right of the screen.
set wildmenu                   " Great command-line completion, use `<Tab>` to move around and `<CR>` to validate.
set ttyfast
set ttimeoutlen=10
set relativenumber
set laststatus=2
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set vb t_vb=
set hlsearch
set ignorecase
set smartcase
set mouse=a
set display+=lastline
set iskeyword+=-          " makes foo-bar considered one word
set clipboard^=unnamed    " use system clipboard
set noswapfile
set splitright
set splitbelow
set guicursor+=a:blinkon0 " turn of cursor blinking
set scrolloff=5
set sidescrolloff=5
set fillchars+=vert:\ " space
set path=.,**
set autoread
set wildcharm=<C-z>
if v:version >= 800
  set breakindent   " indent wrapped lines if supported
endif

" Show block cursor in Normal mode and line cursor in Insert mode
" (use odd numbers for blinking cursor):
let &t_ti.="\e[2 q"
let &t_SI.="\e[6 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[2 q"
let &t_te.="\e[0 q"
" italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

nnoremap gb :ls<CR>:b<Space>
nnoremap <space>p :find *
nnoremap ,f :GitFind *
nnoremap ,g :Grep 
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,t :tabfind *
nnoremap <silent> cd :<c-u>cd %:h \| pwd<cr> " Change to the directory of the current file
nnoremap ,w :w<cr>
nnoremap ,q :q<cr>
nnoremap ,x :x<cr>
nnoremap 0 ^
nnoremap ,, <c-^>         " toggle between last two files
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <space>d "=strftime('# %F')<cr>P " insert date
if exists(':terminal')
  tnoremap <c-h> <c-w>h
  tnoremap <c-j> <c-w>j
  tnoremap <c-k> <c-w>k
  tnoremap <c-l> <c-w>l
  tnoremap <esc><esc> <C-\><C-n> " Two escapes fixes problem with E21 modifiable off
endif
if bufwinnr(1)
  nnoremap ø <C-W><<C-W><
  nnoremap æ <C-W>><C-W>>
  nnoremap Æ <C-W>-<C-W>-
  nnoremap Ø <C-W>+<C-W>+
endif
nnoremap ,1 1gt " tab navigation
nnoremap ,2 2gt
nnoremap ,3 3gt
nnoremap ,4 4gt
nnoremap ,5 5gt
nnoremap ,6 6gt
nnoremap ,7 7gt
nnoremap ,8 8gt
nnoremap ,9 9gt
nnoremap <silent> å :set hlsearch!<cr> " toggle search highlight
nnoremap <expr> gV    "`[".getregtype(v:register)[0]."`]" " reselect pasted block
nnoremap <space>ev :tabedit $MYVIMRC<cr> " edit vimrc
" navigate quickfix entries
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprevious<CR>
nnoremap <Up> :copen<CR>
nnoremap <Down> :cclose<CR>
nnoremap <space><space> /
" pair expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap (;    (<CR>);<Esc>O
inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [;    [<CR>];<Esc>O
inoremap [,    [<CR>],<Esc>O

set statusline=\ %t                                    " file name
set statusline+=\ %1*%m%0*                             " modified flag
set statusline+=%r                                     " read only flag
set statusline+=%w                                     " preview window flag
set statusline+=\ %<%{empty(&bt)?expand('%:p:~:h'):''} " file path
set statusline+=%=                                     " switch to the right side
set statusline+=%y                                     " filetype
set statusline+=\ %l                                   " current line
set statusline+=/                                      " separator
set statusline+=%L                                     " total lines
set statusline+=:                                      " separator
set statusline+=%c\                                    " current column

set backupdir=/tmp//,.
set directory=/tmp//,.
" Semi-persistent undo
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif

" netrw
let g:netrw_banner=0
let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
let g:netrw_list_hide .= ',__pycache__,.pyc$,node_modules,.git/,.cache,tags,Session.vim'
let g:netrw_bufsettings = 'noswf noma nomod nu rnu nowrap ro nobl'
let g:netrw_sort_options = 'i'
nnoremap - :Ex<cr>
function! SearchNetrw(fname)
  if ! search('\V\^' . a:fname . '\$')
    call search('^' . substitute(a:fname, '\w\zs.*', '', '') . '.*\/\@<!$')
  endif
endfunction

augroup Autocmds
  autocmd!
  " Netrw
  autocmd FileType netrw set nolist
  " focus on current file - https://stackoverflow.com/a/29457190
  autocmd VimEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string(expand('%:t')) . ')'
  autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS
  " Linting
  autocmd FileType python setlocal formatprg=black\ --quiet\ -
  autocmd FileType python autocmd BufWritePre <buffer> silent normal mkHmlgggqG`lzt`k
  autocmd FileType python nmap <silent> <space>r :terminal ++rows=20 python %<cr>
  autocmd FileType elixir nmap <silent> <buffer> ,tt :terminal ++rows=20 mix test %<cr>
  autocmd FileType elixir nmap <silent> <buffer> ,ta :terminal ++rows=20 mix test<cr>

  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd FileType * set fo-=c fo-=r fo-=o " Don't continue comment on new line
  if exists(':terminal')
    autocmd TerminalOpen * set nonumber norelativenumber signcolumn=no
  endif
  " Jump to last known position
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | end
augroup END

" Returns a pair of comment delimiters, extracted from 'commentstring'.
" The delimiters are ready to be used in a regular expression.
function! Comment_delimiters()
  let l:delim = split(&l:commentstring, '\s*%s\s*')
  if empty(l:delim)
    call lf_msg#err('Undefined comment delimiters. Please setlocal commentstring.')
    return ['','']
  endif
  if len(l:delim) < 2
    call add(l:delim, '')
  endif
  return [escape(l:delim[0], '\/*~$.'), escape(l:delim[1], '\/*~$.')]
endfunction

" Comment out a region of text. Assumes that the delimiters are properly escaped.
function! Comment_out(first, last, lc, rc) abort
  let l:indent = s:minindent(a:first, a:last)
  for l:lnum in range(a:first, a:last)
    call setline(l:lnum, substitute(getline(l:lnum), '^\(\s\{'.l:indent.'}\)\(.*\)$', '\1'.a:lc.' \2'.(empty(a:rc) ? '' : ' '.a:rc), ''))
  endfor
endfunction

" Uncomment a region of text. Assumes that the delimiters are properly escaped.
function! Uncomment(first, last, lc, rc) abort
  for l:lnum in range(a:first, a:last)
    call setline(l:lnum, substitute(substitute(getline(l:lnum), '\s*'.a:rc.'\s*$', '', ''), '^\(\s*\)'.a:lc.'\s\?\(.*\)$', '\1\2', ''))
  endfor
endfunction

" Comment/Uncomment a region of text.
function! Toggle_comment(type, ...) abort " See :h map-operator
  let [l:lc, l:rc] = Comment_delimiters()
  let [l:first, l:last] = a:0 ? [line("'<"), line("'>")] : [line("'["), line("']")]
  if match(getline(l:first), '^\s*'.l:lc) > -1
    call Uncomment(l:first, l:last, l:lc, l:rc)
  else
    call Comment_out(l:first, l:last, l:lc, l:rc)
  endif
endfunction

function! s:minindent(first, last)
  let [l:min, l:i] = [indent(a:first), a:first + 1]
  while l:min > 0 && l:i <= a:last
    if l:min > indent(l:i)
      let l:min = indent(l:i)
    endif
    let l:i += 1
  endwhile
  return l:min
endfunction
nnoremap <silent>  gcc :set opfunc=Toggle_comment<cr>g@l
vnoremap <silent>  gc :<c-u>call Toggle_comment(visualmode(), 1)<cr>

function! TabComplete()
  if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
    return "\<C-P>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <expr> <Tab> TabComplete()
inoremap <S-Tab> <c-n>
set completeopt=menuone
imap <C-o> <C-x><C-o>
imap <C-f> <C-x><C-f>
imap <C-t> <C-x><C-]>

" https://vi.stackexchange.com/a/2589
function! GitFindComplete(ArgLead, CmdLine, CursorPos)
  let search_pattern = "*" . a:ArgLead . "*"
  let shell_cmd = "git ls-files " . shellescape(search_pattern)
  return split(system(shell_cmd), "\n")
endfunction
command! -nargs=1 -bang -complete=customlist,GitFindComplete GitFind edit<bang> <args>

" Grep - https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
set grepprg=rg\ --vimgrep
function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" monochrome color scheme
hi clear
if exists('syntax_on')
   syntax reset
endif
let g:colors_name = 'monochrome'
hi Normal                   ctermfg=NONE    cterm=NONE
hi Cursor                   ctermfg=16      cterm=NONE
hi CursorLine               ctermfg=NONE    cterm=NONE
hi CursorLineNr             ctermfg=NONE    cterm=bold
hi DiffAdd                  ctermfg=0       ctermbg=2
hi DiffChange               ctermfg=0       ctermbg=3
hi DiffDelete               ctermfg=0       ctermbg=1
hi DiffText                 ctermfg=0       ctermbg=11      cterm=bold
hi FoldColumn               ctermfg=248     cterm=NONE
hi Folded                   ctermfg=NONE    cterm=NONE
hi Number                   ctermfg=NONE    cterm=NONE      term=NONE
hi LineNr                   ctermfg=248     cterm=NONE      term=NONE
hi Statement                ctermfg=NONE    cterm=bold      term=bold
hi PreProc                  ctermfg=NONE    cterm=bold      term=bold
hi String                   ctermfg=75      cterm=NONE
hi Comment                  ctermfg=243     cterm=NONE      term=NONE
hi Constant                 ctermfg=NONE    cterm=NONE      term=NONE
hi Type                     ctermfg=NONE    cterm=bold      term=bold
hi Function                 ctermfg=NONE    cterm=NONE
hi Identifier               ctermfg=NONE    cterm=NONE      term=NONE
hi Special                  ctermfg=NONE    cterm=NONE
hi MatchParen               ctermfg=16      ctermbg=252
hi Underlined               ctermfg=75      ctermbg=NONE
hi Todo                     ctermfg=16      cterm=bold
hi Pmenu                    ctermfg=NONE    cterm=NONE
hi PmenuSel                 ctermfg=75      cterm=NONE
hi Search                   ctermfg=NONE    cterm=NONE
hi Visual                   ctermfg=NONE    ctermbg=NONE    cterm=inverse
hi NonText                  ctermfg=248     cterm=NONE
hi Directory                ctermfg=NONE    cterm=bold
hi Title                    ctermfg=NONE    cterm=bold
hi TabLine                                  cterm=NONE
hi StatusLineTerm           ctermfg=NONE    ctermbg=NONE    cterm=reverse,bold
hi StatusLineTermNC         ctermfg=NONE    ctermbg=NONE    cterm=reverse
hi SignColumn                               ctermbg=NONE
if &background == "light"
  highlight ColorColumn     ctermfg=8       ctermbg=7
  highlight Folded          ctermfg=8       ctermbg=7
  highlight FoldColumn      ctermfg=8       ctermbg=7
  highlight Pmenu           ctermfg=0       ctermbg=7
  highlight PmenuSel        ctermfg=7       ctermbg=0
  highlight SpellCap        ctermfg=8       ctermbg=7
else
  highlight ColorColumn     ctermfg=7       ctermbg=8
  highlight Folded          ctermfg=7       ctermbg=8
  highlight FoldColumn      ctermfg=7       ctermbg=8
  highlight Pmenu           ctermfg=15      ctermbg=8
  highlight PmenuSel        ctermfg=8       ctermbg=15
  highlight SpellCap        ctermfg=7       ctermbg=8
endif
