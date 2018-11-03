git-is-dirty() {
  test -z "$(command git status --porcelain --ignore-submodules -unormal)"
  if [[ $? -eq 1 ]]; then
    echo 1
  else
    echo 0
  fi
}

git-branch-name() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  local name=$(git symbolic-ref --short -q HEAD)
  echo $name
}
