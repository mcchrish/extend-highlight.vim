function! s:to_dict(colors)
  let l:colors_arr = split(a:colors)
  let l:colors_dict = {}
  for l:color in l:colors_arr
    let [l:key, l:value] = split(l:color, "=")
    let l:colors_dict[l:key] = split(l:value, ',')
  endfor
  return l:colors_dict
endfunction

function! s:combine_highlight(base, add)
  let l:result = ''
  for l:key in uniq(extend(keys(a:base), keys(a:add)))
    if has_key(a:add, l:key)
      if strpart(l:key, 0, 1) == '+'
        let l:clean_key = strpart(l:key, 1)
        if has_key(a:base, l:clean_key)
          let l:color = extend(a:base[l:clean_key], a:add[l:key])
        else
          let l:color = a:add[l:key]
        endif
        let l:key = l:clean_key
      else
        let l:color = a:add[l:key]
      endif
    elseif has_key(a:base, l:key) && !has_key(a:add, l:key) && !has_key(a:add, '+'.l:key)
      let l:color = a:base[l:key]
    else
      let l:color = []
    endif
    if !empty(l:color)
      let l:result = l:result.' '.l:key.'='.join(l:color, ',')
    endif
  endfor
  return l:result
endfunction

function! extend_highlight#extend(base, group, add)
  redir => basehi
  sil! exe 'highlight' a:base
  redir END
  let l:grphi = split(l:basehi, '\n')[0]
  let l:grphi = substitute(l:grphi, '^'.a:base.'\s\+xxx', '', '')
  let l:grphi = <SID>to_dict(l:grphi)
  let l:grphi = <SID>combine_highlight(l:grphi, a:add)
  sil exe 'highlight!' a:group l:grphi
endfunction
