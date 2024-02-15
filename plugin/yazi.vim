" Check if the command already exists to avoid redefinition
if exists(":Yazi")
  finish
endif

" Define the Yazi command
command! Yazi :call OpenYazi()

" Define the function to open Yazi in a terminal buffer
function! OpenYazi()
  " Use :terminal for Neovim or Vim 8+
  " Adjust the command according to how yazi is executed in your terminal
  execute 'terminal yazi'
endfunction

