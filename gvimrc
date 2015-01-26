"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:   Yi Cheng
" Last change:  SUN, 29 Jan 2012
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32')
    cd D:\WorkPlace
    nmap <leader>cf :tabedit! $HOME/_gvimrc<CR>
    " when vimrc is edited, reload it
    autocmd! bufwritepost _gvimrc source $HOME/_gvimrc
else
    cd ~/WorkPlace/
    nmap <leader>cf :tabedit! ~/.gvimrc<CR>
    " when vimrc is edited, reload it
    autocmd! bufwritepost .gvimrc source ~/.gvimrc
endif
if has("mac")
    set guifont=GohuFont-Bold:h14
elseif has("win32")
    set guifont=gohufont-14:h9
    set lines=60 columns=120
else
    set guifont=GohuFont\ Bold
    set lines=60 columns=120
endif
" For GUI: remove or add -/+ T tool bar
set guioptions-=T
" For GUI: remove or add -/+ r right side scroll bar
set guioptions+=r
" For GUI: remove or add -/+ r top menu bar
set guioptions+=m
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set guitablabel=%N-%t
