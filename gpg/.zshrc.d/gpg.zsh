# Fixes GPG Pinentry issues
if [ -n $SSH_CONNECTION ]; then
    export GPG_TTY=$(tty)
fi
