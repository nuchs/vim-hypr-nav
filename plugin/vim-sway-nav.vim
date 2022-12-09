" vim-sway-nav.vim -- Use sway's focus direction bindings to move between vim
" splits as well. Requires the accompanying helper script.
"
" Inspired by https://github.com/christoomey/vim-tmux-navigator.

let clientserver = has("nvim") || has("clientserver")
if exists("g:loaded_vim_sway_nav") || empty($SWAYSOCK) || !clientserver
    finish
endif
let g:loaded_vim_sway_nav = 1

function s:setup()
    " Ensure we are running a server.
    if empty(v:servername) && !has("nvim")
        call remote_startserver(rand())
    endif

    " Create a file so the helper script knows how to send a command.
    let runtime_dir = empty($XDG_RUNTIME_DIR) ? "/tmp" : $XDG_RUNTIME_DIR
    let s:servername_file = runtime_dir . "/vim-sway-nav." . getpid() . ".servername"
    let program = has("nvim") ? "nvim" : "vim"
    call writefile([program . " " . v:servername], s:servername_file)
endfunction

" Schedule setup and cleanup.
augroup vim_sway_nav
    autocmd!
    autocmd VimEnter * call s:setup()
    autocmd VimLeavePre * call delete(s:servername_file)
augroup END

" Do some shenanigans to be compatible with jobs in vim and nvim (jobs are
" used instead of system() to avoid starting a shell and running potentially
" slow shell initialization files).
if has("nvim")
    function! s:job(cmd)
        return jobstart(a:cmd)
    endfunction
else
    function! s:job(cmd)
        return job_start(a:cmd)
    endfunction
endif

" Function to be called remotely by the helper script.
function VimSwayNav(dir)
    let l:dir_flag = get({"left": "h", "down": "j", "up": "k", "right": "l"}, a:dir)
    if winnr(l:dir_flag) == winnr()
        call s:job(["swaymsg", "focus", a:dir])
    else
        execute "wincmd " . l:dir_flag
    endif
endfunction
