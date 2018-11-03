#########################
## aliases / functions ##
#########################

# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [[ "$giturl" == "" ]]; then
    echo "Not a git repository or no remote.origin.url set"
    exit 1
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=${giturl}${branch}
  echo "#" $giturl
  xdg-open $giturl
}

# make directory and go (enter [cd] the created directory)
function mdgo () {
  if [[ -z "$1" ]]
  then
    echo "Usage: mdgo <dir>"
  else
    mkdir $1; cd $1
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
  # patch; mc with zsh behaved strangely: 1) it was slow, and 2) the prompt was a mess
  # if mc thinks the shell is bash, it works well...
  # if [[ $SHELL == "/bin/zsh" ]]; then
  #     text="SHELL=/bin/bash $text"
  # fi
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

# Ubuntu
alias sagi='sudo apt install'    # used to be `sudo apt-get install`

# Manjaro
alias ver='pacman -Qi'
alias files='pacman -Ql'
alias ssr='simplescreenrecorder 2>/dev/null &'

# Confs
alias ez="$EDITOR $HOME/.zshrc"    # edit ~/.zshrc
alias ee="$EDITOR $HOME/.zshenv"    # edit ~/.zshenv
alias ea="$EDITOR $ZSH/aliases_functions.zsh"    # edit aliases
alias rel='source ~/.zshenv; source ~/.zshrc'    # reload

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

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Fzf
j() {
  if [ $# -gt 0 ]; then
    # _z "$@"
    # cd "$(_z -l 2>&1 | fzf -f "$*" | sort -nr | head -n 1 | sed 's/^[0-9,.]* *//')"
    cd "$(_z -l 2>&1 | fzf -f "$*" | head -n 1 | sed 's/^[0-9,.]* *//')"
  else
    cd "$(_z -l 2>&1 | fzf --height 40% --reverse --tac --query "$*" | sed 's/^[0-9,.]* *//')"
  fi
}