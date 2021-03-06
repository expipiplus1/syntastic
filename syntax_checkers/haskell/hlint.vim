"============================================================================
"File:        hlint.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Nicolas Wu <nicolas.wu at gmail dot com>
"License:     BSD
"============================================================================

if exists('g:loaded_syntastic_haskell_hlint_checker')
    finish
endif
let g:loaded_syntastic_haskell_hlint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_haskell_hlint_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'fname': syntastic#util#shexpand('%:p')})

    let errorformat =
        \ '%E%f:%l:%v: Error: %m,' .
        \ '%W%f:%l:%v: Warning: %m,' .
        \ '%C%m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': {'vcol': 1},
        \ 'postprocess': ['compressWhitespace'],
        \ 'subtype': 'Style'})
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'haskell',
    \ 'name': 'hlint'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
