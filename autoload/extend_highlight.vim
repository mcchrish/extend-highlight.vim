function! s:to_dict(colors) abort
  let l:colors_arr = split(a:colors)
  let l:colors_dict = {}
  for l:color in l:colors_arr
    let [l:key, l:value] = split(l:color, "=")
    let l:colors_dict[l:key] = split(l:value, ',')
  endfor
  return l:colors_dict
endfunction

function! s:combine_highlight(base, add) abort
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

function! extend_highlight#extend(base, group, add) abort
  let l:basehi = execute('highlight '.a:base, 'silent!')
  let l:grphi = split(l:basehi, '\n')[0]
  let l:grphi = substitute(l:grphi, '^.*xxx\s', '', '')
  let l:grphi = <SID>to_dict(l:grphi)
  let l:grphi = <SID>combine_highlight(l:grphi, a:add)
  silent execute 'highlight!' a:group l:grphi
endfunction
