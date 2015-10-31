function s:RubyEndToken()
  let current_line = getline( '.' )
  let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
  let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  if match(current_line, braces_at_end) >= 0
    let insertion = "}"
  elseif match(current_line, stuff_without_do) >= 0
    let insertion = "end"
  elseif match(current_line, with_do) >= 0
    let insertion = "end"
  endif
  execute 'normal o' . insertion
  execute 'normal ==k$a' . "\<CR>\<TAB>"
endfunction

function langs#RubyConfigLoader#Load()
  augroup Ruby
    autocmd!
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,config.ru,Thorfile,*.cap nested set filetype=ruby
    command! RubyEnd call <SID>RubyEndToken()
    autocmd FileType ruby nnoremap <buffer> <leader><CR> :RubyEnd<CR>
  augroup END
endfunction langs#RubyConfigLoader#Load

function langs#RubyConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#RubyConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#RubyConfigLoader#New
