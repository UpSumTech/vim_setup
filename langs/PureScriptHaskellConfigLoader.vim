function langs#PureScriptHaskellConfigLoader#Load() dict
  augroup PureScript
    if executable("psc")
      let g:purescript_indent_if = 3
      let g:purescript_indent_case = 5
      let g:purescript_indent_let = 4
      let g:purescript_indent_where = 6
      let g:purescript_indent_do = 3
    endif
  augroup END
endfunction langs#GoConfigLoader#Load

function langs#PureScriptHaskellConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#PureScriptHaskellConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#PureScriptHaskellConfigLoader#New
