" You can add a global configuration file in /etc/vim/vimrc.local
set nocompatible " be iMproved, required, must be first line
filetype off     " required

"#----------------------------------------------------------------------------#
                    source ~/.dotfiles/vim/rc/plugins.cfg
"#----------------------------------------------------------------------------#
"                  Put your non-Plugin stuff after this line

set history=1000 " Store a ton of history (default is 20)
set exrc " Enable directory-specific .vimrc files
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
