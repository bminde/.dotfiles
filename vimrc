" settings
  set autoindent
  set autoread              " reload files (no local changes only)
  set autowrite             " Automatically :write before running commands
  set backspace=indent,eol,start  " Backspace works like in other apps
  set clipboard^=unnamed    " use system clipboard
  set diffopt+=vertical     " always use vertical diffs
  set expandtab
  set guicursor+=a:blinkon0 " turn of cursor blinking
  set history=50
  set hlsearch              " highlight found searches
  set ignorecase smartcase  " search case insensitive unless it begins with uppercase
  set incsearch             " do incremental searching
  set iskeyword+=-          " makes foo-bar considered one word
  set mouse=a
  set noswapfile
  set nowritebackup
  set nrformats=            " treat 0-padded numbers as decimal, not octal
  set number relativenumber
  set pastetoggle=<F4>      " toggle paste
  set scrolloff=8
  set shiftround
  set shiftwidth=2
  set sidescroll=1
  set sidescrolloff=15
  set splitbelow            " open new split panes to right and bottom
  set splitright
  set tabstop=2             " softtabs, 2 spaces
  set ttyfast               " mouse
  set ttymouse=xterm2
  set ttyscroll=3

  " folds
  if has("folding")
    set foldenable
    set foldmethod=indent
    set foldlevel=99
  endif

  " undo
  if has('persistent_undo')
    silent !mkdir ~/.vim/undo > /dev/null 2>&1
    set undodir=~/.vim/undo
    set undofile
  endif

  filetype plugin indent on

  " Switch syntax highlighting on, when the terminal has colors
  " Also switch on highlighting the last used search pattern.
  if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
  endif

  let g:has_async = v:version >= 800 || has('nvim')

  " When the type of shell script is /bin/sh, assume a POSIX-compatible
  " shell for syntax highlighting purposes.
  let g:is_posix = 1

  if g:has_async
    set breakindent   " indent wrapped lines if supported (version > 800)
  endif

  " Load matchit.vim, but only if the user hasn't installed a newer version.
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  endif

" autogroups
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

" mappings
  let mapleader = " "
  "
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

  " center on screen when searching and scrolling
  " nnoremap n nzzzv
  " nnoremap N Nzzzv
  " noremap <C-d> <C-d>zz
  " noremap <C-u> <C-u>zz

  " get rid of the ex mode
  map q <nop>

  " Clear the search buffer when hitting `å`
  nnoremap <silent> å :nohlsearch<cr>

  " Format the entire file
  nmap <leader>fef ggVG=

  " Delete trailing whitespace
  func! Deletetrailingws()
    exe 'normal mz'
    %s/\s\+$//ge
    exe 'normal `z'
  endfunc

  nmap <leader>fw call Deletetrailingws()

  " delete trailing white space on save
  augroup whitespace
    autocmd bufwrite * silent call Deletetrailingws()
  augroup end

  " zoom a vim pane, <C-w>= to re-balance
  nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
  nnoremap <leader>= :wincmd =<cr>

  " Remap 0 to first non-blank character
  map 0 ^

  " Resize buffers
  if bufwinnr(1)
    nmap ø <C-W><<C-W><
    nmap æ <C-W>><C-W>>
    nmap Æ <C-W>-<C-W>-
    nmap Ø <C-W>+<C-W>+
  endif

  " Move vertically by visual line
  nnoremap j gj
  nnoremap k gk

  " Switch between the last two files
  nnoremap ,, <c-^>

  " Source (reload configuration)
  nmap <leader>so :source $MYVIMRC<cr>
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

  " reselect pasted content:
  noremap gV `[v`]

  " Fast save
  nnoremap ,w :w<CR>
  nnoremap <leader>w :w<CR>

  " Fast quit
  nnoremap <Leader>q :q<CR>
  nnoremap ,q :q<CR>

  " Fast save and quit
  nnoremap <Leader>x :x<CR>
  nnoremap ,x :x<CR>

  " Edit .vimrc
  nnoremap <leader>ev :e $MYVIMRC<CR>

  " Run commands that require an interactive shell
  nnoremap <Leader>r :RunInInteractiveShell<space>

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

" gui
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

" plug automatic installation
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif

" plugins
  call plug#begin()
  Plug 'airblade/vim-gitgutter'
    if exists('&signcolumn')  " Vim 7.4.2201
      set signcolumn=yes
    else
      let g:gitgutter_sign_column_always = 1
    endif
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'cohama/lexima.vim'      " auto close parens, quotes, brackets
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
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
  Plug 'kamwitsta/nordisk'
  Plug 'arcticicestudio/nord-vim'
  Plug 'junegunn/vim-easy-align'
    " Easy Align - operators for aligning characters across lines
    command! ReformatTable normal vip<cr>**|
    nmap <leader>rt :ReformatTable<cr>
    vmap <cr> <Plug>(EasyAlign)
  Plug 'kristijanhusak/vim-hybrid-material'
    let g:enable_bold_font = 1
    let g:enable_italic_font = 1
  Plug 'lifepillar/vim-solarized8'
  Plug 'mattn/emmet-vim'
  Plug 'morhetz/gruvbox'
  Plug 'nelstrom/vim-markdown-folding'    " folding based on md heading levels
  Plug 'nelstrom/vim-visual-star-search'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'rakr/vim-one'
  Plug 'rakr/vim-two-firewatch'
  Plug 'sheerun/vim-polyglot'
  Plug 'SirVer/ultisnips'
    let g:UltiSnipsSnippetsDir='~/.vim/snippets'
    let g:UltiSnipsEditSplit='vertical'
    let g:UltiSnipsExpandTrigger           = '<S-Tab>'
    let g:UltiSnipsJumpForwardTrigger      = '<S-Tab>'
    let g:UltiSnipsJumpBackwardTrigger     = '<C-æ>'
    nnoremap <leader>ue :UltiSnipsEdit<cr>
  Plug 'sjl/gundo.vim'
    " gundo - visualize your undo tree
    nnoremap <F6> :GundoToggle<CR>
  Plug 'tomasr/molokai'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
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
  Plug 'tpope/vim-markdown'
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
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-vinegar' " navigate up a directory with '-' in netrw
    " hide dotfiles by defautl - toggle with gh
    let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
  Plug 'janko-m/vim-test'             " Run tests with varying granularity
    nnoremap <silent> <Leader>t :TestFile<CR>
    nnoremap <silent> <Leader>s :TestNearest<CR>
    nnoremap <silent> <Leader>l :TestLast<CR>
    nnoremap <silent> <Leader>a :TestSuite<CR>
    nnoremap <silent> <Leader>gt :TestVisit<CR>

    let test#strategy = 'vimux'
  Plug 'ctrlpvim/ctrlp.vim'
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
  Plug 'vim-scripts/SyntaxRange' " allow portions of a file to use different syntax
  Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    map <leader>n :NERDTreeToggle<CR>
    let NERDTreeHighlightCursorline=1
    " expand/open with one click
    let NERDTreeMouseMode=3
    let NERDTreeRespectWildIgnore=1
    let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', '_build', '__pycache__', 'node_modules', 'dist']
    let g:NERDTreeWinSize = 30
  " Plug 'w0rp/ale'
  "   " let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  "   let g:ale_statusline_format = ['  ⨉ %d', ' ⚠ %d', '']
  "   " Move between linting errors
  "   noremap <leader>en :ALENextWrap<cr>
  "   noremap <leader>ep :ALEPreviousWrap<cr>
  call plug#end()

" colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  set background=dark
  colorscheme two-firewatch

" statusline
  hi vertsplit ctermfg=238 ctermbg=235
  hi LineNr ctermfg=237
  hi clear StatusLine
  hi StatusLine ctermfg=235 ctermbg=245
  hi StatusLineNC ctermfg=235 ctermbg=237
  hi Search ctermbg=58 ctermfg=15
  hi Default ctermfg=1
  hi clear SignColumn
  hi SignColumn ctermbg=235
  hi GitGutterAdd ctermbg=235 ctermfg=245
  hi GitGutterChange ctermbg=235 ctermfg=245
  hi GitGutterDelete ctermbg=235 ctermfg=245
  hi GitGutterChangeDelete ctermbg=235 ctermfg=245
  hi EndOfBuffer ctermfg=237 ctermbg=235

  set statusline=%=%P\ %f\ %m
  if g:has_async
    " set statusline+=\%{ALEGetStatusLine()}
  endif
  set fillchars=vert:\ ,stl:\ ,stlnc:\ "
  set laststatus=2
  set noshowmode

" last
  " Local config
  if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local

  endif
