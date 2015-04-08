"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:   Yi Cheng
" Last change:  SUN, 29 Jan 2012
"
"sections:
"    -> General
"    -> Vim user interface
"    -> Color and Fonts
"    -> Files and backups
"    -> Text, tab, and indent
"    -> Command mode
"    -> Moving around, tabs and buffer
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"    -> Cope
"    -> Omni complete function
"    -> Plugin
"    -> Syntax
"    -> Slef defined functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use vim settings, rather than Vi settings (much better!).
set nocompatible
" Required Vundle setup
filetype off
if has('win32')
    set runtimepath+=$HOME/vimfiles/bundle/Vundle.vim
else
    set runtimepath+=~/.vim//bundle/Vundle.vim
endif
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'fs111/pydoc.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
call vundle#end()
"Enable filetype plugin
filetype plugin indent on
" fast editing of the .vimrc
if has('win32')
    nmap <leader>cf :tabedit! $HOME/_vimrc<CR>
    " when vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source $HOME/_vimrc
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
set wildmode=list:longest
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
"remove highlight serch results
noremap <C-u> :nohl<CR>
vnoremap <C-u> :nohl<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets color scheme for vim
colorscheme molokai
let g:molokai_original = 1
"Enable syntax highlights
syntax enable
language message en_US.utf-8
set ambiwidth=double
set lazyredraw
"show extra whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=lightblue
highlight ExtraWhitespace ctermbg=red guibg=lightblue
highlight OverLength ctermbg=red guibg=#592929
" show OverLength character except text file
au InsertLeave,InsertEnter * if &ft != 'text' | match OverLength /\%>79v.\+/
" show extra white space
au InsertLeave,InsertEnter * 2match ExtraWhitespace /\s\+\%#\@<!$/
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
" Customisations based on language
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 noexpandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType c setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
" Treat .rss file as XML
" autocmd BufNewFile,BufRead *.rss setfiletype xml
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
if has('mac')
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
" Set status line at second-last line
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ "buffer number
set statusline+=%F\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, "filetype
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
imap <C-S-v> <ESC>"+gP
nmap <C-S-v> <ESC>"+gP
"Set show invisible characters
nmap <leader>l :set list!<CR>
" Set goto file
"map gf :tabnew <cfile><CR>
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
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

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
nmap <F2> :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>
" => NERDTree
let g:NERDTreeShowBookmarks=1
" => Taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=0
let Tlist_Show_Menu=1
if has("mac")
    let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
elseif has("win32")
    let Tlist_Ctags_Cmd=$HOME.'/vimfiles/ctags58/ctags'
endif
" YCM
let g:ycm_collect_identifiers_from_tags_files=1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer=1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax=1 " Completion for programming language's keyword
let g:ycm_complete_in_comments=1 " Completion in comments
let g:ycm_complete_in_strings=1 " Completion in string
" Ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set plain text syntax
au FileType text set syntax=asciidoc
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
autocmd FileType python nnoremap <buffer> <F3> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType ruby nnoremap <buffer> <F3> :exec '!ruby' shellescape(@%, 1)<cr>
" Set make to run python as compiler
" au FileType python syn keyword pythonDecorator True None False self
"Uncomment this if writing in jquery instead of javascript
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"nginx file in particular, path might need to be amemded
"au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx
" alert html file for htmldjango
"au BufRead,BufNewFile *.html set ft=htmldjango syntax=htmldjango
"au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
"au FileType python map <buffer> <leader>1 /class
let g:pydoc_open_cmd = 'vsplit'
let g:pydoc_highlight=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Slef defined functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShortTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let ret .= '%#ErrorMsg#'
        else
            let ret .= '%#TabLine#'
        endif
        let buflist = tabpagebuflist(i+1)
        let winnr = tabpagewinnr(i+1)
        let buffername = bufname(buflist[winnr - 1])
        let filename = fnamemodify(buffername, ':t')
        if filename == ''
            let filename = 'No Name'
        endif
        let ret .= i.'-'.filename
    endfor
    let ret .= '%#TabLineFill#%T'
    return ret
endfunction
set tabline=%!ShortTabLine()
