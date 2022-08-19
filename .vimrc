set nocompatible              " be iMproved, required
filetype off                  " required

" First install vim-plug
let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin()
Plug 'vim-scripts/peaksea'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
call plug#end()

filetype plugin indent on

syntax on
set encoding=utf-8
set visualbell noerrorbells " don't beep
set hlsearch incsearch      " hightlight search and incremental search
set gdefault                " global replace by default
set nowrap                  " not wrap lines
set nu                      " show line numbers
set foldlevel=1             " default foldlevel 1 to see headings
set nobackup noswapfile     " stop backup and swap files
set nocompatible ignorecase smartcase
set nocindent noautoindent nosmartindent indentexpr= "disable autoindents
set tabstop=4 shiftwidth=4 expandtab "setup default tab/shift/expand
set showmode showcmd ttyfast
set guioptions=a            " hide scrollbars/menu/tabs
let mapleader = ","
let maplocalleader = ";"
set foldmethod=marker       " sets the fold method to {{{ }}} markers
set shortmess=atI           " disable welcome screen
set listchars=tab:\|\ ,trail:·,eol:¬
set nospell                 " disable spellcheck for code
set foldcolumn=0
set backspace=eol,start,indent " make backspace work as it should
set whichwrap+=<,>,h,l
set noshowmode

" Colorscheme
set background=dark
colorscheme peaksea

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Turn off search hl
set nohlsearch

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Persistant undo
try
    set undodir=~/.cache/vim/undodir
    set undofile
catch
endtry

" Open template file
map <leader>t :r ~/.dotfiles/vim/templates


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'absolutepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight clear SignColumn
let g:ale_linters = {
\   'python': ['flake8'],
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace', 'remove_trailing_lines'],
\   'sh': ['shfmt'],
\}

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

" Reformat long commands in history
function! FormatBashLine()
    silent! %s:\v\s+: :g
    " Iterative blocking for/while loops
    silent! %s:\v(^\s*)(.{-}%(while|for) .{-} do) (.*)done:\1\2\r\1    \3\r\1done:
    silent! %s:\v(^\s*)(.{-}%(while|for) .{-} do) (.*)done:\1\2\r\1    \3\r\1done:
    silent! %s:\v(^\s*)(.{-}%(while|for) .{-} do) (.*)done:\1\2\r\1    \3\r\1done:
    silent! %s:\v(^\s*)(.{-}%(while|for) .{-} do) (.*)done:\1\2\r\1    \3\r\1done:
    silent! %s:\v(^\s*)(.{-}%(while|for) .{-} do) (.*)done:\1\2\r\1    \3\r\1done:

    " Replace pipes
    silent! %s:\v(^(\s*).*)@<=(\|):\\\r\2\3:g

    " Break flags on long lines
    silent! g:^.\{70,\}:s:\v(^(\s*).*\s)@<=(--?):\\BREAK\2    \3:g
    silent! %s:BREAK:\r:g
    setf sh

endfunction


function! UnFormatBashLine()
    silent! %s:\\$::g
    silent! %s:\v\n\s*: :g 
    silent! %s: \{2,}: :
endfunction

map <buffer> <leader>v :call FormatBashLine()<CR>
map <buffer> <leader>q :call UnFormatBashLine() <bar> :wq <CR>
