function language#JsCssHtmlConfigLoader#Load() dict
  augroup JS_Html_Css_JSON
    autocmd!

    autocmd BufNewFile,BufRead *.json nested setlocal filetype=javascript

    autocmd FileType javascript noremap <buffer> <leader>fef :call JsBeautify()<cr>
    autocmd FileType html       noremap <buffer> <leader>fef :call JsBeautify()<cr>
    autocmd FileType css        noremap <buffer> <leader>fef :call JsBeautify()<cr>

    autocmd FileType javascript vnoremap <buffer> <leader>fef :call RangeJsBeautify()<cr>
    autocmd FileType html       vnoremap <buffer> <leader>fef :call RangeHtmlBeautify()<cr>
    autocmd FileType css        vnoremap <buffer> <leader>fef :call RangeCSSBeautify()<cr>

    autocmd FileType css           nested setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown nested setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript    nested setlocal omnifunc=javascriptcomplete#CompleteJS
  augroup END
endfunction language#JsCssHtmlConfigLoader#Load

function language#JsCssHtmlConfigLoader#New()
  let Retval = {
    \ 'load' : function('language#JsCssHtmlConfigLoader#Load'),
  \ }
  return Retval
endfunction language#JsCssHtmlConfigLoader#New
