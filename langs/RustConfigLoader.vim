function langs#RustConfigLoader#Load() dict
  augroup Rust
    if exists('g:loaded_rust_vim')
      let g:rustfmt_autosave = 1
      let g:rust_clip_command = 'pbcopy'
      " autocmd FileType rust nnoremap <c-l>kfy :GoKeyify<CR>
    endif
  augroup END
endfunction langs#RustConfigLoader#Load

function langs#RustConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#RustConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#RustConfigLoader#New
