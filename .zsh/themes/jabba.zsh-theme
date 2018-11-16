import_modules=(
  nim-project       # nim_project_info()
  virtualenv        # virtualenv_prompt_info()
  git               # git-is-dirty(), git-branch-name()
)

for name in "${import_modules[@]}"
do
  # echo "# sourcing module $name"    # debug
  source ${0:h}/_modules/$name/$name.plugin.zsh
done

# -------------------------------------

# dark / light colors
greenish="$FG[108]"
gray_darker="$FG[239]"
gray_lighter="$FG[244]"

time_dark="$fg_bold[green]"
# time_light=$terminfo[bold]$gray_lighter
time_light="$fg[green]"

clean_dark="$fg_bold[green]"
# clean_light="$terminfo[bold]$greenish"
clean_light="$fg[green]"

venv_dark="$fg_bold[blue]"
venv_light="$fg_bold[blue]"

nim_bracket_dark="$fg_bold[blue]"
nim_bracket_light="$fg_bold[blue]"

nim_logo_dark="$fg_bold[yellow]"
nim_logo_light="$fg_bold[black]"

rprompt_dark=$gray_lighter
rprompt_light=$gray_darker

# prompt_char_dark="$terminfo[bold]$greenish"
# prompt_char_light="$terminfo[bold]$greenish"

branch_dark="$fg_bold[yellow]"
branch_light="$terminfo[bold]$greenish"

pwd_dark="$fg_bold[magenta]"
pwd_light="$fg_bold[magenta]"

dirty_dark="$fg_bold[red]"
dirty_light="$fg_bold[red]"

error_dark="$fg_bold[red]"
error_light="$fg_bold[red]"


if [[ "$ZSH_THEME_MODE" == "light" ]]; then
  cTime=$time_light
  cClean=$clean_light
  cVenv=$venv_light
  cNimBracket=$nim_bracket_light
  cNimLogo=$nim_logo_light
  cRprompt=$rprompt_light
  cPromptChar=$prompt_char_light
  cBranch=$branch_light
  cPwd=$pwd_light
  cDirty=$dirty_light
  cError=$dirty_light
else
  cTime=$time_dark
  cClean=$clean_dark
  cVenv=$venv_dark
  cNimBracket=$nim_bracket_dark
  cNimLogo=$nim_logo_dark
  cRprompt=$rprompt_dark
  cPromptChar=$prompt_char_dark
  cBranch=$branch_dark
  cPwd=$pwd_dark
  cDirty=$dirty_dark
  cError=$dirty_dark
fi

_hr() {
  echo $(seq -s= 78 | tr -d '[:digit:]')
}

# _my_prompt="λ"
_my_prompt="$"

_ret_status="%(?:%{$cPromptChar%}$_my_prompt%{$reset_color%}:%{$cError%}$_my_prompt%{$reset_color%})"

ZSH_THEME_NIM_PREFIX="%{$cNimBracket%}[%{$cNimLogo%}"
ZSH_THEME_NIM_SUFFIX="%{$cNimBracket%}]%{$reset_color%} "

ZSH_THEME_VIRTUALENV_PREFIX="%{$cVenv%}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%} "

colored_branch_name() {
  local name=$(git-branch-name)
  if [[ $name == "" ]]; then
    return
  fi

  if [[ $(git-is-dirty) == "1" ]]; then
    echo "%{$cDirty%} ($name)%{$reset_color%}"
  else
    echo "%{$cClean%} ($name)%{$reset_color%}"
  fi
}

PS1=$'$(_hr)\n'
PS1+=$'$(nim_project_info)$(virtualenv_prompt_info)%{$cTime%}[%D{%H:%M:%S}]%{$reset_color%} [zsh] %{$cPwd%}%~%{$reset_color%}$(colored_branch_name) ${_ret_status} '

# RPS1="%{$cRprompt%}[ own zsh ]%{$reset_color%}"
