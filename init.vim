let mapleader=" "
syntax on

set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu

set hlsearch
set incsearch
set ignorecase
set smartcase

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=''
set backspace=indent,eol,start
set foldmethod=indent
set laststatus=2
set autochdir
set scrolloff=5

map Q :q<CR>
map R :source $MYVIMRC<CR>

map sl :set splitright<CR>:vsplit<CR> "向右分屏
map sh :set nosplitright<CR>:vsplit<CR> "向左分屏 
map sk :set nosplitbelow<CR>:split<CR> "向上分屏
map sj :set splitbelow<CR>:split<CR> "向下分屏

map <LEADER>h <C-w>h "选择左分屏
map <LEADER>j <C-w>j "选择下分屏
map <LEADER>k <C-w>k "选择上分屏
map <LEADER>l <C-w>l "选择右分屏

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map tn :tabe<CR> "打开一个新标签页
map th :-tabnext<CR> "切换至前一个标签页
map tl :+tabnext<CR> "切换至后一个标签页

noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

call plug#begin('~/.vim/plugged')
" +++主题美化+++
Plug 'vim-airline/vim-airline' 
Plug 'rakr/vim-one'
" +++文件树装图+++
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
" +++代码补全+++
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi' "python
Plug 'ncm2/ncm2-pyclang' "C/C++
Plug 'ncm2/ncm2-go' "golang
Plug 'ncm2/ncm2-path' "Path
" +++依赖+++
Plug 'roxma/nvim-yarp'
call plug#end()

"===
"One.vim
"===
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set background=dark " for the dark version
colorscheme one

"===
"NerdTree
"===
map tt :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"设置树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"===
"NCM2
"===
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let ncm2#popup_delay = 5
let g:ncm2_jedi#python_version = 3
"用pip3安装一下pynvim和jeid

""""""""""""""""""""""
    "Quickly Run
    """"""""""""""""""""""
    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
        elseif &filetype == 'python'
            exec "!time python3 %"
        elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
        endif
    endfunc
