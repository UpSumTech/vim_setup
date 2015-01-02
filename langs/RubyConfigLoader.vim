function langs#RubyConfigLoader#Load() dict
  augroup Ruby
    autocmd!
    autocmd FileType ruby,eruby                                              nested setlocal cinwords=do,if,elsif,else,try,def,class
    autocmd FileType ruby,eruby                                              nested let g:rubycomplete_buffer_loading=1
    autocmd FileType ruby,eruby                                              nested let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby                                              nested let g:rubycomplete_classes_in_global=1
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,config.ru,Thorfile,*.cap nested set filetype=ruby
    autocmd BufNewFile,BufRead *.html.erb                                    nested setlocal filetype=eruby.html
    autocmd BufNewFile,BufRead *.js.erb                                      nested setlocal filetype=eruby.javascript
    autocmd BufNewFile,BufRead *.rb.erb                                      nested setlocal filetype=eruby.ruby
    autocmd BufNewFile,BufRead *.sh.erb                                      nested setlocal filetype=eruby.sh
    autocmd BufNewFile,BufRead *.yml.erb                                     nested setlocal filetype=eruby.yaml
    autocmd BufNewFile,BufRead *.txt.erb                                     nested setlocal filetype=eruby.text
    autocmd FileType ruby,eruby                                              nested setlocal omnifunc=rubycomplete#Complete
  augroup END
endfunction langs#RubyConfigLoader#Load

function langs#RubyConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#RubyConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#RubyConfigLoader#New
