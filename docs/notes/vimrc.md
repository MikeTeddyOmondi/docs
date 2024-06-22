Vimrc for Nvim

```vim
" Plugin Loading

call plug#begin('~/.vim/plugged')
    " Plugin
    Plug 'morhetz/gruvbox'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'vim-airline/vim-airline'
    Plug 'jszakmeister/vim-togglecursor'
    Plug 'jmcantrell/vim-virtualenv'
    Plug 'tpope/vim-commentary'
    " Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ervandew/supertab'
    Plug 'w0rp/ale'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'yggdroot/indentline'
    Plug 'kien/ctrlp.vim'
    Plug 'slim-template/vim-slim'
    Plug 'stylelint/stylelint'
    Plug 'bmatcuk/stylelint-lsp'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
    Plug 'nlknguyen/copy-cut-paste.vim'
    Plug 'itchyny/lightline.vim' "Highlights lines
    Plug 'joshdick/onedark.vim' "The One Dark Theme
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim' "Fuzzy find plugin
    Plug 'junegunn/goyo.vim' "Removes Line numbers for focusing
    Plug 'mbbill/undotree' "Creates an undo tree
    Plug 'preservim/nerdtree' "File browser inside vim
    Plug 'godlygeek/tabular' "Auto formatting
    Plug 'plasticboy/vim-markdown' "Markdown syntax highlighting
    " Plug 'wakatime/vim-wakatime' "Wakatime tracker
    Plug 'ryanoasis/vim-devicons' "Cool icons for nerd tree
    Plug 'Xuyuanp/nerdtree-git-plugin' "nerd tree customization
    Plug '907th/vim-auto-save' "auto saves files as you edit
    Plug 'jdhao/better-escape.vim' "remaps esc key to jj
    Plug 'neoclide/coc.nvim', {'branch': 'release'} 
    Plug ''   
call plug#end()

" coc extensions
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-prettier',
            \ 'coc-jedi',
            \ 'coc-docker',
            \ 'coc-zls',
            \ 'coc-rust-analyzer',
            \ 'coc-sql',
            \ 'coc-svelte',
            \ ]

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors
let g:bargreybars_auto = 0

" 
colorscheme gruvbox
let g:gruvbox_termcolors=16

" Startup Settings
  syntax on
  let mapleader=" " "Maps Leader to space
  let NERDTreeShowHidden=1
  let g:auto_save = 1
  let g:auto_save_events = ["InsertLeave", "TextChanged"]
  let $FZF_DEFAULT_COMMAND = 'fdfind --type f --hidden --follow --exclude .git --ignore-file ~/.ignore'
  set mouse=a "Allows mouse usage inside vim. Great for noobs.
  set clipboard=unnamedplus "Remaps default copy paste to system clipboard
  set cursorline
  highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
    set noerrorbells
  set splitbelow splitright
    set tabstop=2 softtabstop=2
    set shiftwidth=2
    set expandtab
    set smartindent
  set nofoldenable
    set nowrap
    set smartcase
    set noswapfile
    set nobackup
    set incsearch
    set history=5000
    set nocompatible
  set number relativenumber
  colorscheme onedark 
  set background=dark
  set termguicolors
    filetype plugin on
    set encoding=utf-8
    set wildmenu
    set wildmode=longest,list,full
    set laststatus=2
    if !has('gui_running')
      set t_Co=256
    endif
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    set spell spelllang=en_us

" Plugin Shortcuts
    map <Leader>f :NERDTreeToggle<CR>
    map <C-\> :Goyo<CR>
  nnoremap <F5> :UndotreeToggle<CR> :UndotreeFocus<CR>
  nnoremap <C-f> :Files!<CR>
  nnoremap <Leader>l :Tabularize /
  let g:better_escape_shortcut = 'jj'
  let g:better_escape_interval = 250

" General Shortcuts
  nnoremap S :%s//g<Left><Left> 
  nmap <Leader>r :w<CR>:so %<CR>
  map <Leader>e $

" Persistent_undo
    set undodir=~/.vim/undodir"
    set undofile
    let g:undotree_WindowLayout = 2

" Tabedit keybinds
  nnoremap <Leader>1 1gt<CR>
  nnoremap <Leader>2 2gt<CR>
  nnoremap <Leader>3 3gt<CR>
  nnoremap <Leader>4 4gt<CR>
  nnoremap <Leader>5 5gt<CR>
  nnoremap <Leader>t :tabnew<CR>
  nnoremap <Leader>c :tabclose<CR>

" Markdown Edits
  let g:vim_markdown_autowrite = 1
  let g:vim_markdown_no_extensions_in_markdown = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_override_foldtext = 0
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_new_list_item_indent = 0

" Markdown auto format tables
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" Enter autocomplete coc 
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
```

Vimrc for Vim

```vim

```
