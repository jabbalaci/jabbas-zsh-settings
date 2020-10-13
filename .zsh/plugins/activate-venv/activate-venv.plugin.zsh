# activate the virt. env. if Pipfile exists
_activate_venv() {
  if [[ -n ${VIRTUAL_ENV} ]]; then
      # echo "# virt. env. is already activated"
      return
  fi
  # else
  if [[ -f Pipfile ]]; then
    # echo "# activating venv…"
    source $(pipenv --venv)/bin/activate
  elif [[ -f pyproject.toml ]]; then
    # echo "# activating venv…"
    source `(poetry show -v | head -1) 2>/dev/null | cut -d" " -f3`/bin/activate
  fi
}

autoload -U add-zsh-hook
# we'll enable it later, when `poetry show -v` becomes fast:
# add-zsh-hook chpwd _activate_venv

_activate_venv

alias on=_activate_venv

alias off='deactivate'

alias out='off; cd ..'
