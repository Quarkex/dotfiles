set nocompatible              " be iMproved, required
filetype off                  " required

source ~/.dotfiles/vim/rc/plugins.cfg

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
set history=1000                  " Store a ton of history (default is 20)
source ~/.dotfiles/vim/rc/encodings.cfg
source ~/.dotfiles/vim/rc/gui.cfg
source ~/.dotfiles/vim/rc/autocomplete.cfg
source ~/.dotfiles/vim/rc/search.cfg
source ~/.dotfiles/vim/rc/format.cfg
source ~/.dotfiles/vim/rc/wrap_and_fold.cfg
source ~/.dotfiles/vim/rc/terminal.cfg
source ~/.dotfiles/vim/rc/backups.cfg

source ~/.dotfiles/vim/rc/key_bindings/mapleader.cfg
source ~/.dotfiles/vim/rc/key_bindings/alt_key_backwards_compatibility.cfg
source ~/.dotfiles/vim/rc/key_bindings/alt_key_line_swapper.cfg
source ~/.dotfiles/vim/rc/key_bindings/sidebars_hotkeys.cfg

source ~/.dotfiles/vim/rc/custom_syntax/liquid.cfg

source ~/.dotfiles/vim/rc/language_specific/vimrc.cfg
source ~/.dotfiles/vim/rc/language_specific/latex.cfg
source ~/.dotfiles/vim/rc/language_specific/golang.cfg
source ~/.dotfiles/vim/rc/language_specific/elixir.cfg
source ~/.dotfiles/vim/rc/language_specific/JSON.cfg
source ~/.dotfiles/vim/rc/language_specific/lisp.cfg
source ~/.dotfiles/vim/rc/language_specific/javascript.cfg

filetype plugin on

"execute pathogen#infect()

"" :call SetDrawIt('vertical','horizontal','crossing','\','/','X','*')

"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"

"" Easy align interactive
"vnoremap <silent> <Enter> :EasyAlign<cr>
