function langs#TerraformConfigLoader#Load() dict
  augroup Terraform
    autocmd BufNewFile,BufRead *.hcl set filetype=terraform
    let g:terraform_align=1
    let g:terraform_fold_sections=1
    let g:terraform_fmt_on_save=1
    let g:hcl_fmt_autosave = 1 " Needs hclfmt - go get github.com/fatih/hclfmt
    let g:tf_fmt_autosave = 0 " Disable terraform fmt with vim-hclfmt plugin
  augroup END
endfunction langs#TerraformConfigLoader#Load

function langs#TerraformConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#TerraformConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#TerraformConfigLoader#New
