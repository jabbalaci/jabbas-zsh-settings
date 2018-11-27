# "ubuntu", "manjaro" (without quotes)
get_distro_name() {
  cat /etc/os-release | grep "^ID=" | cut -d= -f2
}

# # ┌---
# if [[ $(get_distro_name) == "ubuntu" ]]; then
#   alias files='dpkg-query -L'    # ubuntu
# else
#   alias files='pacman -Ql'       # manjaro
# fi
# # └---
