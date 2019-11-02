# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
# github here
gh() {
  giturl=$(git config --get remote.origin.url)
  if [[ "$giturl" == "" ]]; then
    echo "Not a git repository or no remote.origin.url set"
    return
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

# git up -> commit and push changes up
gitup() {
  git status
  echo

  echo "# Step 1) git add -A ."
  echo "Press ENTER to continue..."; read
  git add -A .

  git status
  echo

  echo "# Step 2) git commit"
  echo "Press ENTER to continue..."; read
  git commit

  git status
  echo

  echo "# Step 3) git push"
  echo "Press ENTER to continue..."; read
  git push

  git status
}
