" SET COMMANDS
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc " execute vimrc in local directory if present; good for custom
set guicursor=
set relativenumber
set nu
set nohlsearch
set noerrorbells
set hidden " Allow buffers to be hidden on close instead of deloaded
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set cmdheight=2 " Give more space for displaying messages
set updatetime=100 " update the editor every 100 ms (def: 4000)

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
" Telescope requires plenary and $ ripgrep
Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
" LSP configuration from https://youtu.be/puWgHa7k3SY
" nvim-cmp and good QOL plugins
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
" LuaSnip and its additional friends
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
" Take Tuesday video introduces comment.nvim
Plug 'numToStr/Comment.nvim'
call plug#end()

" EDITOR MODIFIERS & LET COMMANDS
colorscheme gruvbox
highlight Normal guibg=none
let mapleader = " "

" Multifile requirements
lua require("setup")

" REMAPS
" mode lhs rhs
" nnoremap <- (N)ormal mode (NO R)ecursive (E)xecution (MAP)
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>

" AUTO COMMANDS
" Define functions
" define autogroup
augroup CMOORE
    autocmd!
    " I think I did this right
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
