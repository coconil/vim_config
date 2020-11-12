call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/denite.nvim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'
Plug 'Raimondi/delimitMate'
Plug 'lambdalisue/gina.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'liuchengxu/vista.vim'
Plug 'Yggdroot/LeaderF'
call plug#end()

:let mapleader = " "

let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

let g:Lf_ShortcutF = '<leader>fF'
let g:Lf_ShortcutB = '<leader>bS'

noremap <silent> <leader>fd :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>fr :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>fc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>fT :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ff :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>fi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>fa :GscopeFind a<C-R><C-W><cr>

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gD <Plug>(coc-declaration)
nmap <silent><leader>gr <Plug>(coc-reference)

nmap <silent><leader>lr <Plug>(coc-rename)

nmap <silent><leader>en <Plug>(coc-diagnostic-next)
nmap <silent><leader>ep <Plug>(coc-diagnostic-prev)
nmap <silent><leader>ef <Plug>(coc-fix-current)
nmap <silent><leader>el :CocList diagnostics<CR>

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

nmap <silent><leader>gL :CocList -A outline<CR>
nmap <silent><leader>gl :Leaderf bufTag<CR>

nmap <silent><leader>ll :Vista coc<CR>
nmap <silent><leader>lL :Vista<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <silent><leader>bd :bd<CR>
nmap <silent><leader>bp :bp<CR>
nmap <silent><leader>bn :bn<CR>
nmap <silent><leader>bs :Denite buffer<CR>
nmap <silent><leader>bF <Plug>(coc-format)
vmap <silent><leader>bf <Plug>(coc-format-selected)


nmap <silent><leader>wl <C-w>l
nmap <silent><leader>wk <C-w>k
nmap <silent><leader>wj <C-w>j
nmap <silent><leader>wh <C-w>h
nnoremap <silent><leader>w- :split<CR>
nnoremap <silent><leader>w\ :vsplit<CR>
nnoremap <silent><leader>wd :close<CR>
nnoremap <silent><leader>wo :only<CR>

nnoremap <silent><leader>gh :Gina log<CR>
nnoremap <silent><leader>gs :Gina status<CR>

" nmap <leader>lR <Plug>(coc-refactor)
nnoremap <silent><leader>ft :Defx -split=vertical -winwidth=25 -direction=topleft <CR>


colorscheme space-vim-dark
set number
set guifont=Source\ Code\ Variable:h12


" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType defx call s:defx_my_setting()
function! s:defx_my_setting()
  silent! nunmap <buffer> <leader>
  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s
  
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> h defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> l defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Cr> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> R defx#do_action('call', 'DefxChangeRoot')
endfunction

function! DefxChangeRoot(_)
let filepath = defx#get_candidate()['action__path']
return defx#call_action('cd', [filepath])
endfunction

function! DefxSmartL(_)
  if defx#is_directory()
       call defx#call_action('open_or_close_tree')
  else
    call defx#call_action('drop')
  endif
endfunction

function! DefxSmartH(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
  return defx#call_action('cd', ['..'])
  endif
  return defx#call_action('close_tree')
endfunction

let g:airline_theme='onedark'

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
let g:vista#renderer#enable_icon = 1
set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:gutentags_project_root = []
let g:gutentags_project_root = ['compile_flags.txt','.ccls','compile_commands.json']
let g:gutentags_exclude_project_root = ['.git']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_add_default_project_roots = 0

