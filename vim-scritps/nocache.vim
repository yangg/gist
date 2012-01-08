
set autoread
autocmd BufWritePost *.js silent call s:update_version(expand('<afile>:t'))

function! s:getlist(file)
    if a:file =~ '\(html\|php\)$'
        let file_rows = readfile(a:file)
        let new_rows = []
        for row in file_rows
            call add(new_rows, substitute(row, s:filename .'?ver\zs\d\{10}', localtime(), 'g'))
        endfor
        if file_rows != new_rows
            call writefile(new_rows, a:file)
        endif
    endif
endfunction

function! s:update_version(filename)
    let s:filename = a:filename
    redir => bufstr
        buffers
    redir END
    call substitute(bufstr, '"\([^"]\+\)"', '\=s:getlist(submatch(1))', 'g')
endfunction
