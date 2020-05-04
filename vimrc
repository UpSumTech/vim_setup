" Use vim mode not vi mode
set nocompatible

let mapleader=","

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
endif

let g:lsp_enabled_langs = {
  \ 'java': 1,
  \ }

if g:lsp_enabled_langs.java == 1
  let g:is_javacomplete2_plugin_enabled = 1
else
  let g:is_javacomplete2_plugin_enabled = 1
endif

function s:LoadPlugins()
  if filereadable(expand("~/.vim/PluginLoader.vim"))
    source ~/.vim/PluginLoader.vim
  endif
  let pluginLoader=PluginLoader#New()
  call pluginLoader.install()
  call pluginLoader.beforeLoad()
  call pluginLoader.load()
  call pluginLoader.afterLoad()
endfunction

function s:LoadFtPlugins()
  for filename in split(glob('~/.vim/ftplugin/*.vim'), '\n')
    :execute 'source '.filename
  endfor
endfunction

function s:LoadSyntaxPlugins()
  for filename in split(glob('~/.vim/syntax/*.vim'), '\n')
    :execute 'source '.filename
  endfor
endfunction

function s:LoadCompilerPlugins()
  for filename in split(glob('~/.vim/compiler/*.vim'), '\n')
    :execute 'source '.filename
  endfor
endfunction

function s:LoadIndentPlugins()
  for filename in split(glob('~/.vim/indent/*.vim'), '\n')
    :execute 'source '.filename
  endfor
endfunction

function s:LoadOmniCompletionPlugins()
  for filename in split(glob('~/.vim/omnicompletion/*.vim'), '\n')
    :execute 'source '.filename
  endfor
endfunction

function s:LoadSettings()
  if filereadable(expand("~/.vim/SettingLoader.vim"))
    source ~/.vim/SettingLoader.vim
  endif
  let settingLoader=SettingLoader#New()
  call settingLoader.load()
endfunction

function s:LoadCommands()
  if filereadable(expand("~/.vim/CommandLoader.vim"))
    source ~/.vim/CommandLoader.vim
  endif
  let commandLoader=CommandLoader#New()
  call commandLoader.load()
endfunction

function s:LoadLanguageConfigs()
  let languageLoaders=[
    \ "ClangConfigLoader",
    \ "JavaScalaConfigLoader",
    \ "GoConfigLoader",
    \ "TerraformConfigLoader",
    \ "JsCssHtmlConfigLoader",
    \ "OrgModeConfigLoader",
    \ "PythonConfigLoader",
    \ "RubyConfigLoader",
    \ "ClojureConfigLoader",
    \ "PureScriptHaskellConfigLoader",
  \ ]

  for languageLoader in languageLoaders
    let fileName=expand("~/.vim/langs/".languageLoader.".vim")
    if filereadable(fileName)
      :execute 'source '.fnameescape(fileName)
      let LoaderFn=function('langs#'.languageLoader.'#New')
      let loader=LoaderFn()
      call loader.load()
      unlet loader
      unlet LoaderFn
    endif
    unlet fileName
  endfor
endfunction

function s:LoadMappings()
  if filereadable(expand("~/.vim/MappingLoader.vim"))
    source ~/.vim/MappingLoader.vim
  endif
  let mappingLoader=MappingLoader#New()
  call mappingLoader.load()
endfunction

call s:LoadPlugins()
call s:LoadFtPlugins()
call s:LoadSyntaxPlugins()
call s:LoadCompilerPlugins()
call s:LoadIndentPlugins()
call s:LoadOmniCompletionPlugins()
call s:LoadSettings()
call s:LoadCommands()
call s:LoadLanguageConfigs()
call s:LoadMappings()

if g:lsp_enabled_langs.java == 1 && executable('eclipse-jdt-ls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'eclipse-jdt-ls',
    \ 'cmd': {server_info->['eclipse-jdt-ls']},
    \ 'whitelist': ['java'],
    \ })
endif

command -nargs=1 Quit :qa
