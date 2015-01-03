#!/bin/bash

target="${HOME}/Code/vim_setup_example"

die() {
  echo "${@}"
  exit 1
}

MoveOldVimFilesAndDirs() {
  local paths=("$target" "${HOME}/.vimrc")
  for file in "${paths[@]}"; do
    if [[ -e $file ]]; then
      mv "${file}" "${file}.old" || die "Failed to move ${file} to ${file}.old"
    fi
  done
}

CopySetup() {
  git clone https://github.com/sumanmukherjee03/vim_setup.git "$target" \
    || die "Could not clone repo"
}

GetPlugins() {
  if [[ ! -d "$target/bundle" ]]; then
    mkdir "$target/bundle"
  fi

  cd "bundle" && \
    while read -r line; do
      git clone "$(echo "$line" | cut -d "=" -f2)"
    done < "$target/plugins" && \
    cd ..
}

main() {
  MoveOldVimFilesAndDirs
  CopySetup
  cd "$target"
  GetPlugins
  # make || die "Make failed"
}

main
