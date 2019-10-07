function langs#OrgModeConfigLoader#Load() dict
  augroup Org
    autocmd FileType org nested let b:maplocalleader="\\"
  augroup END
endfunction langs#OrgModeConfigLoader#Load

function langs#OrgModeConfigLoader#New()
  let Retval = {
    \ 'load' : function('langs#OrgModeConfigLoader#Load'),
  \ }
  return Retval
endfunction langs#OrgModeConfigLoader#New
