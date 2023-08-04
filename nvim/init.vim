let mapleader=' '

set nocompatible
set number
set mouse=a
set backspace=indent,eol,start
set noshowmode
set cursorline
set showmatch
set cindent
set expandtab
set smarttab
set tabstop=2
set laststatus=2
set softtabstop=2
set shiftwidth=2
" set colorcolumn=81
set colorcolumn=101
set updatetime=300
set ma
set completeopt=menu,menuone,noselect
set spr
set sb
set clipboard=unnamedplus

hi Visual term=reverse cterm=reverse guibg=Grey

syntax enable

if !has('gui_running')
  set t_Co=256
endif

autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e
autocmd Filetype go setlocal noexpandtab
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  Plug 'mhinz/vim-startify'
  " Plug 'psliwka/vim-smoothie'
  " Plug 'Kazark/vim-SimpleSmoothScroll'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'

  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'Yggdroot/indentline'
  Plug 'ap/vim-css-color'
  Plug 'voldikss/vim-floaterm'
  Plug 'sheerun/vim-polyglot'
  Plug 'wuelnerdotexe/vim-astro'
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
  Plug 'kdheepak/lazygit.nvim'
  Plug 'vim-ruby/vim-ruby'

  " lsp-config
  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " colorscheme
  Plug 'franbach/miramare'
  Plug 'projekt0n/github-nvim-theme'
call plug#end()

" maps
nmap Q <Nop>
map <silent> <F4> :syntax sync fromstart<CR>
nnoremap <silent> <leader>g :GFiles<Cr>
nnoremap <silent> <leader>G :Files<Cr>
nnoremap <silent> <leader>p :Ag<Cr>
nnoremap <silent> <leader>t :tabnew<Cr>
nnoremap <silent> <leader>w :bdelete<Cr>
nnoremap <silent> <leader>f :BLines<Cr>
nnoremap <silent> <leader>j :Lexplore<Cr>
nnoremap <silent> <leader>T :W<Cr>
nnoremap <silent> <leader>; :Prettier<Cr>
nnoremap <silent> <leader>h :LazyGit<CR>

" coc.config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" end coc.config

cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
nmap n nzz
nmap N nzz
nmap ,p o<ESC>p

imap cll console.log()<Esc>==f(a
imap bbp binding.pry<Esc>==f(a

let g:miramare_disable_italic_comment = 1
let g:miramare_transparent_background = 1
let g:miramare_palette = {'light_grey': ['#808080', '245', 'LightGrey']}
colorscheme miramare

let g:ackprg = 'ag --vimgrep'

let g:indentLine_leadingSpaceChar = '•'
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1

let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \     'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-a': 'vsplit' }
let g:floaterm_keymap_toggle = '<F8>'
let g:floaterm_autoclose = 1
let g:oscyank_term = 'default'
let g:astro_typescript = 'enable'
