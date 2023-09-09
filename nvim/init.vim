let mapleader=' '

set nocompatible
set number relativenumber
set nu rnu
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
set autoread

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  " Plug 'nvim-lualine/lualine.nvim'
  Plug 'mhinz/vim-startify'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'

  Plug 'airblade/vim-gitgutter'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'slim-template/vim-slim'
  Plug 'ojroques/vim-oscyank', { 'branch': 'main' }
  Plug 'kdheepak/lazygit.nvim'
  Plug 'vim-ruby/vim-ruby'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'rcarriga/nvim-notify'
  Plug 'windwp/nvim-autopairs'
  Plug '0x00-ketsu/markdown-preview.nvim'

  " lsp-config
  Plug 'neovim/nvim-lspconfig'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " colorscheme
  Plug 'dotsilas/darcubox-nvim'
call plug#end()

hi Visual term=reverse cterm=reverse guibg=Grey

syntax enable

if !has('gui_running')
  set t_Co=256
endif

au CursorHold * checktime
autocmd InsertEnter * norm zz
autocmd BufWritePre * %s/\s\+$//e
autocmd Filetype go setlocal noexpandtab
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" maps
nmap Q <Nop>
nnoremap <silent> <leader>g <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>p <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>T <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>f <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent> <leader>t :tabnew<Cr>
nnoremap <silent> <leader>q :bdelete<Cr>
nnoremap <silent> <leader>j :Lexplore<Cr>
nnoremap <silent> <leader>; :Prettier<Cr>
nnoremap <c-k> <c-v>

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

colorscheme darcubox

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
let g:oscyank_term = 'default'
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
     execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Lua config
lua << EOF
  local actions = require("telescope.actions")
  vim.notify = require('notify')
  require('notify').setup({
    background_colour = "#000000";
  })

  require("telescope").setup({
      defaults = {
          mappings = {
              i = {
                  ["<esc>"] = actions.close,
                  ["<C-a>"] = actions.select_vertical,
              },
          },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
  })
  require('telescope').load_extension('fzf')

  require('nvim-treesitter.configs').setup {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }

  require('nvim-autopairs').setup {
    map_cr = false,
  }

  require('markdown-preview').setup {}
EOF
