# How to debug zsh startup time: http://bit.ly/2DhRTec
# measure startup time #1: `time  zsh -i -c exit`
# measure startup time #2: `time (source ~/.zshenv; source ~/.zshrc)`
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
  git             # git_up "command"
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

if [[ -f $HOME/LIGHT_BACKGROUND ]]; then
  ZSH_THEME_MODE="light"
fi

# select one (uncomment it) and comment the others

# source $ZSH_THEMES/basic.zsh-theme
# source $ZSH_THEMES/rookie.zsh-theme
# source $ZSH_THEMES/msdos.zsh-theme
# source $ZSH_THEMES/jabba.zsh-theme

# start: https://github.com/jabbalaci/nicy
STATUS_CODE_FILE_FOR_NIM="/tmp/9033289e.tmp"
_nicy_prompt() {
    echo $? > $STATUS_CODE_FILE_FOR_NIM
    PROMPT=$($ZSH_THEMES/jabba_nim/jabba)
}
precmd_functions+=_nicy_prompt
# end: https://github.com/jabbalaci/nicy

###############
### Aliases ###
###############

source $ZSH/aliases_functions.zsh

####################
### Key bindings ###
####################

# start `cat -v` and press your keybindings
# `cat -v` will show you the key combination of your key presses

# bindkey -s '^H' 'clear; ls -al\n'       # [Ctrl+Backspace] - directory content
# bindkey -s '^G' 'git status\n'          # git status

# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
# https://github.com/gotbletu/shownotes/blob/master/bang_previous_commands_hotkeys.md
bindkey -s '\e1' "!:0 \t"
bindkey -s '\e2' "!:0-1 \t"
bindkey -s '\e3' "!:0-2 \t"
bindkey -s '\e4' "!:0-3 \t"
bindkey -s '\e5' "!:0-4 \t"
bindkey -s '\e0' "!:0- \t"     # all but the last word

# ------------------------------------

if [[ -f $DROPBOX/secret/own_api_keys.sh ]]; then; source $DROPBOX/secret/own_api_keys.sh; fi

# zprof
