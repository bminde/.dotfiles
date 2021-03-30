" Modeline and Notes {{{1
" vim: set sw=2 ts=2 sts=0 et foldmethod=marker foldlevel=0 :nospell:
" Settings {{{1
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
if has("patch-7.4.710")
  set listchars=tab:▸\ ,trail:∙,space:∙,eol:¬,nbsp:▪,precedes:⟨,extends:⟩  " Invisible characters
else
  set listchars=tab:>-,trail:.,eol:~,precedes:<,extends:>
endif

" Semi-persistent undo
set backupdir=/tmp//,.
set directory=/tmp//,.
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif

set wildignore+=*.swp,*.bak,tmp/**,tags,.DS_Store
set wildignore+=*.pyc,venv/**,__pycache__/**
set wildignore+=.git/**,.gitkeep

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

" Mappings {{{1
map <space> <leader>
nnoremap gb :ls<CR>:b<Space>
nnoremap <leader>p :find *
nnoremap <silent>,f :<c-u>call FindFile()<cr>
nnoremap ,g :Grep
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,t :terminal ++rows=15<cr>
nnoremap <silent> cd :<c-u>cd %:h \| pwd<cr> " Change to the directory of the current file
nnoremap ,w :w<cr>
nnoremap ,q :q<cr>
nnoremap ,x :x<cr>
nnoremap 0 ^
nnoremap ,, <c-^>         " toggle between last two files
nnoremap <leader>d "=strftime('# %F')<cr>P " insert date
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
nnoremap <leader>ev :tabedit $MYVIMRC<cr> " edit vimrc
nnoremap          <leader>el :tabedit ~/.vim/vimrc_local<cr> " edit vimrc_local
nnoremap <silent> <leader>gd :<c-u>call GitDiff()<cr>
nnoremap <silent> <leader>gs :<c-u>call TerminalRun('git status')<cr>

nnoremap          <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <leader>ew :<c-u>call <sid>removeTrailingSpace()<cr>

" navigate quickfix entries
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprevious<CR>
nnoremap <Up> :copen<CR>
nnoremap <Down> :cclose<CR>
nnoremap <leader><leader> /

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

if exists(':terminal')
  tnoremap <c-h> <c-w>h
  tnoremap <c-j> <c-w>j
  tnoremap <c-k> <c-w>k
  tnoremap <c-l> <c-w>l
  tnoremap <esc><esc> <C-\><C-n> " Two escapes fixes problem with E21 modifiable off
endif

" Status line {{{1
let g:lf_stlh = {
      \ 'n': 'NormalMode',  'i': 'InsertMode',      'R': 'ReplaceMode',
      \ 'v': 'VisualMode',  'V': 'VisualMode', "\<c-v>": 'VisualMode',
      \ 's': 'VisualMode',  'S': 'VisualMode', "\<c-s>": 'VisualMode',
      \ 'c': 'CommandMode', 'r': 'CommandMode',     't': 'CommandMode',
      \ '!': 'CommandMode',  '': 'StatusLineNC'
      \ }

let g:lf_stlm = {
      \ 'n': 'N',           'i': 'I',               'R': 'R',
      \ 'v': 'V',           'V': 'V',          "\<c-v>": 'V',
      \ 's': 'S',           'S': 'S',          "\<c-s>": 'S',
      \ 'c': 'C',           'r': 'P',               't': 'T',
      \ '!': '!'}

fun! LFStlHighlight()
  return get(g:lf_stlh,
        \    g:statusline_winid ==# win_getid() ? mode() : '',
        \   'Warnings')
endf

let s:stl = "%{&mod?'◦':' '} %t %{&ma?(&ro?'▪':' '):'✗'}
      \ %<%{empty(&bt)?(winwidth(0)<80?(winwidth(0)<50?'':expand('%:p:h:t')):expand('%:p:~:h')):''}
      \ %=
      \ %a %w %y %{winwidth(0)<80?'':' '.(strlen(&fenc)?&fenc:&enc).(&bomb?',BOM ':' ').&ff.(&et?'':' ⇥ ')}
      \ %l/%L:%v %P
      \ %#Warnings#%{get(b:, 'lf_stl_warnings', '')}%*"

let s:stlnc = '    ' . "%{&mod?'◦':' '} %t %{&ma?(&ro?'▪':' '):'✗'}
      \ %<%{empty(&bt)?(winwidth(0)<80?(winwidth(0)<50?'':expand('%:p:h:t')):expand('%:p:~:h')):''}
      \ %=
      \ %w %y  %l/%L:%v %P "

fun! LFBuildStatusLine()
  return g:statusline_winid ==# win_getid()
        \ ? '%#'.get(g:lf_stlh, mode(), 'Warnings').'# '
        \ . get(g:lf_stlm, mode(), mode()) . (&paste ? ' PASTE %* ' : ' %* ') . s:stl
        \ : s:stlnc
endf

command! -nargs=0 EnableStatusLine call <sid>enableStatusLine()
command! -nargs=0 DisableStatusLine call <sid>disableStatusLine()

" Tabline {{{1
  fun! BuildTabLabel(nr, active)
    return (a:active ? '●' : a:nr).' '.fnamemodify(bufname(tabpagebuflist(a:nr)[tabpagewinnr(a:nr) - 1]), ":t:s/^$/[No Name]/").' '
  endf

  fun! LFBuildTabLine()
    return (tabpagenr('$') == 1 ? '' : join(map(
          \   range(1, tabpagenr('$')),
          \   '(v:val == tabpagenr() ? "%#TabLineSel#" : "%#TabLine#") . "%".v:val."T %{BuildTabLabel(".v:val.",".(v:val == tabpagenr()).")}"'
          \ ), ''))
          \ . "%#TabLineFill#%T%=⌘ %<%{&columns < 100 ? fnamemodify(getcwd(), ':t') : getcwd()} " . (tabpagenr('$') > 1 ? "%999X✕ " : "")
  endf

" Helper functions {{{1
  fun! s:enableStatusLine()
    if exists("g:default_stl") | return | endif
    augroup lf_warnings
      autocmd!
      autocmd BufReadPost,BufWritePost * call <sid>update_warnings()
    augroup END
    set noshowmode " Do not show the current mode because it is displayed in the status line
    set noruler
    let g:default_stl = &statusline
    let g:default_tal = &tabline
    set statusline=%!LFBuildStatusLine()
    set tabline=%!LFBuildTabLine()
  endf

  fun! s:disableStatusLine()
    if !exists("g:default_stl") | return | endif
    let &tabline = g:default_tal
    let &statusline = g:default_stl
    unlet g:default_tal
    unlet g:default_stl
    set ruler
    set showmode
    autocmd! lf_warnings
    augroup! lf_warnings
  endf

  " Update trailing space and mixed indent warnings for the current buffer.
  fun! s:update_warnings()
    if exists('b:lf_no_warnings')
      unlet! b:lf_stl_warnings
      return
    endif
    if exists('b:lf_large_file')
      let b:lf_stl_warnings = ' Large file '
      return
    endif
    let l:trail  = search('\s$',       'cnw')
    let l:spaces = search('^  ',       'cnw')
    let l:tabs   = search('^\t',       'cnw')
    if l:trail || (l:spaces && l:tabs)
      let b:lf_stl_warnings = ' '
            \ . (l:trail            ? 'Trailing space ('.l:trail.') '           : '')
            \ . (l:spaces && l:tabs ? 'Mixed indent ('.l:spaces.'/'.l:tabs.') ' : '')
    else
      unlet! b:lf_stl_warnings
    endif
  endf

  " Delete trailing white space.
  fun! s:removeTrailingSpace()
    let l:winview = winsaveview() " Save window state
    keeppatterns %s/\s\+$//e
    call winrestview(l:winview) " Restore window state
    call s:update_warnings()
    redraw  " See :h :echo-redraw
    echomsg 'Trailing space removed!'
  endf

  " Create directory if it doesn't exit when saving new file
  function! EnsureDirectoryExists()
    let required_dir = expand("%:h")

    if !isdirectory(required_dir)
      " Remove this if-clause if you don't need the confirmation
      " if !confirm("Directory '" . required_dir . "' doesn't exist. Create it?")
      " return
      " endif

      try
        call mkdir(required_dir, 'p')
      catch
        echoerr "Can't create '" . required_dir . "'"
      endtry
    endif
  endfunction

" Tmux {{{1
let s:tmux_directions = {'h':'L', 'j':'D', 'k':'U', 'l':'R'}

fun! TmuxNavigate(dir)
  let l:winnr = winnr()
  execute 'wincmd' a:dir
  if winnr() ==# l:winnr
    call system("tmux select-pane -" .. s:tmux_directions[a:dir])
  endif
endf

if $TERM =~# '^\%(tmux\|screen\)'
  nnoremap <silent> <c-h> :<c-u>call TmuxNavigate('h')<cr>
  nnoremap <silent> <c-j> :<c-u>call TmuxNavigate('j')<cr>
  nnoremap <silent> <c-k> :<c-u>call TmuxNavigate('k')<cr>
  nnoremap <silent> <c-l> :<c-u>call TmuxNavigate('l')<cr>
else
  nnoremap <c-l> <c-w>l
  nnoremap <c-h> <c-w>h
  nnoremap <c-j> <c-w>j
  nnoremap <c-k> <c-w>k
endif

" Toggle options {{{1
nnoremap <silent> <leader>oc :<c-u>setlocal cursorline!<cr>
nnoremap          <leader>od :<c-r>=&diff ? 'diffoff' : 'diffthis'<cr><cr>
nnoremap <silent> <leader>ol :<c-u>setlocal list!<cr>
nnoremap <silent> <leader>on :<c-u>setlocal number!<cr>
nnoremap <silent> <leader>or :<c-u>setlocal relativenumber!<cr>
nnoremap <silent> <leader>ot :<c-u>setlocal expandtab!<cr>
nnoremap <silent> <leader>ow :<c-u>call ToggleWrap()<cr>
nnoremap <silent> <leader>ob :let &background = (&background == 'dark') ? 'light' : 'dark'<cr>
" Autocmds {{{1
augroup Autocmds
  autocmd!
  " Netrw
  autocmd FileType netrw set nolist
  " focus on current file - https://stackoverflow.com/a/29457190
  autocmd VimEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string(expand('%:t')) . ')'
  " Create directory if it doesn't exit when saving new file
  autocmd BufNewFile * call EnsureDirectoryExists()
  " Linting
  autocmd FileType python setlocal formatprg=black\ --quiet\ -
  autocmd FileType python setlocal makeprg=black\ --quiet
  autocmd FileType python autocmd BufWritePre <buffer> silent normal mkHmlgggqG`lzt`k
  autocmd FileType python nmap <silent> <leader>r :terminal ++rows=20 python %<cr>
  autocmd FileType python nmap <silent> <leader>i :<c-u>Isort<cr>
  command! -range=% Isort :<line1>,<line2>! isort -
  autocmd FileType elixir nmap <silent> <buffer> ,tt :terminal ++rows=20 mix test %<cr>
  autocmd FileType elixir nmap <silent> <buffer> ,ta :terminal ++rows=20 mix test<cr>
  autocmd FileType markdown setlocal textwidth=80

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

" Make/Fix {{{1
set autoread
command! Make silent make % | checktime | silent redraw!
nnoremap <leader>m :Make<cr>

" Poor man's ctrlp {{{1
" https://vimrcfu.com/snippet/251
fun! FilterClose(bufnr)
  wincmd p
  execute "bwipe" a:bufnr
  redraw
  echo "\r"
  return []
endf

fun! FilterInteractively(input, prompt) abort
  let l:prompt = a:prompt . '>'
  let l:filter = ''  " Text used to filter the list
  let l:undoseq = [] " Stack to tell whether to undo when pressing backspace (1 = undo, 0 = do not undo)
  botright 10new +setlocal\ buftype=nofile\ bufhidden=wipe\
        \ nobuflisted\ nonumber\ norelativenumber\ noswapfile\ nowrap\
        \ winfixheight\ foldmethod=manual\ nofoldenable\ modifiable\ noreadonly
  let l:cur_buf = bufnr('%') " Store current buffer number
  if type(a:input) ==# v:t_string
    let l:input = systemlist(a:input)
    call setline(1, l:input)
  else " Assume List
    call setline(1, a:input)
  endif
  setlocal cursorline
  redraw
  echo l:prompt . ' '
  while 1
    let l:error = 0 " Set to 1 when pattern is invalid
    try
      let ch = getchar()
    catch /^Vim:Interrupt$/  " CTRL-C
      return FilterClose(l:cur_buf)
    endtry
    if ch ==# "\<bs>" " Backspace
      let l:filter = l:filter[:-2]
      let l:undo = empty(l:undoseq) ? 0 : remove(l:undoseq, -1)
      if l:undo
        silent norm u
      endif
    elseif ch >=# 0x20 " Printable character
      let l:filter .= nr2char(ch)
      let l:seq_old = get(undotree(), 'seq_cur', 0)
      try " to ignore invalid regexps
        execute 'silent keepp g!:\m' . escape(l:filter, '~\[:') . ':norm "_dd'
      catch /^Vim\%((\a\+)\)\=:E/
        let l:error = 1
      endtry
      let l:seq_new = get(undotree(), 'seq_cur', 0)
      " seq_new != seq_old iff buffer has changed
      call add(l:undoseq, l:seq_new != l:seq_old)
    elseif ch ==# 0x1B " Escape
      return FilterClose(l:cur_buf)
    elseif ch ==# 0x0D " Enter
      let l:result = empty(getline('.')) ? [] : [getline('.')]
      call FilterClose(l:cur_buf)
      return l:result
    elseif ch ==# 0x0C " CTRL-L (clear)
      call setline(1, type(a:input) ==# v:t_string ? l:input : a:input)
      let l:undoseq = []
      let l:filter = ''
      redraw
    elseif ch ==# 0x0B " CTRL-K
      norm k
    elseif ch ==# 0x0A " CTRL-J
      norm j
    endif
    redraw
    echo (l:error ? '[Invalid pattern] ' : '').l:prompt l:filter
  endwhile
endf

fun! FindFile() abort
  if executable('rg')
    let choice = FilterInteractively('rg --files --hidden --glob "!.git" .', 'Choose file ')
  elseif isdirectory('.git')
    let choice = FilterInteractively('git ls-files .', 'Choose file ')
  else
    let choice = FilterInteractively('find . -type f', 'Choose file ')
  endif
  if !empty(choice)
    execute "edit" choice[0]
  endif
endf

" Git diff {{{1

" args: a List providing the arguments for git
" where: a Vim command specifying where the window should be opened
fun! Git(args, where) abort
  call RunCmd(['git'] + a:args, {'pos': a:where})
  setlocal nomodifiable
endf

" Show a vertical diff between the current buffer and its last committed
" version.
fun! GitDiff() abort
  let l:ft = getbufvar("%", '&ft') " Get the file type
  let l:fn = expand('%:t')
  call Git(['show', 'HEAD:./'.l:fn], 'rightbelow vertical')
  let &l:filetype = l:ft
  execute 'silent file' l:fn '[HEAD]'
  diffthis
  autocmd BufWinLeave <buffer> diffoff!
  wincmd p
  diffthis
endf

fun! RunCmd(cmd, ...) abort
  let l:opt = get(a:000, 0, {})
  if !has_key(l:opt, 'cwd')
    let l:opt['cwd'] = fnameescape(expand('%:p:h'))
  endif
  let l:cmd = join(map(a:cmd, 'v:val !~# "\\v^[%#<]" || expand(v:val) == "" ? v:val : shellescape(expand(v:val))'))
  execute get(l:opt, "pos", "botright") "new"
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  nnoremap <buffer> q <c-w>c
  execute 'lcd' l:opt['cwd']
  execute '%!' l:cmd
endf

" Run cmd in terminal {{{1
fun! TerminalRun(cmd, ...) abort
  let l:bufnr = term_start(a:cmd, extend({
        \ 'cwd': expand('%:p:h'),
        \ 'term_rows': 20,
        \ }, get(a:000, 0, {})))
  return l:bufnr
endf

" Toggle wrap {{{1
fun! EnableSoftWrap()
  setlocal wrap
  map <buffer> j gj
  map <buffer> k gk
  echomsg "Soft wrap enabled"
endf

fun! DisableSoftWrap()
  setlocal nowrap
  if mapcheck("j") != ""
    unmap <buffer> j
    unmap <buffer> k
  endif
  echomsg "Soft wrap disabled"
endf

" Toggle soft-wrapped text in the current buffer.
fun! ToggleWrap()
  if &l:wrap
    call DisableSoftWrap()
  else
    call EnableSoftWrap()
  endif
endf

" Netrw {{{1
let g:netrw_banner = 0
let g:netrw_list_hide = '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$,db.sqlite3'
let g:netrw_list_hide .= ',__pycache__,.pyc$,node_modules,.git/,.cache,tags,Session.vim,venv'
let g:netrw_bufsettings = 'noswf noma nomod nu rnu nowrap ro nobl'
let g:netrw_sort_options = 'i'
nnoremap - :Ex<cr>
function! SearchNetrw(fname)
  if ! search('\V\^' . a:fname . '\$')
    call search('^' . substitute(a:fname, '\w\zs.*', '', '') . '.*\/\@<!$')
  endif
endfunction

" Commenting {{{1
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

" TabComplete {{{1
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

" Grep {{{1
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
set grepprg=rg\ --vimgrep
function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" Align {{{1
" https://vimrcfu.com/snippet/236
function! Align()
  '<,'>!column -t|sed 's/  \(\S\)/ \1/g'
  normal gv=
endfunction
xnoremap <silent> <F5> :<C-u>silent call Align()<CR>

" Better incremental search {{{1
" https://vimrcfu.com/snippet/38
set wildcharm=<C-z>
function! BetterIncSearch(key)
    if getcmdtype() == "/" || getcmdtype() == "?"
        if (a:key == "tab" && b:direction == "f") || (a:key == "stab" && b:direction == "b")
            return "\<CR>/\<C-r>/"
        elseif (a:key == "tab" && b:direction == "b") || (a:key == "stab" && b:direction == "f")
            return "\<CR>?\<C-r>/"
        endif
    else
        if a:key == "tab"
            return "\<C-z>"
        else
            return "\<S-Tab>"
        endif
    endif
endfunction

nnoremap / :let b:direction = "f"<CR>/
nnoremap ? :let b:direction = "b"<CR>?
nnoremap ø :let b:direction = "f"<CR>/
nnoremap Ø :let b:direction = "b"<CR>?
cnoremap <expr> <Tab>   BetterIncSearch("tab")
cnoremap <expr> <S-Tab> BetterIncSearch("stab")

noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

fu! HlSearch()
    let s:pos = match(getline('.'), @/, col('.') - 1) + 1
    if s:pos != col('.')
        call StopHL()
    endif
endfu

fu! StopHL()
    if !v:hlsearch || mode() isnot 'n'
        return
    else
        sil call feedkeys("\<Plug>(StopHL)", 'm')
    endif
endfu

augroup SearchHighlight
au!
    au CursorMoved * call HlSearch()
    au InsertEnter * call StopHL()
augroup end

" Color {{{1
if has('termguicolors') && $COLORTERM ==# 'truecolor'
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum" " Needed in tmux
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum" " Ditto
  set termguicolors
endif

hi clear
let g:colors_name = 'gh'

hi! link QuickFixLine Search
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link Conditional Statement
hi! link Define PreProc
hi! link Exception Statement
hi! link Macro PreProc
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link Warnings ErrorMsg
hi Normal ctermfg=235 ctermbg=231 cterm=NONE
hi CursorLine ctermfg=NONE ctermbg=230 cterm=NONE
hi CursorLineNr ctermfg=235 ctermbg=230 cterm=NONE
hi Folded ctermfg=243 ctermbg=254
hi LineNr ctermfg=247 ctermbg=NONE cterm=NONE
hi FoldColumn ctermfg=243 ctermbg=254 cterm=NONE
hi Terminal ctermfg=235 ctermbg=231 cterm=NONE
hi ColorColumn ctermfg=NONE ctermbg=254 cterm=NONE
hi Conceal ctermfg=28 ctermbg=NONE cterm=NONE
hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
hi CursorColumn ctermfg=NONE ctermbg=230 cterm=NONE
hi DiffAdd ctermfg=194 ctermbg=235 cterm=reverse
hi DiffChange ctermfg=230 ctermbg=235 cterm=reverse
hi DiffDelete ctermfg=224 ctermbg=235 cterm=reverse
hi DiffText ctermfg=220 ctermbg=235 cterm=reverse
hi Directory ctermfg=28 ctermbg=NONE cterm=NONE
hi EndOfBuffer ctermfg=231 ctermbg=NONE cterm=NONE
hi ErrorMsg ctermfg=124 ctermbg=231 cterm=reverse
hi IncSearch ctermfg=17 ctermbg=254 cterm=reverse
hi MatchParen ctermfg=NONE ctermbg=NONE cterm=bold,underline
hi ModeMsg ctermfg=235 ctermbg=NONE cterm=NONE
hi MoreMsg ctermfg=26 ctermbg=NONE cterm=NONE
hi NonText ctermfg=243 ctermbg=NONE cterm=NONE
hi Pmenu ctermfg=235 ctermbg=254 cterm=NONE
hi PmenuSbar ctermfg=235 ctermbg=243 cterm=NONE
hi PmenuSel ctermfg=231 ctermbg=247 cterm=NONE
hi PmenuThumb ctermfg=243 ctermbg=235 cterm=NONE
hi Question ctermfg=235 ctermbg=NONE cterm=NONE
hi Search ctermfg=26 ctermbg=254 cterm=reverse
hi SignColumn ctermfg=167 ctermbg=NONE cterm=NONE
hi SpecialKey ctermfg=167 ctermbg=NONE cterm=NONE
hi SpellBad ctermfg=92 ctermbg=NONE cterm=underline
hi SpellCap ctermfg=92 ctermbg=NONE cterm=underline
hi SpellLocal ctermfg=92 ctermbg=NONE cterm=underline
hi SpellRare ctermfg=92 ctermbg=NONE cterm=underline
hi Title ctermfg=17 ctermbg=NONE cterm=bold
hi Visual ctermfg=NONE ctermbg=254 cterm=NONE
hi VisualNOS ctermfg=NONE ctermbg=254 cterm=NONE
hi WarningMsg ctermfg=124 ctermbg=NONE cterm=NONE
hi StatusLine ctermfg=254 ctermbg=235 cterm=reverse
hi StatusLineNC ctermfg=254 ctermbg=243 cterm=reverse
hi TabLine ctermfg=243 ctermbg=254 cterm=NONE
hi TabLineFill ctermfg=243 ctermbg=254 cterm=NONE
hi TabLineSel ctermfg=235 ctermbg=254 cterm=NONE
hi VertSplit ctermfg=254 ctermbg=NONE cterm=NONE
hi WildMenu ctermfg=231 ctermbg=92 cterm=bold
hi Boolean ctermfg=26 ctermbg=NONE cterm=NONE
hi Character ctermfg=92 ctermbg=NONE cterm=NONE
hi Comment ctermfg=243 ctermbg=NONE
hi Constant ctermfg=26 ctermbg=NONE cterm=NONE
hi Debug ctermfg=92 ctermbg=NONE cterm=NONE
hi Delimiter ctermfg=17 ctermbg=NONE cterm=NONE
hi Error ctermfg=124 ctermbg=231 cterm=reverse
hi Float ctermfg=41 ctermbg=NONE cterm=NONE
hi Function ctermfg=92 ctermbg=NONE cterm=NONE
hi Identifier ctermfg=92 ctermbg=NONE cterm=NONE
hi Ignore ctermfg=166 ctermbg=NONE cterm=NONE
hi Include ctermfg=167 ctermbg=NONE cterm=NONE
hi Keyword ctermfg=124 ctermbg=NONE cterm=NONE
hi Label ctermfg=28 ctermbg=NONE cterm=NONE
hi Number ctermfg=17 ctermbg=NONE cterm=NONE
hi Operator ctermfg=124 ctermbg=NONE cterm=NONE
hi PreProc ctermfg=124 ctermbg=NONE cterm=NONE
hi Special ctermfg=28 ctermbg=NONE cterm=NONE
hi SpecialChar ctermfg=92 ctermbg=NONE cterm=NONE
hi SpecialComment ctermfg=92 ctermbg=NONE cterm=NONE
hi Statement ctermfg=124 ctermbg=NONE cterm=NONE
hi StorageClass ctermfg=166 ctermbg=NONE cterm=NONE
hi String ctermfg=17 ctermbg=NONE cterm=NONE
hi Structure ctermfg=166 ctermbg=NONE cterm=NONE
hi Todo ctermfg=124 ctermbg=NONE cterm=bold
hi Type ctermfg=166 ctermbg=NONE cterm=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
hi CursorIM ctermfg=NONE ctermbg=231 cterm=NONE
hi ToolbarLine ctermfg=243 ctermbg=254 cterm=NONE
hi ToolbarButton ctermfg=235 ctermbg=254 cterm=bold
hi NormalMode ctermfg=254 ctermbg=235 cterm=reverse
hi InsertMode ctermfg=254 ctermbg=28 cterm=reverse
hi ReplaceMode ctermfg=254 ctermbg=124 cterm=reverse
hi VisualMode ctermfg=254 ctermbg=17 cterm=reverse
hi CommandMode ctermfg=254 ctermbg=92 cterm=reverse
hi htmlTag ctermfg=235 ctermbg=NONE cterm=NONE
hi htmlEndTag ctermfg=235 ctermbg=NONE cterm=NONE
hi htmlTagName ctermfg=28 ctermbg=NONE cterm=NONE
hi htmlArg ctermfg=26 ctermbg=NONE cterm=NONE
hi djangoTagBlock ctermfg=235 ctermbg=NONE cterm=NONE
hi djangoVarBlock ctermfg=235 ctermbg=NONE cterm=NONE
hi djangoStatement ctermfg=28 ctermbg=NONE cterm=NONE
hi djangoFilter ctermfg=166 ctermbg=NONE cterm=NONE
hi SignifySignAdd ctermfg=28 ctermbg=NONE cterm=NONE
hi SignifySignDelete ctermfg=124 ctermbg=NONE cterm=NONE
hi SignifySignChange ctermfg=220 ctermbg=NONE cterm=NONE
hi diffRemoved ctermfg=124 ctermbg=NONE cterm=NONE
hi diffAdded ctermfg=28 ctermbg=NONE cterm=NONE
hi diffLine ctermfg=230 ctermbg=235 cterm=reverse
hi diffSubname ctermfg=230 ctermbg=235 cterm=reverse

" Init {{{1

EnableStatusLine

" Local settings
let s:vimrc_local = fnamemodify(resolve(expand('<sfile>:p')), ':h').'/vimrc_local'
if filereadable(s:vimrc_local)
  execute 'source' s:vimrc_local
else
  silent! colorscheme github
endif
