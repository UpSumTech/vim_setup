#!/bin/bash

target="${HOME}/.vim"
pluginDir="$target/bundle"

export PID="$$" # Get parent pid so that you can kill the main proc from subshells
die() {
  echo >&2 "Error : $*"
  kill -s TERM $PID
  exit 1
}

ok() {
  echo -n ''
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
  mkdir -p "$pluginDir"
  if [[ ! -d "$pluginDir/neobundle.vim" ]]; then
    git clone "https://github.com/Shougo/neobundle.vim.git" "$pluginDir/neobundle.vim" \
      || die "Could not clone plugin manager"
  else
    echo "$(cd "$pluginDir/neobundle.vim"; git pull)"
  fi
}

PostInstallInstructions() {
  echo "
  >> Install these LSP servers :
    :LspInstallServer eclipse-jdt-ls
    :LspInstallServer solargraph
    :LspInstallServer pyls
    :LspInstallServer terraform-lsp
    :LspInstallServer typescript-language-server
    :LspInstallServer bash-language-server
    :LspInstallServer vim-language-server
    :LspInstallServer docker-langserver

  >> Install Vim plugins manually:
    :NeoBundleInstall

  >> Install gopls manually
    go install golang.org/x/tools/gopls@latest
  "
}

main() {
  MoveOldVimFilesAndDirs
  CopySetup
  CopyOldPlugins
  cd "$target"
  GetPluginManager
  make || die "Build failed"
  PostInstallInstructions
  ok
}

main
