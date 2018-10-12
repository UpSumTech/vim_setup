function langs#JsCssHtmlConfigLoader#Load() dict
  augroup JS_Html_Css_JSON
    autocmd!

    autocmd FileType javascript vnoremap <buffer> <leader>fef :call RangeJsBeautify()<CR>
    autocmd FileType html       vnoremap <buffer> <leader>fef :call RangeHtmlBeautify()<CR>
    autocmd FileType css        vnoremap <buffer> <leader>fef :call RangeCSSBeautify()<CR>

    autocmd FileType css           nested setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown nested setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript    nested setlocal omnifunc=javascriptcomplete#CompleteJS
  augroup END
endfunction langs#JsCssHtmlConfigLoader#Load

function langs#JsCssHtmlConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#JsCssHtmlConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#JsCssHtmlConfigLoader#New
