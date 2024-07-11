info () {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

warn () {
  printf "\r\033[2K  [\033[0;31mWARNING\033[0m] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
  exit
}

command_exists() {
  command -v "$1" &> /dev/null
}

directory_exists() {
  [ -d "$1" ]
}

package_exists() {
  dpkg -l "$1" &> /dev/null
}
