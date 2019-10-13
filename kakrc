hook global InsertChar q %{ try %{
  exec -draft h2H <a-k>jkq<ret> d
  exec <esc>
}}

# System clipboard handling
# ─────────────────────────
evaluate-commands %sh{
    case $(uname) in
        Linux) copy="xclip -i"; paste="xclip -o" ;;
        Darwin)  copy="pbcopy"; paste="pbpaste" ;;
    esac

    [ -n `which xclip` ] || exit

    printf "map global normal -docstring 'paste (after) from clipboard' p '!%s<ret>'\n" "$paste"
    printf "map global normal -docstring 'paste (before) from clipboard' P '<a-!>%s<ret>'\n" "$paste"
    printf "map global normal -docstring 'yank to clipboard' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy"
    printf "map global normal -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
}

# Complete with Tab
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
