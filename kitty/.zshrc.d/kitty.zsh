alias ssh="TERM=xterm-256color ssh"
tfix() {
    (export TERM=xterm-256color; $@)
}
