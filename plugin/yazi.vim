" Check if the command already exists to avoid redefinition
if exists(":Yazi")
  finish
endif

let s:output_file = '/tmp/yazi.output'
let s:cmd = 'yazi --chooser-file ' . s:output_file

" Define the Yazi command
command! Yazi :call OpenYazi()

" Define the function to open Yazi in a terminal buffer
function! OpenYazi()
  " Use :terminal for Neovim or Vim 8+
  " Adjust the command according to how yazi is executed in your terminal
  " execute 'terminal yazi --chooser-file ' . s:output_file
  call termopen( s:cmd, { 'on_exit': function('s:OnExit') } )
  startinsert
endfunction

function! s:OnExit(job_id, data, event)
    if a:event == 'exit'
        if a:data == 0 && filereadable(s:output_file)
            " read the output file to get the selected file path
            let file_path = join(readfile(s:output_file), "\n")
            " open the file in a new buffer
            execute 'edit ' . file_path
            call delete(s:output_file)
        endif
    endif
endfunction

" autocmd TermClose * if !v:event.status | execute 'bd! ' . expand('<abuf>') | endif

