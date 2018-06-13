function langs#TerraformLoader#Load() dict
  augroup Terraform
    let g:terraform_align=1
    let g:terraform_fold_sections=1
    let g:terraform_fmt_on_save=1
  augroup END
endfunction langs#TerraformLoader#Load

function langs#TerraformLoader#New()
  let Retval = {
    \ 'load' : function('langs#TerraformLoader#Load'),
  \ }
  return Retval
endfunction langs#TerraformLoader#New
