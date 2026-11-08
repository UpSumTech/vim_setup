function langs#JavaConfigLoader#Load() dict
  augroup Java
    autocmd!
    autocmd FileType java nested let b:maplocalleader="\\"
    autocmd FileType java nested let b:loaded_delimitMate = 1
    autocmd FileType xml nested setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable javacomplete2 setings if the corresponding config var is set
    " By default this is disabled
    if exists('g:is_javacomplete2_plugin_enabled') && g:is_javacomplete2_plugin_enabled == 1
      autocmd FileType java nested nmap <localLeader>M <Plug>(JavaComplete-Generate-AbstractMethods)
      autocmd FileType java nested nmap <localLeader>A <Plug>(JavaComplete-Generate-Accessors)
      autocmd FileType java nested nmap <localLeader>s <Plug>(JavaComplete-Generate-AccessorSetter)
      autocmd FileType java nested nmap <localLeader>g <Plug>(JavaComplete-Generate-AccessorGetter)
      autocmd FileType java nested nmap <localLeader>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
      autocmd FileType java nested nmap <localLeader>ts <Plug>(JavaComplete-Generate-ToString)
      autocmd FileType java nested nmap <localLeader>eq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
      autocmd FileType java nested nmap <localLeader>c <Plug>(JavaComplete-Generate-Constructor)
      autocmd FileType java nested nmap <localLeader>dc <Plug>(JavaComplete-Generate-DefaultConstructor)
      autocmd FileType java nested nmap <silent> <buffer> <localLeader>n <Plug>(JavaComplete-Generate-NewClass)
      autocmd FileType java nested nmap <silent> <buffer> <localLeader>N <Plug>(JavaComplete-Generate-ClassInFile)
    endif

    " Reminder to use C-x C-o for omni-completion
  augroup END
endfunction langs#JavaConfigLoader#Load

function langs#JavaConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#JavaConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#JavaConfigLoader#New
