nim_project_info() {
  for file in $(find . -maxdepth 1 -name '*.nimble'); do
    if [ -f $file ]; then
        echo "${ZSH_THEME_NIM_PREFIX:=[}♛${ZSH_THEME_NIM_SUFFIX:=]}"
        break
    fi
  done
}
