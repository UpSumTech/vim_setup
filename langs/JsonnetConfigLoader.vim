function langs#JsonnetConfigLoader#Load() dict
  augroup Jsonnet
    autocmd FileType jsonnet nested let g:jsonnet_fmt_on_save = 0 " Disable jsonnet auto formatting on save
  augroup END
endfunction langs#JsonnetConfigLoader#Load

function langs#JsonnetConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#JsonnetConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#JsonnetConfigLoader#New
