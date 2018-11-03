export ZSH="$HOME/.zsh"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_LIB="$ZSH/lib"
export ZSH_PLUGINS="$ZSH/plugins"
export ZSH_THEMES="$ZSH/themes"

export DROPBOX=$HOME/Dropbox

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
export FZF_BASE=/usr/bin

export PAGER=less
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.nimble/bin
