function langs#RubyConfigLoader#Load() dict
  augroup Ruby
    autocmd!
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,config.ru,Thorfile,*.cap nested set filetype=ruby
  augroup END
endfunction langs#RubyConfigLoader#Load

function langs#RubyConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#RubyConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#RubyConfigLoader#New
