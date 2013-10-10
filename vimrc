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
" use vim settings, rather than Vi settings (much better!).
set nocompatible
"Enable filetype plugin
if has('autocmd')
    filetype plugin indent on
endif
