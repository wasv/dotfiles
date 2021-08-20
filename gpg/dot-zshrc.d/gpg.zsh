# Fixes GPG Pinentry issues
if [ -n $SSH_CONNECTION ]; then
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="/run/user/1000/gnupg/S.gpg-agent.ssh"
fi
