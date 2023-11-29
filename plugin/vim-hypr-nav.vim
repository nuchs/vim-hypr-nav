" vim-hypr-nav.vim -- Use hyprland's focus direction bindings to move between vim
" splits as well. Requires the accompanying helper script.
"
" Shamlessly hacked from https://git.sr.ht/~jcc/vim-sway-nav

let clientserver = has("nvim") || has("clientserver")
if exists("g:loaded_vim_hypr_nav") || empty($HYPRLAND_INSTANCE_SIGNATURE) || !clientserver
    finish
endif
let g:loaded_vim_hypr_nav = 1

function s:setup()
    " Ensure we are running a server.
    if empty(v:servername) && !has("nvim")
        call remote_startserver(string(rand()))
    endif

    " Create a file so the helper script knows how to send a command.
    let runtime_dir = empty($XDG_RUNTIME_DIR) ? "/tmp" : $XDG_RUNTIME_DIR
    let s:servername_file = runtime_dir . "/vim-hypr-nav." . getpid() . ".servername"
    let program = has("nvim") ? "nvim" : "vim"
    call writefile([program . " " . v:servername], s:servername_file)
endfunction

" Schedule setup and cleanup.
augroup vim_hypr_nav
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
function VimHyprNav(dir)
    let l:dir_flag = get({"l": "h", "d": "j", "u": "k", "r": "l"}, a:dir)
    if winnr(l:dir_flag) == winnr()
        call s:job(["hyprctl", "dispatch", "movefocus", a:dir])
    else
        execute "wincmd " . l:dir_flag
    endif
endfunction
