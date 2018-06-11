#!/bin/bash

target="${HOME}/.vim"
pluginDir="$target/bundle"
ftPluginDir="$target/ftplugin"
syntaxPluginDir="$target/syntax"
compilerPluginDir="$target/compiler"
indentPluginDir="$target/indent"
omniCompletionPluginDir="$target/omnicompletion"

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
    git clone "https://github.com/Shougo/neobundle.vim.git" "$pluginDir/neobundle.vim" \
      || die "Could not clone plugin manager"
  else
    echo "$(cd "$pluginDir/neobundle.vim"; git pull)"
  fi
}

GetPlugins() {
  local githubUrl
  local repoName
  if [[ ! -d "$pluginDir" ]]; then
    mkdir -p "$pluginDir"
  fi
  while read -r line; do
    githubUrl="$(echo "$line" | cut -d "=" -f2)"
    repoName="$( echo "$githubUrl" | cut -d "/" -f2 | cut -d '.' -f1 )"
    echo "Downloading $repoName from $githubUrl"
    if [[ ! -d "$pluginDir/$repoName" ]]; then
      git clone "$githubUrl" "$pluginDir/$repoName" \
        || die "Could not clone plugin $repoName"
    else
      echo "$(cd "$pluginDir/$repoName"; git pull)"
    fi
  done < "$target/plugins"
}

CreateFtPlugins() {
  [[ -d "$ftPluginDir" ]] || mkdir "$ftPluginDir"
  cp "$pluginDir/vim-ruby/ftplugin/ruby.vim" "$ftPluginDir/ruby.vim"
  cp "$pluginDir/vim-ruby/ftplugin/eruby.vim" "$ftPluginDir/eruby.vim"
}

CreateSyntaxPlugins() {
  [[ -d "$syntaxPluginDir" ]] || mkdir "$syntaxPluginDir"
  cp "$pluginDir/vim-ruby/syntax/ruby.vim" "$syntaxPluginDir/ruby.vim"
  cp "$pluginDir/vim-ruby/syntax/eruby.vim" "$syntaxPluginDir/eruby.vim"
}

CreateCompilerPlugins() {
  [[ -d "$compilerPluginDir" ]] || mkdir "$compilerPluginDir"
  cp "$pluginDir/vim-ruby/compiler/ruby.vim" "$compilerPluginDir/ruby.vim"
  cp "$pluginDir/vim-ruby/compiler/eruby.vim" "$compilerPluginDir/eruby.vim"
  cp "$pluginDir/vim-ruby/compiler/rake.vim" "$compilerPluginDir/rake.vim"
  cp "$pluginDir/vim-ruby/compiler/rspec.vim" "$compilerPluginDir/rspec.vim"
  cp "$pluginDir/vim-ruby/compiler/rubyunit.vim" "$compilerPluginDir/rubyunit.vim"
}

CreateIndentPlugins() {
  [[ -d "$indentPluginDir" ]] || mkdir "$indentPluginDir"
  cp "$pluginDir/vim-ruby/indent/ruby.vim" "$indentPluginDir/ruby.vim"
  cp "$pluginDir/vim-ruby/indent/eruby.vim" "$indentPluginDir/eruby.vim"
}

CreateOmniCompletionPlugins() {
  [[ -d "$omniCompletionPluginDir" ]] || mkdir "$omniCompletionPluginDir"
  cp "$pluginDir/vim-ruby/autoload/rubycomplete.vim" "$omniCompletionPluginDir/rubycomplete.vim"
}

main() {
  MoveOldVimFilesAndDirs
  CopySetup
  CopyOldPlugins
  cd "$target"
  GetPluginManager
  GetPlugins
  CreateFtPlugins
  CreateSyntaxPlugins
  CreateCompilerPlugins
  CreateIndentPlugins
  CreateOmniCompletionPlugins
  make || die "Build failed"
}

main
