function langs#ClojureConfigLoader#Load() dict
  augroup Clojure
    autocmd!

    autocmd BufNewFile,BufRead *.clj,*.cljs,*.cljc nested setlocal filetype=clojure

    if exists("g:rbpt_colorpairs")
      autocmd FileType clojure :RainbowParenthesesToggle
      autocmd FileType clojure :RainbowParenthesesLoadRound
      autocmd FileType clojure :RainbowParenthesesLoadSquare
      autocmd FileType clojure :RainbowParenthesesLoadBraces
    endif

    if exists("g:loaded_dispatch")
      autocmd FileType clojure :Start lein repl
    endif
  augroup END
endfunction langs#ClojureConfigLoader#Load

function langs#ClojureConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#ClojureConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#ClojureConfigLoader#New
