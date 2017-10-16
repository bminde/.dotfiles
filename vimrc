" Misc Settings {{{1
set enc=utf-8
set backspace=indent,eol,start
set clipboard^=unnamed    " use system clipboard
set diffopt+=vertical     " always use vertical diffs
set guicursor+=a:blinkon0 " turn of cursor blinking
set iskeyword+=-          " makes foo-bar considered one word
set path+=**              " search down into subfolders
let g:is_modern = v:version >= 800 || has('nvim')
" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1
" hide dotfiles by defautl - toggle with gh
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" ?
set mouse=a
set ttyfast
set ttymouse=xterm2
set ttyscroll=3
set noswapfile
set nowritebackup
set nrformats=            " treat 0-padded numbers as decimal, not octal
set pastetoggle=<F4>      " toggle paste
set scrolloff=8
set shiftround
set splitbelow            " open new split panes to right and bottom
set splitright
" Spaces & Tabs {{{1
set tabstop=2           " 2 space tab
set expandtab           " use spaces for tabs
set softtabstop=2       " 2 space tab
set shiftwidth=2
set sidescroll=1
set sidescrolloff=15
set modelines=1
filetype indent on
filetype plugin on
set autoindent
if g:is_modern
  set breakindent   " indent wrapped lines if supported (version > 800)
endif
" UI Layout {{{1
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
" GUI {{{1
if has("gui_macvim")
  " no toolbars, menu or scrollbars in the gui
  set guifont=source\ code\ pro\ for\ powerline:h14
  set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m  "no menu
  set guioptions-=t  "no toolbar
  set guioptions-=l
  set guioptions-=r  "no scrollbar
endif
" Searching {{{1
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
set smartcase
nnoremap å :nohlsearch<CR>
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" Folding {{{1
if has("folding")
  set foldmethod=indent   " fold based on indent level
  set foldnestmax=10      " max 10 depth
  set foldenable          " don't fold files by default on open
  set foldlevelstart=10   " start with fold level of 1
  nnoremap <CR> za
endif
" Completion {{{1
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <S-Tab> <c-n>
set pumheight=10             " completion window max size
" Line Shortcuts {{{1
nnoremap j gj       " Move vertically by visual line
nnoremap k gk
nnoremap gV `[v`]
" Leader Shortcuts {{{1
let mapleader=" "
" Switch between the last two files
nnoremap ,, <c-^>
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" nnoremap <leader>et :exec ":vsp /Users/dblack/notes/vim/" . strftime('%m-%d-%y') . ".md"<CR>
" Format the entire file
nmap <leader>fef ggVG=

" Delete trailing whitespace
nmap <leader>fw call Deletetrailingws()

" Source (reload configuration)
nmap <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Fast save
nnoremap ,w :w<CR>
nnoremap <leader>w :w<CR>

" Fast quit
nnoremap <Leader>q :q<CR>
nnoremap ,q :q<CR>

" Fast save and quit
nnoremap <Leader>x :x<CR>
nnoremap ,x :x<CR>

" Leader shortcuts for Rails commands
" map <Leader>m :Rmodel
" map <Leader>c :Rcontroller
" map <Leader>v :Rview
" map <Leader>u :Runittest
" map <Leader>f :Rfunctionaltest
" map <Leader>tm :RTmodel
" map <Leader>tc :RTcontroller
" map <Leader>tv :RTview
" map <Leader>tu :RTunittest
" map <Leader>tf :RTfunctionaltest
" map <Leader>sm :RSmodel
" map <Leader>sc :RScontroller
" map <Leader>sv :RSview
" map <Leader>su :RSunittest
" map <Leader>sf :RSfunctionaltest

" Mappings {{{1
" Remap 0 to first non-blank character
map 0 ^

" get rid of the ex mode
map q <nop>

" Jump to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Save with sudo
ca w!! w !sudo tee "%"

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Resize buffers
if bufwinnr(1)
  nmap ø <C-W><<C-W><
  nmap æ <C-W>><C-W>>
  nmap Æ <C-W>-<C-W>-
  nmap Ø <C-W>+<C-W>+
endif
" CtrlP {{{1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" ALE {{{1
"
" AutoGroups {{{1
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
  autocmd BufEnter *.py setlocal tabstop=4
  autocmd BufEnter *.md setlocal ft=markdown
augroup END

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  " ALE linting events
  " if g:has_async
  "   set updatetime=1000
  "   let g:ale_lint_on_text_changed = 0
  "   autocmd CursorHold * call ale#Lint()
  "   autocmd CursorHoldI * call ale#Lint()
  "   autocmd InsertEnter * call ale#Lint()
  "   autocmd InsertLeave * call ale#Lint()
  " endif
augroup END

" delete trailing white space on save
augroup whitespace
  autocmd bufwrite * silent call Deletetrailingws()
augroup END
" Testing {{{1
"
" Undo {{{1
if has('persistent_undo')
  silent !mkdir ~/.vim/undo > /dev/null 2>&1
  set undodir=~/.vim/undo
  set undofile
endif
" Vim Plug {{{1
" plug automatic installation {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}2
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tomasiser/vim-code-dark'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
  " ctrlp config {{{2
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    " let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
    let g:ctrlp_user_command = 'ag -Q -l --nocolor -g "" %s'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

    if !exists(":Ag")
      command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
      nnoremap \ :Ag<SPACE>
    endif
  endif
  nnoremap <Leader>p :CtrlP<CR>
  " if executable('ag')
  "   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " endif
  " }}}
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  " fzf config {{{2
  let g:fzf_files_options =
    \ '--reverse ' .
      \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
      nnoremap <C-o> :Files<cr>
      let $FZF_DEFAULT_COMMAND = 'ag -g "" --hidden'

  let branch_files_options = { 'source': '( git status --porcelain | awk ''{print $2}''; git diff --name-only HEAD $(git merge-base HEAD master) ) | sort | uniq'}
  let uncommited_files_options = { 'source': '( git status --porcelain | awk ''{print $2}'' ) | sort | uniq'}

  let s:diff_options =
    \ '--reverse ' .
    \ '--preview "(git diff --color=always master -- {} | tail -n +5 || cat {}) 2> /dev/null | head -'.&lines.'"'
  command! BranchFiles call fzf#run(fzf#wrap('BranchFiles',
        \ extend(branch_files_options, { 'options': s:diff_options }), 0))
  command! UncommitedFiles call fzf#run(fzf#wrap('UncommitedFiles',
        \ extend(uncommited_files_options, { 'options': s:diff_options }), 0))
  " nnoremap <silent> <leader>gp :BranchFiles<cr>
  " nnoremap <silent> <leader>GP :UncommitedFiles<cr>


  " nnoremap <leader>ga :Files app/<cr>
  " nnoremap <leader>gm :Files app/models/<cr>
  " nnoremap <leader>gv :Files app/views/<cr>
  " nnoremap <leader>gc :Files app/controllers/<cr>
  " nnoremap <leader>gy :Files app/assets/stylesheets/<cr>
  " nnoremap <leader>gj :Files app/assets/javascripts/<cr>
  " nnoremap <leader>gs :Files spec/<cr>

  function! s:all_help_files()
      return join(map(split(&runtimepath, ','), 'v:val ."\/doc\/tags"'), ' ')
    endfunction
    let full_help_cmd = "cat ". s:all_help_files() ." 2> /dev/null \| grep -i '^[a-z]' \| awk '{print $1}' \| sort"

    nnoremap <silent> <leader>he :Helptags<cr>
    " }}}
Plug 'kamwitsta/nordisk'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/vim-easy-align'
  " Easy Align - operators for aligning characters across lines {{{2
  command! ReformatTable normal vip<cr>**|
  nmap <leader>rt :ReformatTable<cr>
  vmap <cr> <Plug>(EasyAlign)
  " }}}
Plug 'kristijanhusak/vim-hybrid-material'
  " hybrid-material config {{{2
  let g:enable_bold_font = 1
  let g:enable_italic_font = 1
  " }}}
Plug 'lifepillar/vim-solarized8'
Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'
Plug 'nelstrom/vim-markdown-folding'    " folding based on md heading levels
Plug 'nelstrom/vim-visual-star-search'
Plug 'pbrisbin/vim-mkdir'
Plug 'rakr/vim-one'
Plug 'janko-m/vim-test'
  " vim-test config {{{2
  nnoremap <silent> <Leader>t :TestFile<CR>
  nnoremap <silent> <Leader>s :TestNearest<CR>
  nnoremap <silent> <Leader>l :TestLast<CR>
  nnoremap <silent> <Leader>a :TestSuite<CR>
  nnoremap <silent> <Leader>gt :TestVisit<CR>

  let test#strategy = 'vimux'
  " }}}
Plug 'rakr/vim-two-firewatch'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Nerdtree config {{{2
  map <leader>n :NERDTreeToggle<CR>
  let NERDTreeHighlightCursorline=0
  " expand/open with one click
  let NERDTreeMouseMode=3
  let NERDTreeRespectWildIgnore=1
  let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', '_build', '__pycache__', 'node_modules', 'dist']
  let g:NERDTreeWinSize = 30
  " }}}2
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
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
  " }}}
Plug 'tpope/vim-markdown'
  " vim-markdown config {{{2
  let g:markdown_fenced_languages = [
        \ 'sql',
        \ 'javascript',
        \ 'ruby',
        \ 'sh',
        \ 'yaml',
        \ 'javascript',
        \ 'html',
        \ 'vim',
        \ 'json',
        \ 'diff',
        \ 'css',
        \ 'scss',
        \ 'haskell',
        \ 'python'
        \ ]
  " }}}
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar' " navigate up a directory with '-' in netrw
Plug 'vim-scripts/SyntaxRange' " allow portions of a file to use different syntax
" Unused Plugins {{{2
" Plug 'w0rp/ale'
"   " let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
"   let g:ale_statusline_format = ['  ⨉ %d', ' ⚠ %d', '']
"   " Move between linting errors
"   noremap <leader>en :ALENextWrap<cr>
"   noremap <leader>ep :ALEPreviousWrap<cr>
call plug#end()
" Colors {{{1
syntax enable           " enable syntax processing
set bg=dark
if (has("termguicolors"))
  colorscheme two-firewatch
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  colorscheme gruvbox
endif
" Statusline {{{1
" hi vertsplit ctermfg=238 ctermbg=235
" hi LineNr ctermfg=237
" hi clear StatusLine
" hi StatusLine ctermfg=235 ctermbg=245
" hi StatusLineNC ctermfg=235 ctermbg=237
" hi Search ctermbg=58 ctermfg=15
" hi Default ctermfg=1
" hi clear SignColumn
" hi SignColumn ctermbg=235
" hi GitGutterAdd ctermbg=235 ctermfg=245
" hi GitGutterChange ctermbg=235 ctermfg=245
" hi GitGutterDelete ctermbg=235 ctermfg=245
" hi GitGutterChangeDelete ctermbg=235 ctermfg=245
" hi EndOfBuffer ctermfg=237 ctermbg=235

" set statusline=%=%P\ %f\ %m
" if g:is_modern
"   " set statusline+=\%{ALEGetStatusLine()}
" endif
" set fillchars=vert:\ ,stl:\ ,stlnc:\ "
" set laststatus=2
" set noshowmode

" Custom Functions {{{1
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" Delete trailing whitespace
func! Deletetrailingws()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endfunc

function! <SID>CleanFile()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %!git stripspace
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" Local config {{{1
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local

endif
" }}}
" vim:foldmethod=marker:foldlevel=0
