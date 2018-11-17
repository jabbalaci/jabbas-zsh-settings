#########################
## aliases / functions ##
#########################

# make directory and go (enter [cd] the created directory)
mdgo () {
  if [[ -z "$1" ]]
  then
    echo "Usage: mdgo <dir>"
  else
    mkdir $1; cd $1
  fi
}

prettyjson () {
  if [[ -z "$1" ]]
  then
    echo "Usage: prettyjson <ugly.json>"
  else
    cat $1 | python -m json.tool
  fi
}

# Linux
alias run='chmod u+x'
alias ff='firefox'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias pcat='pygmentize -f terminal256 -O style=native -g'
alias ccat='pcat'
alias nh='nautilus . 2>/dev/null'    # nautilus here
alias th='thunar'
alias k='konsole 2>/dev/null &'
alias top10dirs='du -hsx * | sort -rh | head -10'
alias top10files='find . -type f -print0 | du -h --files0-from=- | sort -hr | head -n 10'
# lists the ten most used commands
alias top10history="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias ssh='ssh -o ServerAliveInterval=60'
alias cls='clear'

# Editors / File Managers
alias vi=$EDITOR
alias vim=$EDITOR
alias ed='code .'

# START: mc-wrapper
my_mc() {
  local text=""
  if [ -f /usr/local/libexec/mc/mc-wrapper.sh ]
  then
    text=". /usr/local/libexec/mc/mc-wrapper.sh"
  else
    if [ -f /usr/lib/mc/mc-wrapper.sh ]
    then
      text=". /usr/lib/mc/mc-wrapper.sh"
    else
      echo "error: mc-wrapper.sh not found"
      return
    fi
  fi
  alias mc="$text"
}
my_mc
unfunction my_mc    # clean up
# END: mc-wrapper

alias m='mc'
alias r='ranger'
alias n='nnn'

# Python
alias p2='python2'
alias p3='python3'
alias p='python3'
alias ipy='ipython'

# Nim
alias rod="rodcli"
alias ri="rodcli i"

# Ubuntu
alias sagi='sudo apt install'    # used to be `sudo apt-get install`

# Manjaro
alias ver='pacman -Qi'
alias files='pacman -Ql'
alias ssr='simplescreenrecorder 2>/dev/null &'

# e* , i.e. edit something
alias ee="$EDITOR $HOME/.zshenv"                             # edit ~/.zshenv
alias ez="$EDITOR $HOME/.zshrc"                              # edit ~/.zshrc
alias ea="$EDITOR $ZSH/aliases_functions.zsh"                # edit aliases
alias en="$EDITOR $ZSH_JABBAS_SETTINGS/notes.txt"            # edit notes
alias elog="$EDITOR $DROPBOX/document/log/2018_szept.txt"    # edit log

# Confs
alias rel='source ~/.zshenv; source ~/.zshrc'       # reload

# Directories
alias ls='ls --color=auto'
alias d='ls -al'
alias ll='dirs -v | head -10'
alias ppwd='/bin/pwd'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'

# fun
alias sshow_r='feh -zsZFD 5 .'

# safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# git
alias g='git status'

# fzf
j() {
  if [ $# -gt 0 ]; then
    # _z "$@"
    # cd "$(_z -l 2>&1 | fzf -f "$*" | sort -nr | head -n 1 | sed 's/^[0-9,.]* *//')"
    cd "$(_z -l 2>&1 | fzf -f "$*" | head -n 1 | sed 's/^[0-9,.]* *//')"
  else
    cd "$(_z -l 2>&1 | fzf --height 40% --reverse --tac --query "$*" | sed 's/^[0-9,.]* *//')"
  fi
}


##################
# Global aliases #
##################

# https://github.com/gotbletu/shownotes/blob/master/zsh_global_alias_expansion.md
# Automatically Expanding Global Aliases (Space key to expand)
# references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    zle expand-word
  fi
  zle self-insert
}
zle -N globalias
bindkey " " globalias                 # space key to expand globalalias
bindkey "^ " magic-space            # control-space to bypass completion
# bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches

# http://www.zzapper.co.uk/zshtips.html
# alias -g ND='*(/om[1])' 	      # newest directory
# alias -g NF='*(.om[1])' 	      # newest file
alias -g L='| less'
alias -g M='| most'
alias -g WC='| wc -l'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g NUL=">/dev/null 2>&1"
alias -g NULL=">/dev/null 2>&1"
alias -g NO=">/dev/null 2>&1"
alias -g N1="1>/dev/null"
alias -g 1N="1>/dev/null"
alias -g N2="2>/dev/null"
alias -g 2N="2>/dev/null"
