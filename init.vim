" vim: foldmethod=marker
"---------------------------------------------------------------------------
" init.vim
"---------------------------------------------------------------------------
" Initialize:"{{{
"
augroup ReloadVimrc
    autocmd!
augroup END

""  base settings
set number
set relativenumber
set history=5000
set showmatch
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set title
set laststatus=2
set hlsearch incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set cursorline
set cursorcolumn
set splitbelow
set noswapfile
set wildmenu
set wildmode=full
set virtualedit=block
set mouse=a
set guifont=Ricty:h10

filetype plugin indent on
syntax enable

"" color settings
" https://vim-jp.org/vimdoc-ja/syntax.html#cterm-colors
"                                              cterm-colors
" NR-16   NR-8    COLOR NAME
" 0       0       Black
" 1       4       DarkBlue
" 2       2       DarkGreen
" 3       6       DarkCyan
" 4       1       DarkRed
" 5       5       DarkMagenta
" 6       3       Brown, DarkYellow
" 7       7       LightGray, LightGrey, Gray, Grey
" 8       0*      DarkGray, DarkGrey
" 9       4*      Blue, LightBlue
" 10      2*      Green, LightGreen
" 11      6*      Cyan, LightCyan
" 12      1*      Red, LightRed
" 13      5*      Magenta, LightMagenta
" 14      3*      Yellow, LightYellow
" 15      7*      White

colorscheme iceberg
set background=dark
highlight search cterm=NONE ctermfg=Black ctermbg=DarkCyan

" cursor move for command-line-mode
cnoremap <C-a> <Home>
" cursor move for normal-mode
nnoremap <C-j> }
nnoremap <C-k> {

" shortcut command for word replace
nnoremap <C-R><C-E> :%s;<C-R><C-W>;gc<Left><Left><Left>;
" don't move the cursor when used '*' command
noremap  * *N

" paste mode toggle
set pastetoggle=<F2>

" set leader key bind
let g:mapleader = "\<Space>"

" set clipboard
set clipboard^=unnamed,unnamedplus

" Turn off paste mode when leaving insert
autocmd ReloadVimrc InsertLeave * set nopaste

nnoremap <silent> <Leader>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Leader>tv :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Leader>rv :<C-u>source $MYVIMRC<CR>
"}}}

"---------------------------------------------------------------------------
" Plugin Loading:"{{{
"
call jetpack#begin()
"" for ui visual
call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('cocopon/iceberg.vim')
call jetpack#add('nvim-lualine/lualine.nvim')
call jetpack#add('akinsho/bufferline.nvim')
call jetpack#add('kyazdani42/nvim-web-devicons')

"" for operator function
call jetpack#add('tyru/caw.vim')
call jetpack#add('simeji/winresizer')
call jetpack#add('cohama/lexima.vim')
call jetpack#add('easymotion/vim-easymotion')
call jetpack#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call jetpack#add('junegunn/fzf.vim', { 'depends': 'fzf' })

call jetpack#end()
"}}}

"---------------------------------------------------------------------------
" Fern:"{{{
"
noremap <C-e> :<C-u>Fern . -drawer -toggle -keep -reveal=%<CR>
inoremap <C-e> <ESC>:<C-u>Fern . -drawer -toggle -keep -reveal=%<CR>

let g:fern#renderer = "nerdfont"
"}}}

"---------------------------------------------------------------------------
" Lualine:"{{{
"
lua << END
require('lualine').setup {
    options = { theme = 'material' }
}
END
"}}}

"---------------------------------------------------------------------------
" BufferLine:"{{{
"
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF
"}}}

"---------------------------------------------------------------------------
" CAW:"{{{
"
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
"}}}

"---------------------------------------------------------------------------
" WIN Resizer:"{{{
"
let g:winresizer_start_key = '<Leader><C-E>'
"}}}

"---------------------------------------------------------------------------
" EasyMotion:"{{{
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"}}}

"---------------------------------------------------------------------------
" Fzf:"{{{
"
" let g:fzf_command_prefix = 'Fzf'
noremap <Leader><C-p>      :<C-u>Buffers<CR>
noremap <Leader><C-l>      :<C-u>Files<CR>
noremap <Leader><C-a>      :<C-u>History<CR>

let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 }}

" - Command for Rg:{{{
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
"}}}

" - Likewise, Files command with preview window:{{{
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
"}}}
"}}}
