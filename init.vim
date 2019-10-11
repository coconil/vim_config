call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/denite.nvim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-signify'
call plug#end()

:let mapleader = " "
nmap <silent><leader>ld <Plug>(coc-definition)
nmap <silent><leader>lr <Plug>(coc-reference)
nmap <silent><leader>lf <Plug>(coc-format-selected)
nmap <silent><leader>le <Plug>(coc-diagnostic-next)
nmap <silent><leader>lF <Plug>(coc-fix-current)

nmap <silent><leader>bd :bd<CR>
nmap <silent><leader>bs :Denite buffer<CR>
nmap <silent><leader>ff :Denite file/rec<CR>

" nmap <leader>lR <Plug>(coc-refactor)
nnoremap <silent><leader>ft :Defx -split=vertical -winwidth=30 -direction=topleft <CR>


colorscheme space-vim-dark
set number
set guifont=Source\ Code\ Variable:h12