# This is a fun little theme that mimics the DOS prompt.

source $ZSH_LIB/strings.zsh    # fishy_collapsed_wd()


TEXT1=`cat <<EOF
Starting MS-DOS...
EOF
`

TEXT2=`cat <<EOF
Microsoft Windows [Version 6.2.9200]
(c) 2012 Microsoft Corporation. All rights reserved.
EOF
`

texts=(
  $TEXT1
  $TEXT2
)

# select a random header text
N=${#texts[@]}
((N=(RANDOM%N)+1))
text=${texts[$N]}

echo $text
echo

_msdos_pwd() {
  # echo $(_fishy_collapsed_wd) | tr '/' '\\'
  echo $(pwd) | sed -e "s|^/home/|/Users/|" | tr '/' '\\'
}

PS1=$'\nC:`_msdos_pwd`> '
