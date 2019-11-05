# System clipboard handling
# ─────────────────────────
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

map global user -docstring 'Enter fuzzy find mode' f ":fzf-mode<ret>"
map global user -docstring 'Search for selected tag' c "<a-i>w:ctags-search<ret>"
map global user -docstring 'Search for selected tag' * "<a-i>w*<ret>"
# Complete with Tab
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

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

def dirlocal %{
    try %{ source .kakrc.local }
}

def ide %{
    rename-client main
    set global jumpclient main

    new rename-client tools
    set global toolsclient tools

    new rename-client docs
    set global docsclient docs

    dirlocal
}
