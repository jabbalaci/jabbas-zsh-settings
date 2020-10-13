export ZSH_JABBAS_SETTINGS=$HOME/jabbas-zsh-settings

export ZSH="$HOME/.zsh"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_LIB="$ZSH/lib"
export ZSH_PLUGINS="$ZSH/plugins"
export ZSH_THEMES="$ZSH/themes"

export WORKON_HOME=$HOME/.virtualenvs

export DROPBOX=$HOME/Dropbox

export CARGO_HOME=$HOME/.cargo

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export EDITOR="nvim"
export VIEWER=$EDITOR
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
# Under Manjaro Steam crashed. Here is the patch:
export STEAM_RUNTIME=1
export FZF_BASE="/usr/bin"

export PAGER=less
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# export SDKMAN_DIR="$HOME/.sdkman"

export QT_SELECT="qt5"

export RAPIDMINER_HOME="/opt/rapidminer-studio"

# export LD_LIBRARY_PATH=/usr/lib

# pythonz
export PYTHONZ_ROOT=$HOME/.pythonz
export PYTHONZ_HOME=$HOME/.pythonz

# ignore pipenv warning
export PIPENV_VERBOSITY=-1

# light background
if [[ -f $HOME/LIGHT_BACKGROUND ]]; then
    export LIGHT_BACKGROUND=1
fi

# bat file viewer
if [[ $LIGHT_BACKGROUND == "1" ]]; then
  # export BAT_THEME="ansi-light"
  export BAT_THEME="GitHub"
fi


# START: set PATH
# {{{
path_dirs=(
  # /opt/anaconda3/bin
  /usr/local/bin
  /bin                      	    # Ubuntu needs this
  /usr/bin
  /snap/bin
  /usr/bin/vendor_perl              # biber for LaTeX
  $HOME/bin
  $HOME/.zsh/bin
  $HOME/.local/bin
  $HOME/.nimble/bin	   	    # Nim
  $PYTHONZ_ROOT/bin         	    # pythonz
  $CARGO_HOME/bin           	    # Rust, installation: https://www.rust-lang.org/tools/install
  $HOME/.poetry/bin         	    # https://poetry.eustace.io/docs
  # $HOME/.pythonz/pythons/CPython-3.7.6/bin    # python3.7
  $HOME/.dotnet/tools       # dotnet-try
  /usr/lib/jvm/default-runtime/bin  # jshell

  # some of my own projects:
  $DROPBOX/python/melt/dist         # melt
  $DROPBOX/python/JSON-path/dist    # jsonpath
  $DROPBOX/python/apollo            # apollo.py
  $DROPBOX/python/Bash-Utils/dist   # sp
  $DROPBOX/nim/NimCliHelper         # rod
)

PATH=""
for pdir in "${path_dirs[@]}"
do
    if [[ "$PATH" == "" ]]; then
        PATH=$pdir
    else
        PATH=$PATH:$pdir
    fi
done
export PATH
# }}}
