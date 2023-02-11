call plug#begin('~/.vim/plugged')

" leave some space in between
  Plug 'preservim/nerdtree'
  Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
  Plug 'sheerun/vim-polyglot'
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" we will add keybinds below this comment.

" NERDTree keybindings:
""Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" SpaceDuck
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme spaceduck


""Configure fonts
set encoding=UTF-8
set guifont=Hack\ Nerd\ Font\ 11
