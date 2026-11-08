function langs#ClojureConfigLoader#Load() dict
  augroup Clojure
    autocmd!

    autocmd BufNewFile,BufRead *.clj,*.cljs,*.cljc nested setlocal filetype=clojure

    autocmd FileType clojure :RainbowParenthesesToggle
    autocmd FileType clojure :RainbowParenthesesLoadRound
    autocmd FileType clojure :RainbowParenthesesLoadSquare
    autocmd FileType clojure :RainbowParenthesesLoadBraces
  augroup END
endfunction langs#ClojureConfigLoader#Load

function langs#ClojureConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#ClojureConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#ClojureConfigLoader#New
