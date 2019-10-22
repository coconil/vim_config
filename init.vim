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
call plug#end()

:let mapleader = " "
nmap <silent><leader>ld <Plug>(coc-definition)
nmap <silent><leader>lr <Plug>(coc-reference)
map <silent><leader>lf <Plug>(coc-format-selected)
nmap <silent><leader>le <Plug>(coc-diagnostic-next)
nmap <silent><leader>lF <Plug>(coc-fix-current)
" nmap <silent><leader>ll <Plug>(coc-list-outline)
nmap <silent><leader>ll :CocList -A outline<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent><leader>bd :bd<CR>
nmap <silent><leader>bs :Denite buffer<CR>
nmap <silent><leader>ff :Denite file/rec<CR>
nmap <silent><leader>wl <C-w>l
nmap <silent><leader>wk <C-w>k
nmap <silent><leader>wj <C-w>j
nmap <silent><leader>wh <C-w>h

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
    call defx#call_action('open_tree')
    normal! j
  else
    call defx#call_action('drop')
  endif
endfunction

function! DefxSmartH(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  else 
  call defx#call_action('close_tree')
  endif
endfunction

let g:airline_theme='onedark'





