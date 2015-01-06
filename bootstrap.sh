#!/bin/bash

target="${HOME}/Code/vim_setup_example"
pluginDir="$target/bundle"

die() {
  echo "${@}"
  exit 1
}

MoveOldVimFilesAndDirs() {
  local paths=("$target" "${HOME}/.vimrc")
  for file in "${paths[@]}"; do
    if [[ -e $file ]]; then
      if [[ -d "${file}.old" ]]; then
        rm -rf "${file}.old"
      fi
      mv "${file}" "${file}.old" || die "Failed to move ${file} to ${file}.old"
    fi
  done
}

CopyOldPlugins() {
  [[ -d "${target}.old/bundle" ]] \
    && cp -r "${target}.old/bundle" "$pluginDir"
}

CopySetup() {
  git clone https://github.com/sumanmukherjee03/vim_setup.git "$target" \
    || die "Could not clone repo"
}

GetPluginManager() {
  if [[ ! -d "$pluginDir/neobundle.vim" ]]; then
    git clone "git@github.com:Shougo/neobundle.vim" "$pluginDir/neobundle.vim" \
      || die "Could not clone plugin manager"
  else
    echo "$(cd "$pluginDir/neobundle.vim"; git pull)"
  fi
}

GetPlugins() {
  local githubUrl repoName
  if [[ ! -d "$pluginDir" ]]; then
    mkdir -p "$pluginDir"
  fi
  while read -r line; do
    githubUrl="$(echo "$line" | cut -d "=" -f2)"
    repoName="$(echo "$githubUrl" | cut -d "/" -f2)"
    if [[ ! -d "$pluginDir/$repoName" ]]; then
      git clone "$githubUrl" "$pluginDir/$repoName" \
        || die "Could not clone plugin $repoName"
    else
      echo "$(cd "$pluginDir/$repoName"; git pull origin master)"
    fi
  done < "$target/plugins"
}

main() {
  MoveOldVimFilesAndDirs
  CopySetup
  CopyOldPlugins
  cd "$target"
  GetPluginManager
  GetPlugins
  make || die "Build failed"
}

main
