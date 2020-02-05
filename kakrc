# System clipboard handling
# ─────────────────────────

def -override -params 1 require-file %{
    try %sh{
        fpath="$HOME/.config/kak/rc/$1"
        if [ -e "$fpath" ]; then
            echo "source '$fpath'"
        else
            echo "echo -debug 'Could not find $fpath'"
        fi
    }
}

evaluate-commands %sh{
    case $(uname) in
        Linux) copy="xclip -sel clip -i"; paste="xclip -sel clip -o" ;;
        Darwin)  copy="pbcopy"; paste="pbpaste" ;;
    esac

    printf "map global user -docstring 'paste (after) from clipboard' p '!%s<ret>'\n" "$paste"
    printf "map global user -docstring 'paste (before) from clipboard' P '<a-!>%s<ret>'\n" "$paste"
    printf "map global user -docstring 'yank to clipboard' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy"
    printf "map global user -docstring 'cut to clipboard' d '<a-|>%s<ret>d:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy"
    printf "map global user -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
}

map global user -docstring 'Search for selected tag' c "<a-i>w:ctags-search<ret>"
map global user -docstring 'Search for selected tag' * "<a-i>w*<ret>"
map global user -docstring 'Grep for selection' g "<a-i>w:grep -R <c-r>. .<ret>"

# Complete with Tab
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

require-file "filetree/filetree.kak"     # filetree listing
require-file "hlinbrace/hlinbrace.kak"   # highlight in braces
require-file "fzf/rc/fzf.kak"            # fuzzy finder
require-file "fzf/rc/modules/fzf-file.kak"   # fzf file chooser
require-file "fzf/rc/modules/fzf-buffer.kak" # switching buffers with fzf
require-file "fzf/rc/modules/fzf-search.kak" # search within file contents
require-file "fzf/rc/modules/fzf-cd.kak"     # change server's working directory
require-file "fzf/rc/modules/fzf-ctags.kak"  # search for tag in your project ctags file
require-file "fzf/rc/modules/fzf-vcs.kak"     # search for file in vcs index
require-file "fzf/rc/modules/VCS/fzf-git.kak" # search for file in git index

try %{
    require-module fzf
    set-option global fzf_file_command "find . \( -path '*/.svn*' -o -path '*/.git*' \) -prune -o -type f -print"
    map global user -docstring 'Enter fuzzy find mode' f ":fzf-mode<ret>"
}

# 4-Wide Tabs
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
set global tabstop 4
set global indentwidth 4

hook global KakBegin .* %{
    evaluate-commands %sh{
        path="$PWD"
        while [ "$path" != "$HOME" ] && [ "$path" != "/" ]; do
            if [ -e "./tags" ]; then
                printf "%s\n" "set-option -add current ctagsfiles %{$path/tags}"
                printf "%s\n" "ctags-enable-autocomplete"
                break
            else
                cd ..
                path="$PWD"
            fi
        done
    }
}

hook global BufCreate .*\.s(32|64|)$ %{
    set-option buffer filetype gas
}

def rc-dirlocal %{
    try %{ source "./.kakrc.local" }
}

def rc-userlocal %{
    try %{ source "~/.config/kak/kakrc" }
}

def ide %{
    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs

    rc-dirlocal
}

hook global WinCreate .* %{
    evaluate-commands %sh{
        [ -n $TERMINAL ] && [ -z $TMUX ] && [ -z $SSH_SESSION ] &&
        printf 'set-option window termcmd "%s"\n' "$TERMINAL -e"
    }
}
