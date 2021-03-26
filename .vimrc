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

" Statusline
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

" Semi-persistent undo
set backupdir=/tmp//,.
set directory=/tmp//,.
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
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

" Mappings {{{1
nnoremap gb :ls<CR>:b<Space>
nnoremap <space>p :find *
if isdirectory('.git')
  nnoremap ,f :GitFind *
else
  nnoremap ,f :Find *
endif
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

" Autocmds {{{1
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

" Netrw {{{1
let g:netrw_banner = 0
let g:netrw_list_hide = '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
let g:netrw_list_hide .= ',__pycache__,.pyc$,node_modules,.git/,.cache,tags,Session.vim'
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

" GitFind  {{{1
" https://vi.stackexchange.com/a/2589
function! GitFindComplete(ArgLead, CmdLine, CursorPos)
  let search_pattern = "*" . a:ArgLead . "*"
  let shell_cmd = "git ls-files " . shellescape(search_pattern)
  return split(system(shell_cmd), "\n")
endfunction
command! -nargs=1 -bang -complete=customlist,GitFindComplete GitFind edit<bang> <args>

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

" Theme {{{1
" Name:        photon.vim
" Author:      Alex Vear <av@axvr.io>
" Webpage:     https://github.com/axvr/photon.vim
" Description: An elegant, dark colour scheme with minimal syntax highlighting
" Licence:     MIT (2019)
" Last Change: 2020-12-24

hi clear
if exists("syntax_on")
  syntax reset
endif
" let colors_name = "photon"
hi Normal ctermbg=235 ctermfg=251 cterm=NONE guibg=#262626 guifg=#c6c6c6 gui=NONE
set background=dark
hi NonText ctermbg=bg ctermfg=238 cterm=NONE guibg=bg guifg=#444444 gui=NONE
hi Comment ctermbg=bg ctermfg=241 cterm=NONE guibg=bg guifg=#626262 gui=NONE
hi Conceal ctermbg=bg ctermfg=241 cterm=NONE guibg=bg guifg=#626262 gui=NONE
hi Constant ctermbg=bg ctermfg=140 cterm=NONE guibg=bg guifg=#af87d7 gui=NONE
hi Identifier ctermbg=bg ctermfg=251 cterm=NONE guibg=bg guifg=#c6c6c6 gui=NONE
hi Statement ctermbg=bg ctermfg=243 cterm=NONE guibg=bg guifg=#767676 gui=NONE
hi Operator ctermbg=bg ctermfg=251 cterm=NONE guibg=bg guifg=#c6c6c6 gui=NONE
hi PreProc ctermbg=bg ctermfg=243 cterm=NONE guibg=bg guifg=#767676 gui=NONE
hi Type ctermbg=bg ctermfg=251 cterm=NONE guibg=bg guifg=#c6c6c6 gui=NONE
hi Special ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
hi Error ctermbg=NONE ctermfg=132 cterm=NONE guibg=NONE guifg=#af5f87 gui=NONE
hi Warning ctermbg=NONE ctermfg=179 cterm=NONE guibg=NONE guifg=#d7af5f gui=NONE
hi ModeMsg ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
hi Todo ctermbg=NONE ctermfg=167 cterm=bold guibg=NONE guifg=#d75f5f gui=bold
hi Underlined ctermbg=NONE ctermfg=251 cterm=underline guibg=NONE guifg=#c6c6c6 gui=underline
hi StatusLine ctermbg=237 ctermfg=140 cterm=NONE guibg=#3a3a3a guifg=#af87d7 gui=NONE
hi StatusLineNC ctermbg=236 ctermfg=243 cterm=NONE guibg=#303030 guifg=#767676 gui=NONE
hi WildMenu ctermbg=236 ctermfg=167 cterm=NONE guibg=#303030 guifg=#d75f5f gui=NONE
hi VertSplit ctermbg=236 ctermfg=236 cterm=NONE guibg=#303030 guifg=#303030 gui=NONE
hi Title ctermbg=NONE ctermfg=251 cterm=bold guibg=NONE guifg=#c6c6c6 gui=bold
hi LineNr ctermbg=NONE ctermfg=241 cterm=NONE guibg=NONE guifg=#626262 gui=NONE
hi CursorLineNr ctermbg=236 ctermfg=140 cterm=NONE guibg=#303030 guifg=#af87d7 gui=NONE
hi Cursor ctermbg=140 ctermfg=251 cterm=NONE guibg=#af87d7 guifg=#c6c6c6 gui=NONE
hi CursorLine ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
hi ColorColumn ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
hi SignColumn ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
hi Visual ctermbg=237 ctermfg=NONE cterm=NONE guibg=#3a3a3a guifg=NONE gui=NONE
hi VisualNOS ctermbg=238 ctermfg=NONE cterm=NONE guibg=#444444 guifg=NONE gui=NONE
hi Pmenu ctermbg=237 ctermfg=NONE cterm=NONE guibg=#3a3a3a guifg=NONE gui=NONE
hi PmenuSbar ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
hi PmenuSel ctermbg=236 ctermfg=140 cterm=NONE guibg=#303030 guifg=#af87d7 gui=NONE
hi PmenuThumb ctermbg=167 ctermfg=NONE cterm=NONE guibg=#d75f5f guifg=NONE gui=NONE
hi FoldColumn ctermbg=NONE ctermfg=241 cterm=NONE guibg=NONE guifg=#626262 gui=NONE
hi Folded ctermbg=234 ctermfg=243 cterm=NONE guibg=#1c1c1c guifg=#767676 gui=NONE
hi SpecialKey ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
hi IncSearch ctermbg=167 ctermfg=235 cterm=NONE guibg=#d75f5f guifg=#262626 gui=NONE
hi Search ctermbg=140 ctermfg=235 cterm=NONE guibg=#af87d7 guifg=#262626 gui=NONE
hi Directory ctermbg=NONE ctermfg=140 cterm=NONE guibg=NONE guifg=#af87d7 gui=NONE
hi MatchParen ctermbg=NONE ctermfg=167 cterm=bold guibg=NONE guifg=#d75f5f gui=bold
hi SpellBad ctermbg=NONE ctermfg=132 cterm=underline guibg=NONE guifg=#af5f87 gui=underline
hi SpellCap ctermbg=NONE ctermfg=108 cterm=underline guibg=NONE guifg=#87af87 gui=underline
hi SpellLocal ctermbg=NONE ctermfg=179 cterm=underline guibg=NONE guifg=#d7af5f gui=underline
hi QuickFixLine ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
hi DiffAdd ctermbg=236 ctermfg=108 cterm=NONE guibg=#303030 guifg=#87af87 gui=NONE
hi DiffChange ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
hi DiffDelete ctermbg=236 ctermfg=132 cterm=NONE guibg=#303030 guifg=#af5f87 gui=NONE
hi DiffText ctermbg=236 ctermfg=179 cterm=NONE guibg=#303030 guifg=#d7af5f gui=NONE
hi helpHyperTextJump ctermbg=bg ctermfg=140 cterm=NONE guibg=bg guifg=#af87d7 gui=NONE
hi! link Character Constant
hi! link Number Constant
hi! link Float Number
hi! link Boolean Constant
hi! link String Constant
hi! link Function Identifier
hi! link Conditonal Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Keyword Statement
hi! link Exception Statement
hi! link Include PreProc
hi! link Define PreProc
hi! link Macro PreProc
hi! link PreCondit PreProc
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type
hi! link SpecialChar Special
hi! link Tag Special
hi! link Delimiter Special
hi! link SpecialComment Special
hi! link Debug Special
hi! link ErrorMsg Error
hi! link WarningMsg Warning
hi! link MoreMsg ModeMsg
hi! link Question ModeMsg
hi! link Ignore NonText
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabLineSel StatusLine
hi! link CursorColumn CursorLine
hi! link SpellRare SpellLocal
hi! link diffAdded DiffAdd
hi! link diffRemoved DiffDelete
hi! link htmlTag htmlTagName
hi! link htmlEndTag htmlTag
hi! link gitcommitSummary Title
