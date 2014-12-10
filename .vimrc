" You can add a global configuration file in /etc/vim/vimrc.local
set nocompatible                  " must be first line
set encoding=utf-8                " The encoding displayed.
set fileencoding=utf-8            " The encoding written to file.
set history=1000                  " Store a ton of history (default is 20)
set background=dark               " Assume a dark background
set virtualedit=all               " allow for cursor beyond last character
set cursorline                    " highlight current line
" set nu                            " Line numbers on
set showmatch                     " show matching brackets/parenthesis
set incsearch                     " find as you type search
set hlsearch                      " highlight search terms
set ignorecase                    " case insensitive search
set smartcase                     " case sensitive when uc present
set wildmenu                      " show list instead of just completing
set wildmode=list:longest,full    " command <Tab> completion, list matches, then longest common part, then all.
" set whichwrap=b,s,h,l,<,>,[,]     " backspace and cursor keys wrap to
" set foldenable                    " auto fold code
" set gdefault                      " the /g flag on :s substitutions by default
set list
set listchars=eol:¶,tab:>.,trail:·,extends:…,precedes:…,nbsp:‿ " Highlight problematic whitespace
set nowrap                        " don't wrap long lines
set autoindent                    " indent at the same level of the previous line
set shiftwidth=4                  " use indents of 4 spaces
set expandtab                     " tabs are spaces, not tabs
set tabstop=4                     " an indentation every four columns
set softtabstop=4                 " let backspace delete indent


set backup                        " backups are nice ...
set backupdir=$HOME/.vim/backup// " but not when they clog .
set directory=$HOME/.vim/swap//   " Same for swap files
set viewdir=$HOME/.vim/views//    " same for view files

"" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vim/backup'
silent execute '!mkdir -p $HOME/.vim/swap'
silent execute '!mkdir -p $HOME/.vim/views'





autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.tex setl omnifunc=syntaxcomplete#Complete
autocmd BufNewFile,BufRead *.tex setl spell
autocmd BufNewFile,BufRead *.tex setl spelllang=es_es
autocmd BufNewFile,BufRead *.tex setl filetype=plaintex

filetype plugin on
autocmd FileType php setl ofu=phpcomplete#CompletePHP
autocmd FileType ruby,eruby setl ofu=rubycomplete#Complete
autocmd FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
autocmd FileType c setl ofu=ccomplete#CompleteCpp
autocmd FileType css setl ofu=csscomplete#CompleteCSS

set foldmarker={,} foldlevel=0 foldmethod=marker
" set foldmethod=syntax
set foldlevelstart=1

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"" There are two ways for a terminal emulator to send an Alt key (usually called a Meta key as actual 
"" terminals didn't have Alt). It can either send 8 bit characters and set the high bit when Alt is used,
"" or it can use escape sequences, sending Alt-a as <Esc>a. Vim expects to see the 8 bit encoding rather
"" than the escape sequence.

"" Some terminal emulators such as xterm can be set to use either mode, but Gnome terminal doesn't offer
"" any such setting. To be honest in these days of Unicode editing, the 8-bit encoding is not such a good
"" idea anyway. But escape sequences are not problem free either; they offer no way of distinguishing
"" between <Esc>j meaning Alt-j vs pressing Esc followed by j.

"" In earlier terminal use, typing Escj was another way to send a Meta on a keyboard without a Meta key,
"" but this doesn't fit well with vi's use of Esc to leave insert mode.

"" It is possible to work around this by configuring vim to map the escape
"" sequences to their Alt combinations.
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=12
"" Alt-letter will now be recognised by vi in a terminal as well as by gvim.

"" The ttimeout settings are used to work around the ambiguity with escape sequences. and j sent within
"" 50ms will be mapped to <A-j>, greater than 50ms will count as separate keys. That should be enough
"" time to distinguish between Meta encoding and hitting two keys.
"" ttimeout applies only to key codes and not other mappings.

"" Bind alt+[jk] to move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

let mapleader="º"

execute pathogen#infect()
