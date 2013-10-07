"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:   Yi Cheng
" Last change:  SUN, 29 Jan 2012
"
"sections:
"    -> command mode related
"    -> moving around, tabs and buffers
"    -> statusline
"    -> parenthesis/bracket expanding
"    -> general Abbrevs
"    -> editing mappings
"    -> cope
"    -> minibuffer plugin
"    -> omni complete functions
"    -> Syntax
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set pathogen
call pathogen#infect()
"Set terminal color
set t_Co=256
"change to work place
cd ~/Ubuntu\ One/WorkPlace/
" use vim settings, rather than Vi settings (much better!).
set nocompatible
"Enable filetype plugin
filetype plugin indent on
" fast editing of the .vimrc
if has("win32")
    nmap <leader>cf :tabedit! C:\Program Files (x86)\Vim\_vimrc<CR>
    " when vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source $VIM/.vimrc
else
    nmap <leader>cf :tabedit! ~/.vimrc<CR>
    " when vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif
" sets how many lines of history VIM has to remember
set history=100
" set to auto read when a file is changed from the outside
set autoread
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif
"Set encoding
set encoding=utf-8
"Set file encodings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
"Set file formats
set ffs=unix,mac,dos
"Inserting unicod char, <C-v>u follow by 4 digit hex code
set listchars=tab:▸\ ,eol:¬
"Set suffixesadd
"set suffixesadd+=.rb,.py,.js
"Excute without !
set hidden
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn on wild menu
set wildmenu
set wildmode=list
"Always show current position
set ruler
"Search options
"Do incremental searching
set incsearch
"Ignore case when searching
set ignorecase
"Smartcast
set smartcase
"Highlight search things
set hlsearch
"Set magic on. for regular expressions
set magic
"Show matching bracets when text indicator is over them
set showmatch
set mat=2
"Display incomplete commands
set showcmd
"No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set cursorline
"Set line numbers
set nu
"Set initial size
set lines=60 columns=120
"remove highlight serch results
noremap <C-u> :nohl<CR>
vnoremap <C-u> :nohl<CR>
inoremap <C-u> :nohl<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets color scheme for vim
colorscheme molokai
let g:molokai_original = 1
"Enable syntax highlights
syntax enable
"Set gui font and size
set guifont=GohuFont\ Bold
" For GUI: remove or add -/+ T tool bar
set guioptions-=T
" For GUI: remove or add -/+ r right side scroll bar
set guioptions+=r
" For GUI: remove or add -/+ r top menu bar
set guioptions+=m
language message en_US.utf-8
set ambiwidth=double
set lazyredraw
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"show extra whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=lightblue
highlight ExtraWhitespace ctermbg=red guibg=lightblue
au InsertLeave,InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"Invisible character colors
highlight NonText guifg=#ff6666 "eol
highlight SpecialKey guifg=#ff6666 "tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn off auto backup
set nobackup
"Turn off write backup
set nowb
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use space instead of tab
set expandtab
"Next indented step
set shiftwidth=4
"Actual tab columns in the system
set tabstop=4
"Columns insert mode if tab key is pressed
set softtabstop=4
set smarttab
set wrap
set lbr
set textwidth=0
set wrapmargin=0
set autoindent
set smartindent
set fo+=t
if has("autocmd")
    " Customisations based on language
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType c setlocal ts=4 sts=4 sw=4 noexpandtab
    " Treat .rss file as XML
    " autocmd BufNewFile,BufRead *.rss setfiletype xml
endif
" Converting between tabs and spaces
" spaces to tab -> set noexpandtab, retab!
" tab to spaces -> set expandtab, retab!
" Strip white spaces -> %s/\s\+$//e
" Strip white lines -> g/^$/d
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Show current full path
cnoremap <expr>%% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tab configuration
map <leader>tn :browse tabnew<CR>
map <leader>tc :tabclose<CR>
"map <leader>pr <esc>:tabprevious<CR>
"map <leader>nt <esc>:tabnext<CR>
map <leader>te :tabedit
map <leader>tm :tabmove
map <leader>e :browse edit<CR>
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
if has("gui_mac")
    " For mac users (using the 'apple' key)
    nmap <D-1> 1gt
    nmap <D-2> 2gt
    nmap <D-3> 3gt
    nmap <D-4> 4gt
    nmap <D-5> 5gt
    nmap <D-6> 6gt
    nmap <D-7> 7gt
    nmap <D-8> 8gt
    nmap <D-9> 9gt
    nmap <D-0> :tablast<CR>
    nmap <D-j> gj
    nmap <D-k> gk
    vmap <D-j> gj
    vmap <D-k> gk
else
    " for linux and windows users (using the Alt key)
    nmap <M-1> 1gt
    nmap <M-2> 2gt
    nmap <M-3> 3gt
    nmap <M-4> 4gt
    nmap <M-5> 5gt
    nmap <M-6> 6gt
    nmap <M-7> 7gt
    nmap <M-8> 8gt
    nmap <M-9> 9gt
    nmap <M-0> :tablast<CR>
    nmap <M-j> gj
    nmap <M-k> gk
    vmap <M-j> gj
    vmap <M-k> gk
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ "buffer number
set statusline+=%F\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileencoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=Current:%l-%c
"statusline color
highlight StatusLine guifg=#3E3D32 guibg=white
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap sq <esc>`>a"<esc>`<i"<esc>
vnoremap dq <esc>`>a'<esc>`<i'<esc>
vnoremap $a <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap sq ''<esc>i
inoremap dq ""<esc>i
inoremap $a <><esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Show current date <key> <command>
iab showdate <C-r>=strftime("%a, %d %b, %Y")<CR>
noremap <leader>py :!python %<cr>
noremap <leader>pya :!python "%"<space>
noremap <leader>sh :write ! bash<cr>
noremap <leader>sha :write ! bash<space>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CTRL-SHIFT-X and SHIFT-Del are Cut
vnoremap <C-S-x> "+x
"CTRL-SHIFT-C and CTRL-Insert are Copy
vnoremap <C-S-c> "+y
" CTRL-V and SHIFT-Insert are Paste
"map <C-S-v> "+gP
"Set show invisible characters
nmap <leader>l :set list!<CR>
" CTRL-A is Select all
"noremap <C-A> gggH<C-O>G
"inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G
"onoremap <C-A> <C-C>gggH<C-O>G
"snoremap <C-A> <C-C>gggH<C-O>G
"xnoremap <C-A> <C-C>ggVG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the 'cpoptions' to its Vim default
"if 1    " only do this when compiled with expression evaluation
"  let s:save_cpo = &cpoptions
"endif
"set cpo&vim
"map <leader>cc :botright cope<CR>
"map <leader>n :cn<CR>
"map <leader>p :cp<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => bufExpolorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
" => Spell checking
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<CR>
"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" => winmanger
let g:winManagerWidth=30
let g:persistentBehaviour=0
let g:NERDTree_title='[NERD Tree]'
let g:winManagerWindowLayout='NERDTree|TagList'
function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction
nmap wm :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>
nmap <F10> :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>
" => NERDTree
let g:NERDTreeShowBookmarks=1
" => Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=0
let Tlist_Show_Menu=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
"au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
"au FileType python map <buffer> <leader>1 /class
"autocmd FileType python compiler pylint
"let g:pylint_onwrite = 0
"let g:pylint_show_rate = 0
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight=0
"Uncomment this if writing in jquery instead of javascript
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"nginx file in particular, path might need to be amemded
"au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx
" alert html file for htmldjango
"au BufRead,BufNewFile *.html set ft=htmldjango syntax=htmldjango
