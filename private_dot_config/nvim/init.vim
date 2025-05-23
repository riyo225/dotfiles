" jj:insertmode to normalmode
imap jj <Esc>

set statusline^=%{coc#status()}
set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set hlsearch
syntax on
au BufWritePre * :%s/\(@<!\)\@<!^M//ge 
" xclip
set clipboard=unnamedplus

call plug#begin()
Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'Pocco81/auto-save.nvim'
Plug 'cohama/lexima.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <S-j> coc#pum#visible() ? coc#pum#next(1) : "\<S-j>"
inoremap <silent><expr> <S-k> coc#pum#visible() ? coc#pum#prev(1) : "\<S-k>"
inoremap <silent><expr> <S-i> coc#pum#visible() ? coc#pum#confirm() : "\<S-i>"
inoremap <silent><expr> <S-o> coc#pum#visible() ? coc#pum#confirm() : "\<S-o>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        }
    }
EOF

" vim-gitgutter
let g:gitgutter_highlight_lines = 1

" nerdtree
" " Start NERDTree when Vim is started without file arguments. 
autocmd StdinReadPre * let s:std_in=1 
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
nnoremap <C-n> :NERDTree<CR>

" vim-horizon 
" if you don't set this option, this color might not correct
set termguicolors

colorscheme horizon

" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'horizon' 

highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
highlight Folded ctermbg=none guibg=none
highlight EndOfBuffer ctermbg=none guibg=none

