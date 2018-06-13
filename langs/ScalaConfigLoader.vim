function langs#ScalaConfigLoader#Load() dict
  augroup Scala
    let g:scala_scaladoc_indent = 1
  augroup END
endfunction langs#ScalaConfigLoader#Load

function langs#ScalaConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#ScalaConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#ScalaConfigLoader#New
