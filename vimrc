" Use vim mode not vi mode
set nocompatible

let mapleader=","

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
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
    \ "CandJavaConfigLoader",
    \ "GoConfigLoader",
    \ "JsCssHtmlConfigLoader",
    \ "PythonConfigLoader",
    \ "RubyConfigLoader",
    \ "ClojureConfigLoader",
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
call s:LoadSettings()
call s:LoadCommands()
call s:LoadLanguageConfigs()
call s:LoadMappings()

command -nargs=1 Quit :qa
