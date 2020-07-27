declare-option range-specs show_in_braces
define-command hlinbrace %{
    set-option window show_in_braces "%val{timestamp}"
    evaluate-commands -draft -itersel %{ try %{
        execute-keys '<a-a>B<a-S>'
        evaluate-commands -itersel %{
            set-option -add window show_in_braces "%val{selection_desc}|MatchingChar"
        }
    }}
}
add-highlighter global/ ranges show_in_braces
hook global NormalIdle .* %{ hlinbrace }
hook global InsertIdle .* %{ hlinbrace }
