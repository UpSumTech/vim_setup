#!/bin/bash

target="${HOME}/Code/vim_setup_example"

die() {
  echo "${@}"
  exit 1
}

main() {
  [[ -d "$target" && -f "$target/plugins" ]] || die "The bootstrap script has not been run yet"
  cd "$target"
  local fileName="$target/plugins.vim"
  local pluginName
  if [[ -e "$fileName" ]]; then
    rm "$fileName"
  fi
  touch "$fileName"
  echo 'let g:plugins = [' >> "$fileName"

  while read -r line; do
    pluginName="$(echo "$line" | cut -d "=" -f1 | sed -e 's#/#\\/#g')"
    echo '  \ "\"'"$pluginName"'\"",' >> "$fileName"
  done < "plugins"
  echo '\ ]' >> "$fileName"
}

main
