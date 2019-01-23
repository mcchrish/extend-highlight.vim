if g:extend_highlight#loaded
  finish
endif
let g:extend_highlight#loaded = 1

if !(exists("g:extend_highlight#extend_list"))
  let g:extend_highlight#extend_list = []
endif

if !(exists("g:extend_highlight#register_autocmd"))
  let g:extend_highlight#register_autocmd = 1
endif

if !g:extend_highlight#register_autocmd
  finish
endif

function! s:set_highlights()
  for item in g:extend_highlight#extend_list
    call extend_highlight#extend(item[0], item[1], item[2])
  endfor
endfunction

augroup load_hi
  autocmd!
  autocmd VimEnter,ColorScheme * call <SID>set_highlights()
augroup END
