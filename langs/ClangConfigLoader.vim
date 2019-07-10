function langs#ClangConfigLoader#Load() dict
  augroup C_Cpp
    autocmd!
    let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -4,
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AllowShortBlocksOnASingleLine" : "true",
      \ "AllowShortLoopsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11"
      \ }
    autocmd FileType c,cpp nested let b:loaded_delimitMate = 1
    autocmd FileType c,cpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
    autocmd FileType c,cpp ClangFormatAutoEnable
  augroup END
endfunction langs#ClangConfigLoader#Load

function langs#ClangConfigLoader#New()
  let Retval = {
  \ 'load' : function('langs#ClangConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#ClangConfigLoader#New
