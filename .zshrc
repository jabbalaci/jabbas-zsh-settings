# How to debug zsh startup time: http://bit.ly/2DhRTec
# measure startup time: `time  zsh -i -c exit`
# for profiling, uncomment this line and the very last line (zprof)
# zmodload zsh/zprof

#############################
### General configuration ###
#############################

setopt no_beep
setopt interactive_comments
setopt prompt_subst

setopt auto_cd                  # Auto changes to a directory without typing cd.
setopt auto_pushd               # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups        # Do not store duplicates in the stack.
setopt pushd_minus
setopt pushd_silent             # Do not print the directory stack after pushd or popd.

setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

setopt hup
setopt long_list_jobs
setopt notify

setopt extended_glob            # Use extended globbing syntax.

autoload -U colors && colors

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ''
# case-insensitive, partial-word, and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

################
### core lib ###
################

libs=(
  grep            # colored output + ignore .git folders
  key-bindings    # must have
)

for name in "${libs[@]}"
do
  # echo "# sourcing lib $name"    # debug
  source $ZSH_LIB/$name.zsh
done

#############################
### Plugins configuration ###
#############################

plugins=(
  # xsession                        # call it on a new system, then put it in comment
  activate-venv                     # activate Python virt. env. automatically
  extract                           # ex() function extracts any archive
  zsh-autosuggestions               # very useful
  z
  fzf
)

for name in "${plugins[@]}"
do
  # echo "# sourcing $name"    # debug
  source $ZSH_PLUGINS/$name/$name.plugin.zsh
done

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"

##############
### Themes ###
##############

# select one (uncomment it) and comment the others

# source $ZSH_THEMES/basic.zsh
# source $ZSH_THEMES/rookie.zsh
# source $ZSH_THEMES/msdos.zsh
source $ZSH_THEMES/jabba.zsh

###############
### Aliases ###
###############

source $ZSH/aliases_functions.zsh

####################
### Key bindings ###
####################

# start `cat -v` and press your keybindings
# `cat -v` will show you the key combination of your key presses

bindkey -s '^H' 'clear; ls -al\n'                               # [Ctrl+Backspace] - directory content

# ------------------------------------

if [[ -f $DROPBOX/secret/own_api_keys.sh ]]; then; source $DROPBOX/secret/own_api_keys.sh; fi

# zprof
