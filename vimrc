set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kovisoft/slimv'
Plugin 'chrisbra/csv.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'w0rp/ale'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"   ///////////////////////////////////////////////
"  // Put your non-Plugin stuff after this line //
" ///////////////////////////////////////////////

" You can add a global configuration file in /etc/vim/vimrc.local
set nocompatible                  " must be first line
set encoding=utf-8                " The encoding displayed.
set fileencoding=utf-8            " The encoding written to file.
set history=1000                  " Store a ton of history (default is 20)
set background=dark               " Assume a dark background
set virtualedit=all               " allow for cursor beyond last character
set cursorline                    " highlight current line
set nu                            " Line numbers on
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
set nrformats-=octal              " we rarely find octal numbers to increase in the wild


set backup                        " backups are nice ...
set backupdir=$HOME/.vim_backup/ " but not when they clog .
set directory=$HOME/.vim_swap/   " Same for swap files
set viewdir=$HOME/.vim_views/    " same for view files

"" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vim_backup'
silent execute '!mkdir -p $HOME/.vim_swap'
silent execute '!mkdir -p $HOME/.vim_views'

com! FormatJSON %!python -m json.tool



syntax on

autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.tex setl omnifunc=syntaxcomplete#Complete
autocmd BufNewFile,BufRead *.tex setl spell
autocmd BufNewFile,BufRead *.tex setl spelllang=es_es
autocmd BufNewFile,BufRead *.tex setl filetype=plaintex
autocmd BufNewFile,BufRead *.tex :map <F9> :w\|!pdflatex "%:p" %% && firefox "%:p:r".pdf<CR>

filetype plugin on
""" No longer necesary with YouCompleteMe plugin.
"autocmd FileType lisp setl ofu=lispcomplete#CompleteLisp
"autocmd FileType php setl ofu=phpcomplete#CompletePHP
"autocmd FileType ruby,eruby setl ofu=rubycomplete#Complete
"autocmd FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
"autocmd FileType c setl ofu=ccomplete#CompleteCpp
"autocmd FileType css setl ofu=csscomplete#CompleteCSS

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

map <C-o> :NERDTreeToggle<CR>

let mapleader="º"

"execute pathogen#infect()

let g:slimv_swank_cmd = "! /usr/bin/tmux new-window -n 'swank' 'sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp'"
let g:lisp_rainbow=1
let g:slimv_impl="sbcl"

"" :call SetDrawIt('vertical','horizontal','crossing','\','/','X','*')


function! Liquid()
    "" Define certain regions
    syn match liquid_keyword ' and '
    syn match liquid_keyword ' or '
    syn match liquid_keyword ' else '
    syn match liquid_keyword ' elsif '
    syn match liquid_keyword ' in '
    syn match liquid_keyword ' for '
    syn match liquid_keyword ' endfor '
    syn match liquid_keyword ' if '
    syn match liquid_keyword ' endif '
    syn match liquid_keyword ' unless '
    syn match liquid_keyword ' endunless '
    syn match liquid_keyword ' capture '
    syn match liquid_keyword ' endcapture '
    syn match liquid_keyword ' assign '
    syn match liquid_keyword ' increment '
    syn match liquid_keyword ' decrement '
    syn match liquid_keyword ' comment '
    syn match liquid_keyword ' endcomment '
    syn match liquid_keyword ' include '
    syn match liquid_keyword ' link '
    syn match liquid_keyword ' post_url '
    syn match liquid_keyword ' gist '
    syn match liquid_keyword ' highlight '
    syn match liquid_keyword ' endhighlight '
    syn match liquid_keyword ' lineos '

    syn match liquid_keyword '\.'

    syn match liquid_pipe '|'

    syn region liquid_constant start='"' end='"' contained
    syn region liquid_constant start="'" end="'" contained

    syn match liquid_filter '[a-z 0-9 _ \-]\+:'

    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{%' end='%}' fold transparent contains=liquid,liquid_pipe,liquid_keyword,liquid_class,liquid_filter,liquid_constant
    syn region highlight_block start='{{' end='}}' fold transparent contains=liquid,liquid_pipe,liquid_keyword,liquid_class,liquid_filter,liquid_constant

    "" Actually highlight those regions.
    hi link liquid Identifier
    hi link liquid_pipe Identifier
    hi link liquid_keyword Statement
    hi link liquid_filter Type
    hi link liquid_constant Constant
    hi link highlight_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.html,*.md,*.markdown call Liquid()

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
