" INSTALL VIM PLUG IF IT DOESNT EXIST
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" INSTALL THE REST OF THE PLUGINS
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'francoiscabrol/ranger.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'rbgrouleff/bclose.vim'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/deoplete-phpactor'
Plug 'ap/vim-buftabline'
call plug#end()

" GENERAL SETTINGS
set nocompatible
syntax enable
filetype plugin on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set number relativenumber
set mouse=a
let mapleader=','
set t_CO=256
set noerrorbells visualbell t_vb=
set splitright
set splitbelow
set wildmenu
set path+=**
set hidden
set nobackup
set nowritebackup

" THEME STUFF
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material
let g:material_theme_style = "default"
let g:material_terminal_italics = 1
let g:lightline = {'colorscheme': 'material_vim'}

" KEY MAPPINGS
" FUZZY SEARCH
nnoremap <silent> <c-p> :FZF<cr>
" FILE BROWSER
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
nnoremap <silent> <c-b> :RangerWorkingDirectory<cr>
nnoremap <silent> <c-n> :RangerCurrentFile<cr>
" COMMENTING
let g:NERDSpaceDelims = 1
nmap <c-_>   <Plug>NERDCommenterToggle
vmap <c-_>   <Plug>NERDCommenterToggle<cr>gv
" TABS
nmap <silent> <c-w> :bd<cr>
nmap <silent> <tab> :bn<cr>
nmap <silent> <s-tab> :bp<cr>
" AUTO COMPLETION
let g:deoplete#enable_at_startup = 1
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" AUTO COMMANDS
" AUTO SOURCE VIMRC ON SAVE
augroup autosourcing
    autocmd!
    autocmd BufWritePost $MYVIMRC source %
augroup END
" LINE NUMBER TOGGLING
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

