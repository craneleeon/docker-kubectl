set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'isRuslan/vim-es6'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/matchit.zip'
Plug 'christoomey/vim-sort-motion'
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'
Plug 'chrisbra/csv.vim'
Plug 'lervag/vimtex'
Plug 'mhinz/vim-startify'
Plug 'jparise/vim-graphql'
Plug 'airblade/vim-gitgutter'
Plug 'frazrepo/vim-rainbow'
Plug 'chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'wincent/ferret'
" Themes
Plug 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call plug#end()
" Put your non-Plugin stuff after this line

set shell=bash\ -i
set background=dark
colorscheme gruvbox "koehler
syntax on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2
set ruler
set nu
set relativenumber
set hlsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set pastetoggle=<F10>
set autoindent
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Code Folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
" pbcopy
set clipboard=unnamed

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:indentLine_setColors = 0
let g:indentLine_char = "┆"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = 'eslint'
let g:jsx_ext_required = 0
" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
" let g:multi_cursor_use_default_mapping=0

nnoremap <Leader><CR> :so ~/.vimrc<CR>
nnoremap <c-p> :GFiles<cr>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>try otry {<CR><CR>} catch (e) {<CR>console.log(e.stack)<CR>}<CR><esc>kkkkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
noremap <c-w>e :SyntasticCheck<cr> :SyntasticToggleMode<cr>

" devdocs.io
" nmap K <Plug>(devdocs-under-cursor)

" Move among buffers
nmap <c-L> :bn<CR>
nmap <c-H> :bp<CR>

" ctrlsf
" nnoremap <Leader>sf :CtrlSF

"=== YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_server_python_interpreter='python3'
let g:ycm_min_num_of_chars_for_completion = 2

" Tagbar
map <F6> :TagbarToggle<CR>

" rainbow
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" gitgutter
highlight clear SignColumn
" highlight SignColumn term=standout ctermfg=4
" let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    guifg=#00ff00 ctermfg=2
highlight GitGutterChange guifg=#0000ff ctermfg=3
highlight GitGutterDelete guifg=#ff0000 ctermfg=1

" Markdown
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" vimtex
let g:tex_flavor = 'latex'

" vim-go
let g:go_bin_path = "/Users/Crane/go/bin"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

" easymotion
" Move to word
nmap <Leader><Leader>w <Plug>(easymotion-w)

" Util functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh
  endif
endfunction

" Autocomletion & Goto navigation
function! GoCOC()
    inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()

    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <silent><expr> <C-space> coc#refresh()

    nmap <leader>gd <Plug>(coc-definition)
    nmap <leader>gy <Plug>(coc-type-definition)
    nmap <leader>gi <Plug>(coc-implementation)
    nmap <leader>gr <Plug>(coc-references)
    nmap <leader>rr <Plug>(coc-rename)
    nmap <leader>g[ <Plug>(coc-diagnostic-prev)
    nmap <leader>g] <Plug>(coc-diagnostic-next)
    nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
    nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
    nnoremap <leader>cr :CocRestart
endfunction

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
" beautify formats
autocmd FileType javascript vnoremap <buffer> <c-w>b :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-w>b :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-w>b :call RangeCSSBeautify()<cr>
autocmd FileType less vnoremap <buffer> <c-w>b :call RangeCSSBeautify()<cr>
" set indent by file types
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType yaml execute  ':silent! %s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
autocmd FileType * :call GoCOC()

" autocmd BufWritePre * :call TrimWhitespace()

filetype plugin on
